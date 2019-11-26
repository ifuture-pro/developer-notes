Rabbit MQ
-------------------

主要解决的系统中的：异步，解耦，缓冲，消息分发。  


## 基本安装

```bash
apt-get install -y rabbitmq-server
#enable management UI
rabbitmq-plugins enable rabbitmq_management

systemctl restart rabbitmq-server
#show available uses
rabbitmqctl list_users
rabbitmqctl list_permissions
rabbitmqctl add_user username password
rabbitmqctl set_permissions -p "/" username ".*" ".*" ".*"

http://localhost:15672/
guest/guest
```

## 消息确认 ACK 机制
* 消息发送确认

```yaml
spring:
  rabbitmq:
    publisher-confirms: true
    publisher-returns: true
```

```java
@Component
public class RebbitConfig implements RabbitTemplate.ReturnCallback, RabbitTemplate.ConfirmCallback {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    public void init(){
        rabbitTemplate.setReturnCallback(this);//消息从交换器发送到对应队列失败时触发
        rabbitTemplate.setConfirmCallback(this);//消息发送到交换器Exchange后触发回调
    }

    @Override
    public void returnedMessage(Message message, int replyCode, String replyText, String exchange, String routingKey) {
        //TODO
    }

    @Override
    public void confirm(CorrelationData correlationData, boolean ack, String cause) {
        //TODO
    }
}
```

* 消息送达确认

AcknowledgeMode.NONE：不确认  
AcknowledgeMode.AUTO：自动确认  
AcknowledgeMode.MANUAL：手动确认  

```yaml
spring: 
  rabbitmq:
    listener:
      direct:
        acknowledge-mode: manual
      simple:
        acknowledge-mode: manual
```

```java
    @RabbitListener(queues = CustomCallbackVO.MQ_ROUTER_KEY)
    @Async
    public void engineCallback(Channel channel
            , @Header(name = "amqp_deliveryTag") long deliveryTag
            , CustomCallbackVO vo){
        /**
        * 可能会出现死循环：比如：一直无法正常处理抛出异常。
        * 可以考虑：
        * 1、异常类型来选择是否重新放入队列
        * 2、先成功确认，然后通过channel.basicPublish()重新发布这个消息，将消息放置队尾
        */
        if (调用处理逻辑，正常处理?) {
            channel.basicAck(deliveryTag,false);
        }else {
            channel.basicReject(deliveryTag,true);
        }
    }
```

## 消息持久化
需要在崩溃的 RabbitMQ 中恢复消息，需要做消息持久化
需要分别持久化：交换器；队列；消息

```java
channel.exchangeDeclare(EXCHANGE_NAME, EXCHANGE_TYPE, true);
channel.queueDeclare(QUEUE_NAME, true);
channel.basicPublish("", queue_name, MessageProperties.PERSISTENT_TEXT_PLAIN, message.getBytes());
```

在 spring-boot-starter-amqp 默认使用 rabbit
```java
new TopicExchange(name, durable, autoDelete);
new Queue(name, durable, exclusive, autoDelete);
```