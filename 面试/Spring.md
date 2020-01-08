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
