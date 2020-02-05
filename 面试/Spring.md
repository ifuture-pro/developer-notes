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
