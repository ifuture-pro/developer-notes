Rabbit MQ
-------------------

主要解决的系统中的：异步，解耦，缓冲，消息分发。  

## 关键字
* **Producer**: 消息发送者，就是投递消息的程序。
* **RabbitMQ**:
    * Vhost: 虚拟主机，相当于分组，每个vhost下数据是隔离的
    * Exchange: 消息交换机，接收消息，本根据RoutingKey分发消息
        * headers：消息头类型 路由器，内部应用
        * direct：精准匹配类型 路由器
        * topic：主题匹配类型 路由器，支持正则 模糊匹配
        * fanout：广播类型 路由器，RoutingKey无效
    * RoutingKey: 路由规则，exchange根据这个关键字进行消息投递。
    * Queue: 队列，用于存储消息
    * Binding：绑定，它的作用就是把exchange和queue按照路由规则绑定起来。
    * Broker：即消息队列服务器实体
    * channel：消息通道，在客户端的每个连接里，可建立多个channel，每个channel代表一个会话任务。
* **Consumer**: 消息消费者，就是接受消息的程序。


## 基本安装

```bash
apt-get install -y rabbitmq-server
#enable management UI
rabbitmq-plugins enable rabbitmq_management

systemctl restart rabbitmq-server

rabbitmqctl list_users
rabbitmqctl add_user username password
rabbitmqctl change_password username newpassword
rabbitmqctl delete_user username

rabbitmqctl list_permissions
rabbitmqctl set_permissions -p "/" username ".*" ".*" ".*"
rabbitmqctl set_permissions -p /vhost1  username 'conf' 'write' 'read'
rabbitmqctl set_user_tags username administrator
  # Tag: none、management、policymaker、monitoring、administrator


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

    @PostConstruct
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

Producer Client
```java
    @RabbitListener(queues = CustomCallbackVO.MQ_ROUTER_KEY)
    @Async
    public void engineCallback(Channel channel
            , @Header(name = AmqpHeaders.DELIVERY_TAG) long deliveryTag
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

在 `org.springframework.boot:spring-boot-starter-amqp` 默认使用 rabbit
```java
new TopicExchange(name, durable, autoDelete);
new Queue(name, durable, exclusive, autoDelete);

// Consumer client
@RabbitListener(
            bindings = @QueueBinding(
                    value = @Queue(value = "zzz-queue", durable = "true"),
                    exchange = @Exchange(value = "zzz-exchange", durable = "true", type = "topic"),
                    key = "routingkey-zzz"
            )
    )
@RabbitHandler
public void consumer(@Payload String msg, Channel channel, @Headers Map<String, Object> headers) {
    System.out.println(msg);
    Long tag = (Long) headers.get(AmqpHeaders.DELIVERY_TAG);
}

```

## 高可用

* 普通模式
    > 默认的集群模式，以两个节点（rabbit01、rabbit02）为例来进行说明。对于 Queue 来说，消息实体只存在于其中一个节点 rabbit01（或者 rabbit02），rabbit01 和 rabbit02 两个节点仅有相同的元数据，即队列的结构。当消息进入 rabbit01 节点的 Queue 后，consumer 从 rabbit02 节点消费时，RabbitMQ 会临时在 rabbit01、rabbit02 间进行消息传输，把 A 中的消息实体取出并经过 B 发送给 consumer。所以 consumer 应尽量连接每一个节点，从中取消息。即对于同一个逻辑队列，要在多个节点建立物理 Queue。否则无论 consumer 连 rabbit01 或 rabbit02，出口总在 rabbit01，会产生瓶颈。当 rabbit01 节点故障后，rabbit02 节点无法取到 rabbit01 节点中还未消费的消息实体。如果做了消息持久化，那么得等 rabbit01 节点恢复，然后才可被消费；如果没有持久化的话，就会产生消息丢失的现象。  
* 镜像模式
    >将需要消费的队列变为镜像队列，存在于多个节点，这样就可以实现 RabbitMQ 的 HA 高可用性。作用就是消息实体会主动在镜像节点之间实现同步，而不是像普通模式那样，在 consumer 消费数据时临时读取。缺点就是，集群内部的同步通讯会占用大量的网络带宽。  


Official Docs [Highly Available (Mirrored) Queues](https://www.rabbitmq.com/ha.html)

server1
```
# /etc/hosts
192.168.1.101 server1
192.168.1.102 server2

# /etc/rabbitmq/rabbitmq-env.conf
NODENAME=rabbit@server1
```

server2
```
# /etc/hosts
192.168.1.101 server1
192.168.1.102 server2

# /etc/rabbitmq/rabbitmq-env.conf
NODENAME=rabbit@server2
```

```
z@zzz:~$ hostnamectl status
   Static hostname: zzz
         Icon name: computer-laptop
           Chassis: laptop
        Machine ID:
           Boot ID:
  Operating System: Ubuntu 18.04.3 LTS
            Kernel: Linux 4.15.0-71-generic
      Architecture: x86-64
z@zzz:~$ hostnamectl --static set-hostname node1
```

修改所有节点的`/var/lib/rabbitmq/.erlang.cookie`内容一致。这是 RabbitMQ 集群通信的验证机制  
或创建 cookie 文件
```
mkdir ~/.erlang.cookie
echo 'SMQBUJBXOKFIOYUTPUDM' > ~/.erlang.cookie
chmod 400 ~/.erlang.cookie

chmod rabbitmq:rabbitmq .erlang.cookie
```

```
rabbitmqctl stop
#后台启动服务
rabbitmq-server -detached

rabbitmqctl -n rabbit@server2 stop_app

# 重置元数据、集群配置等信息
#rabbitmqctl -n rabbit@server2 reset

# cluster2 加入到 server1 的集群中
# ram表示server2为RAM节点 默认为disc
rabbitmqctl -n rabbit@server2 join_cluster rabbit@server1 --ram

rabbitmqctl -n rabbit@server2 start_app

#查看集群状态
rabbitmqctl cluster_status

开启镜像集群策略
rabbitmqctl set_policy   ha-all "^" '{"ha-mode":"all"}'
rabbitmqctl set_policy <name> [-p <vhost>] <pattern> <definition> [--apply-to <apply-to>]
    name: 策略名称
    vhost: 指定vhost, 默认值 /
    pattern: 需要镜像的正则
    definition:
        ha-mode: 指明镜像队列的模式，有效值为：
            all     表示在集群所有的节点上进行镜像，无需设置ha-params
            exactly 表示在指定个数的节点上进行镜像，节点的个数由ha-params指定
            nodes   表示在指定的节点上进行镜像，节点名称通过ha-params指定
        ha-params: ha-mode 模式需要用到的参数
        ha-sync-mode: 镜像队列中消息的同步方式，有效值为automatic，manually
    apply-to: 可选值3个，默认all
        exchanges 表示镜像 exchange
        queues    表示镜像 queue
        all       表示镜像 exchange和queue


```
* RAM node：内存节点将所有的队列、交换机、绑定、用户、权限和 vhost 的元数据定义存储在内存中，好处是可以使得像交换机和队列声明等操作更加的快速。
* Disk node：将元数据存储在磁盘中，单节点系统只允许磁盘类型的节点，防止重启 RabbitMQ 的时候，丢失系统的配置信息。  
推荐 2 RAM 1 DISC 集群搭建方式

### Spring boot

如果用 spring 的其实也可以直接配置
```yaml
spring:
  rabbitmq:
    addresses: amqp://username:password@server1:5672,amqp://username:password@server2:5672
    port: 5672
    username: your_username #用户名密码一样的话也可以在这配置(理论上是一样的，因为集群完后用户也会同步，所以在大多数情况下，addresses 只需要写ip地址用逗号分隔即可)
    password: your_password

```
很多地方文档写的不是很清楚或不全，其实对于这些优秀的开源项目来说，源码就是最好的文档  
详细配置可以看`org.springframework.boot.autoconfigure.amqp.RabbitProperties.java`


### HAProxy

/etc/haproxy/haproxy.cfg
```
global
    log     127.0.0.1  local0 info
    log     127.0.0.1  local1 notice
    daemon
    maxconn 4096

defaults
    log     global
    mode    tcp
    option  tcplog
    option  dontlognull
    retries 3
    option  abortonclose
    maxconn 4096
    timeout connect  5000ms
    timeout client  3000ms
    timeout server  3000ms
    balance roundrobin

listen private_monitoring
    bind    0.0.0.0:8100
    mode    http
    option  httplog
    stats   refresh  5s
    stats   uri  /stats
    stats   realm   Haproxy
    stats   auth  admin:admin

listen rabbitmq_admin
    bind    0.0.0.0:8102
    server  server1 server1:15672
    server  server2 server2:15672

listen rabbitmq_cluster
    bind    0.0.0.0:8101
    mode    tcp
    option  tcplog
    balance roundrobin
    timeout client  3h
    timeout server  3h
    server  server1  server1:5672  check  inter  5000  rise  2  fall  3
    server  server2  server2:5672  check  inter  5000  rise  2  fall  3
```
* http://localhost:8100/stats HAProxy 负载均衡信息地址，账号密码：admin/admin。
* http://localhost:8101 RabbitMQ Server Web 管理界面
* http://localhost:8102 RabbitMQ Server 服务地址
