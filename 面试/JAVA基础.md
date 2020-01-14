## Java 对象初始化

创建 class Y 的执行顺序及对应字段值
```java

// class x
public class X {
	protected int xMask = 0x00ff;
	protected int fullMask;

	public X() {
		fullMask = xMask;
	}

	public int mask(int origin) {
		return (origin & fullMask);
	}

}

// class y
class Y extends X {

	protected int yMask = 0xff00;

	public Y() {
		fullMask |= yMask;
	}

}

```

![java bean](../assets/img/javabean.png)


## 类加载机制
类加载过程可以分为 **加载，连接，初始化**。  
1. **加载**  
	将类如 class 文件读取到内存，比为之创建 `java.lang.Class` 对象。
2. **链接**  
	链接过程负责对二进制字节码的格式进行校验、初始化装载类中的静态变量以及解析类中调用的接口、类。在完成了校验后，JVM初始化类中的静态变量，并将其值赋为默认值。最后一步为对类中的所有属性、方法进行验证，以确保其需要调用的属性、方法存在，以及具备应的权限（例如public、private域权限等），会造成NoSuchMethodError、NoSuchFieldError等错误信息。
	* **校验** – 字节码校验器会校验生成的字节码是否正确，如果校验失败，我们会得到校验错误。
	> **文件格式验证**：主要验证字节流是否符合Class文件格式规范，并且能被当前的虚拟机加载处理。  
	> **元数据验证**：对字节码描述的信息进行语义的分析，分析是否符合java的语言语法的规范。  
	> **字节码验证**：最重要的验证环节，分析数据流和控制，确定语义是合法的，符合逻辑的。主要的针对元数据验证后对方法体的验证。保证类方法在运行时不会有危害出现。  
	> **符号引用验证**：主要是针对符号引用转换为直接引用的时候，是会延伸到第三解析阶段，主要去确定访问类型等涉及到引用的情况，主要是要保证引用一定会被访问到，不会出现类等无法访问的问题。

	* **准备** – 分配内存并初始化默认值给所有的静态变量。
	* **解析** – 所有符号内存引用被方法区(Method Area)的原始引用所替代。

3. **初始化**
初始化过程即为执行类中的静态初始化代码、构造器代码以及静态属性的初始化，在四种情况下会触发执行初始化过程。
	* 调用了new关键字
	* 类字面常量
	* 反射调用了类中的方法
	* 子类调用了初始化
	* JVM启动过程中指定的初始化类

### 类加载器
* 启动类加载器（Bootstrap ClassLoader）：<JAVA_HOME>/lib
* 扩展类加载器（Extension ClassLoader）：<JAVA_HOME>/lib/ext
* 应用程序类加载器（Application ClassLoader）：加载用户类路径上所指定的类库, -classpath

类加载器加载Class大致要经过如下8个步骤：  
1. 检测此Class是否载入过，即在缓冲区中是否有此Class，如果有直接进入第8步，否则进入第2步。
1. 如果没有父类加载器，则要么Parent是根类加载器，要么本身就是根类加载器，则跳到第4步，如果父类加载器存在，则进入第3步。
1. 请求使用父类加载器去载入目标类，如果载入成功则跳至第8步，否则接着执行第5步。
1. 请求使用根类加载器去载入目标类，如果载入成功则跳至第8步，否则跳至第7步。
1. 当前类加载器尝试寻找Class文件，如果找到则执行第6步，如果找不到则执行第7步。
1. 从文件中载入Class，成功后跳至第8步。
1. 抛出ClassNotFountException异常。
1. 返回对应的java.lang.Class对象。

**全盘负责**：所谓全盘负责，就是当一个类加载器负责加载某个Class时，该Class所依赖和引用其他Class也将由该类加载器负责载入，除非显示使用另外一个类加载器来载入。  
**双亲委派**：所谓的双亲委派，则是先让父类加载器试图加载该Class，只有在父类加载器无法加载该类时才尝试从自己的类路径中加载该类。通俗的讲，就是某个特定的类加载器在接到加载类的请求时，首先将加载任务委托给父加载器，依次递归，如果父加载器可以完成类加载任务，就成功返回；只有父加载器无法完成此加载任务时，才自己去加载。  
采用双亲委派模式的是好处是Java类随着它的类加载器一起具备了一种带有优先级的层次关系，通过这种层级关可以避免类的重复加载，当父亲已经加载了该类时，就没有必要子ClassLoader再加载一次。其次是考虑到安全因素，java核心api中定义类型不会被随意替换，假设通过网络传递一个名为java.lang.Integer的类，通过双亲委托模式传递到启动类加载器，而启动类加载器在核心Java API发现这个名字的类，发现该类已被加载，并不会重新加载网络传递的过来的java.lang.Integer，而直接返回已加载过的Integer.class，这样便可以防止核心API库被随意篡改。  
**缓存机制**:缓存机制将会保证所有加载过的Class都会被缓存，当程序中需要使用某个Class时，类加载器先从缓存区中搜寻该Class，只有当缓存区中不存在该Class对象时，系统才会读取该类对应的二进制数据，并将其转换成Class对象，存入缓冲区中。这就是为很么修改了Class后，必须重新启动JVM，程序所做的修改才会生效的原因。




## 打印JAVA信息
`java -XX:+PrintCommandLineFlags --version`

## List集合，多线程计算总和
1、使其在 Java8 之后 使用 stream api 最简单
```java
List.parallelStream().mapToDouble(value -> value).sum();
```
2、使用 FutureTask 将任务分解后合并

## List 去重
1、Java8 stream api
```java
list.stream().distinct().collect(Collectors.toList());
```
2、转换成 set 去重
```java
newSet = Set.addAll(list)//使用 HashSet 天然去重
newList.addAll(newSet)//将去重后的 Set 重新转换成 List
```
## 三个线程顺序打印ABC
感觉并没有什么优雅的方式，无非就是有个标志，每个线程不断获取标志，轮到自己了就执行。
* synchronized, wait和notifyAll
* Lock->ReentrantLock 和 state标志
* Semaphore
* AtomicInteger

## 画一下RPC的架构图
![rpc](../assets/img/rpc.jpg)

## 锁
### synchronized
字节码 `monitorenter` `monitorexit`

//TODO

### CAS
Compare And Swap | Compare And Exchange | 自旋锁 | 无锁
常见问题：ABA问题。可以版本号去解决
CPU指令：lock cmpxchg

## 对象在内存中的存储布局
```java
java.lang.Object object internals:
 OFFSET  SIZE   TYPE DESCRIPTION                               VALUE
      0     4        (object header)                           05 00 00 00 (00000101 00000000 00000000 00000000) (5)
      4     4        (object header)                           00 00 00 00 (00000000 00000000 00000000 00000000) (0)
      8     4        (object header)                           00 10 00 00 (00000000 00010000 00000000 00000000) (4096)
     12     4        (loss due to the next object alignment)
Instance size: 16 bytes
Space losses: 0 bytes internal + 4 bytes external = 4 bytes total
```

```java
// JOL(java object layout) java对象内存布局
<dependency>
		<groupId>org.openjdk.jol</groupId>
		<artifactId>jol-core</artifactId>
		<version>0.9</version>
</dependency>

System.out.println(org.openjdk.jol.info.ClassLayout.parseInstance(new Object()).toPrintable());
```

HotSpot 虚拟机对象头包含 Mark Word（标记字段）和 Klass Pointer（类型指针）  
MarkWord 用于存储对象自身的运行时数据，如哈希码（HashCode）、GC分代年龄、锁状态标志、线程持有的锁、偏向线程 ID、偏向时间戳等等

## Java内存模型
* 原子性
* 可见性
* 有序性

### happens-before原则（先行发生原则）

* 程序次序规则：一个线程内，按照代码顺序，书写在前面的操作先行发生于书写在后面的操作
* 锁定规则：一个 unLock 操作先行发生于后面对同一个锁额 lock 操作
* `volatile` 变量规则：对一个变量的写操作先行发生于后面对这个变量的读操作
* 传递规则：如果操作A先行发生于操作B，而操作B又先行发生于操作C，则可以得出操作A先行发生于操作C
* 线程启动规则：Thread对象的 `start()` 方法先行发生于此线程的每个一个动作
* 线程中断规则：对线程 `interrupt()` 方法的调用先行发生于被中断线程的代码检测到中断事件的发生
* 线程终结规则：线程中所有的操作都先行发生于线程的终止检测，我们可以通过 `Thread.join()` 方法结束、`Thread.isAlive()` 的返回值手段检测到线程已经终止执行
* 对象终结规则：一个对象的初始化完成先行发生于他的 `finalize()` 方法的开始


## 序列化

**全部序列化 `implements Serializable`**

* 变量被 `transient` 修饰，将不被序列化，只能修饰变量
* 静态变量不会被序列化。  反序列化后 static 变量值为jvm中的值，并非反序列化后的值。

**局部序列化 `implements Externalizable`**

  只有被 `writeExternal` `readExternal` 写入与读取的变量会被序列化，不管是否有 `transient` 关键字修饰



## IO
### 零拷贝
零拷贝指计算机操作的过程中，CPU不需要为数据在内存之间的拷贝消耗资源。而它通常是指计算机在网络上发送文件时，不需要将文件内容拷贝到用户空间（User Space）而直接在内核空间（Kernel Space）中传输到网络的方式。  
它属于操作系统层面的技术，具体支持与否看对应的操作系统，虽然取决于操作系统的实现，但操作系统中实现了，在软件开发中不调用对应的指令也无法达到"零拷贝"

Copying bytes from a file to a socket
```java
File.read(fileDesc, buf, len);
Socket.send(socket, buf, len);
```
需要经过四次拷贝和用户态与内核态的上下文切换。
> 1、应用程序中调用 read() 方法，内核通过sys_read()（不同操作系统指令不同）。**第一次上下文切换（用户态->内核态）**，底层采用DMA（direct memory access）读取磁盘的文件，并把内容存储到内核地址空间的读取缓存区.  
2、由于应用程序无法访问内核地址空间的数据，如果应用程序要操作这些数据，得把这些内容从读取缓冲区拷贝到用户缓冲区。**第二次上下文切换（内核态->用户态）**,现在待读取的数据已经存储在用户空间内的缓冲区。这里其实可以对文件进行修改。  
3、**第三次上下文切换（用户态->内核态）**。拷贝数据从用户空间重新拷贝到内核空间缓冲区。但是，这一次，数据被写入一个不同的缓冲区，一个与目标套接字相关联的缓冲区。  
4、**第四次上下文切换（内核态->用户态）**。当DMA引擎将数据从内核缓冲区传输到协议引擎缓冲区时，第四次拷贝是独立且异步的  

![Traditional data copying approach](https://developer.ibm.com/developer/articles/j-zerocopy/images/figure1.gif)  

过程1和4是由DMA负责，并不会消耗CPU，只有过程2和3的拷贝需要CPU参与

当请求的数据大于内核缓冲区大小时这种方法往往会成为性能瓶颈。数据在最终被发送之前，在磁盘，内核缓冲区和用户缓冲区之间发生多次拷贝。零拷贝通过减少不必要的数据拷贝以提高性能。  
第二次和第三次数据拷贝并不是真的需要。应用程序除了缓存数据然后将数据传回套接字缓冲区外没有做任何事情。数据可以直接从内核的读缓冲区传输到套接字缓冲区。

NIO and transferTo
```java
SocketChannel sc = SocketChannel.open();
sc.connect(new InetSocketAddress(SERVER_ADDRESS, SERVER_PORT));
sc.configureBlocking(true);

FileChannel fc = new FileInputStream(FILE_PATH).getChannel();
fc.transferTo(0, FILE_SIZE, sc);
```

上下文切换的次数从四次减少到了两次
拷贝次数从四次减少到了三次（其中DMA 2次，CPU 1次）  

![Data copy with transferTo()](https://developer.ibm.com/developer/articles/j-zerocopy/images/figure3.gif)

如果底层网卡支持gather operations，可以进一步减少内核拷贝数据的次数。Linux 内核 从2.4 版本开始修改了套接字缓冲区描述符以满足这个要求。这种方法不仅减少了多个上下文切换，还消除了消耗CPU的重复数据拷贝。用户使用的方法没有任何变化，属于操作系统内部实现。  
> 1、transferTo() 方法使用 DMA 将文件内容拷贝到内核读取缓冲区。  
2、避免了内容的整体拷贝，只把包含数据位置和长度信息的描述符追加到套接字缓冲区，DMA 引擎直接把数据从内核缓冲区传到协议引擎，从而消除了最后一次 CPU参与的拷贝动作

![Data copies when transferTo() and gather operations are used](https://developer.ibm.com/developer/articles/j-zerocopy/images/figure5.gif)


> 参考：https://developer.ibm.com/articles/j-zerocopy/
