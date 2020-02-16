## Spring 问答

### Spring Bean 生命周期

1. **实例化 Instantiation**
2. **属性赋值 Populate**

  3. BeanNameAware
  4. BeanFactoryAware, ApplicationContextAware
  5. BeanPostProcessor#postProcessBeforeInitialization
  6. InitializingBean#afterPropertiesSet
  7. @PostConstruct
3. **初始化 Initialization**
  8. BeanPostProcessor#postProcessAfterInitialization
  9. DisposableBean
  10. @PreDestroy
4. **销毁 Destruction**
  > `ConfigurableApplicationContext#close()`
  > `((AbstractApplicationContext)context).registerShutdownHook(); ` 此代码将注册 jvm系统钩子 `Runtime.getRuntime().addShutdownHook(...)`

> 主线生命周期参考源码  
```
org.springframework.beans.factory.support.AbstractAutowireCapableBeanFactory
doCreateBean
createBean
```

![spring](../assets/img/springinit.webp)


### PostConstruct,PreDestroy 实现原理
在 xml 配置中这两个注解分别对应 init-method， destory-method

Constructor > @Autowired > @PostConstruct

具体参考 [Spring Bean 生命周期](#Spring-Bean-生命周期) 源码参考部分

### Spring 事务隔离级别与传播机制
#### 事务传播机制
```
@Transactional(propagation=Propagation.REQUIRED)
```
* REQUIRED : 如果有事务则加入事务，如果没有事务，则创建一个新的（默认值）
* NOT_SUPPORTED : Spring不为当前方法开启事务，相当于没有事务
* REQUIRES_NEW : 不管是否存在事务，都创建一个新的事务，原来的方法挂起，新的方法执行完毕后，继续执行老的事务
* MANDATORY : 必须在一个已有的事务中执行，否则报错
* NEVER : 必须在一个没有的事务中执行，否则报错
* SUPPORTS : 如果其他bean调用这个方法时，其他bean声明了事务，则就用这个事务，如果没有声明事务，那就不用事务
* NESTED : 如果当前存在事务，则在嵌套事务内执行。如果当前没有事务，则执行与REQUIRED类似的操作

#### 隔离级别
```
@Transactional(isolation=Isolation.DEFAULT)
```
* ISOLOCATION_DEFAULT:  数据库默认级别。 ORACLE（读已提交） MySQL（可重复读）
* ISOLOCATION_READ_UNCOMMITTED: 允许读取未提交的读， 可能导致脏读，不可重复读，幻读
* ISOLOCATION_READ_COMMITTED:  允许读取已提交的读，可能导致不可重复读，幻读
* ISOLOCATION_REPEATABLE_READ : 不能能更新另一个事务修改单尚未提交(回滚)的数据，可能引起幻读
* ISOLOCATION_SERIALIZABLE: 序列执行效率低


## Spring Security
[SSO OAuth关键概念](../DevOps/SSO.md)
### Spring-Security-OAuth
关键源码位置，结合[官网文档](https://projects.spring.io/spring-security-oauth/docs/oauth2.html)效果更好
#### 授权

* 授权端点 `/oauth/authorize`
```java
org.springframework.security.oauth2.provider.endpoint.AuthorizationEndpoint
```

* 授权确认端点 `/oauth/confirm_access`
```java
org.springframework.security.oauth2.provider.endpoint.WhitelabelApprovalEndpoint
```
  客户端是否自动确认授权取决于 `org.springframework.security.oauth2.providerClientDetails#isAutoApprove`

* 授权失败端点 `/oauth/error`
```java
org.springframework.security.oauth2.provider.endpoint.WhitelabelErrorEndpoint
```

* 自定义上面两个URL
```java
org.springframework.security.oauth2.config.annotation.web.configuration.AuthorizationServerEndpointsConfiguration#authorizationEndpoint
org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerEndpointsConfigurer#pathMapping
```


#### 获得 token
* 获得令牌端点 `/oauth/token`
```java
org.springframework.security.oauth2.provider.endpoint.TokenEndpoint
```
* 生产 Token
```java
org.springframework.security.oauth2.provider.token.AbstractTokenGranter
```

#### 获得 Token Key
返回 JWT具体算法和公钥，如果没有使用 `KeyPair` 直接用 `SigningKey` 将直接这个 `SigningKey` 这是很危险的
* 获得令牌签名（公钥）端点 `/oauth/token_key`
```java
org.springframework.security.oauth2.provider.endpoint.TokenKeyEndpoint
```

#### 验证解析 Token
* 验证解析令牌端点 `/oauth/check_token`
```java
org.springframework.security.oauth2.provider.endpoint.CheckTokenEndpoint
```
  官方文档介绍，主要考虑授权服务与资源服务分开的情况，`RemoteTokenServices` 它将允许资源服务器通过HTTP请求来解码令牌（也就是授权服务的 `/oauth/check_token` 端点）。如果你的资源服务没有太大的访问量的话，那么使用`RemoteTokenServices` 将会很方便（所有受保护的资源请求都将请求一次授权服务用以检验token值），或者你可以通过缓存来保存每一个token验证的结果

* 验证流程
```java
org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationProcessingFilter
```
  从 `header(Bearer Token Header)` 、`query(access_token)` 里获取 token 进行认证处理

#### 异常
* 默认处理
```java
org.springframework.security.oauth2.provider.error.DefaultWebResponseExceptionTranslator
```

* Spring MVC 处理
  `@ExceptionHandler` `HttpMessageConverters`
