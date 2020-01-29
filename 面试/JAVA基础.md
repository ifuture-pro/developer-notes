
## 打印JAVA信息
`java -XX:+PrintCommandLineFlags --version`
```
-XX:G1ConcRefinementThreads=13
-XX:GCDrainStackTargetSize=64
-XX:InitialHeapSize=1073741824
-XX:MaxHeapSize=17179869184
-XX:+PrintCommandLineFlags
-XX:ReservedCodeCacheSize=251658240
-XX:+SegmentedCodeCache
-XX:+UseCompressedClassPointers
-XX:+UseCompressedOops
-XX:+UseG1GC

-XX:PreBlockSpin (设置自旋锁自旋次数（默认是10次）没有成功获得锁，就应当挂起线程)
-XX:+UseSpinning （开启自适应的自旋锁，JDK1.6后默认开启。自适应意味着自旋的时间（次数）不再固定，而是由前一次在同一个锁上的自旋时间及锁的拥有者的状态来决定）
-XX:-UseBiasedLocking （偏向锁开关，JDK1.6默认开启，关闭之后程序默认会进入轻量级锁状态）
-XX:+PrintAssembly 打印汇编指令
-XX:+PrintGCDetails | -XX:+PrintGCTimeStamps | -XX:+PrintHeapAtGC | -Xloggc:log/gc.log | -verbose:gc | -XX:+printGC 打印GC情况
-XX:+TraceClassLoading 类加载监控
-Xmx -Xms 堆大小。如：-Xmx512m
-Xmn             新生代大小。通常为 Xmx 的 1/3 或 1/4。新生代 = Eden + 2 个 Survivor 空间。实际可用空间为 = Eden + 1 个 Survivor，即 90%
-XX:NewRatio     新生代与老年代的比例，如 –XX:NewRatio=2，则新生代占整个堆空间的1/3，老年代占2/3
-XX:SurvivorRatio     新生代中 Eden 与 Survivor 的比值。默认值为 8。即 Eden 占新生代空间的 8/10，另外两个 Survivor 各占 1/10
-XX:MaxTenuringThreshold		进入老年代的年龄数，默认15岁。（如果需要分配一块较大的连续内存空间时（较大对象），直接进入老年代）
-XX:PermSize     永久代(方法区)的初始大小
-XX:MaxPermSize       永久代(方法区)的最大值。JDK1.8中不再有永久代，而使用元数据区替代。（详细可查看本笔记JVM#GC）
-XX:+HeapDumpOnOutOfMemoryError    让虚拟机在发生内存溢出时 Dump 出当前的内存堆转储快照，以便分析用

```

## HashMap
JAVA1.8 HashMap采用 数组+链表+红黑树的方式实现。  
1. **HashMap**：它根据键的hashCode值存储数据，大多数情况下可以直接定位到它的值，因而具有很快的访问速度，但遍历顺序却是不确定的。 HashMap最多只允许一条记录的键为null，允许多条记录的值为null。HashMap非线程安全，即任一时刻可以有多个线程同时写HashMap，可能会导致数据的不一致。如果需要满足线程安全，可以用 Collections的synchronizedMap方法使HashMap具有线程安全的能力，或者使用ConcurrentHashMap。
2. **Hashtable**：Hashtable是遗留类，很多映射的常用功能与HashMap类似，不同的是它承自Dictionary类，并且是线程安全的，任一时间只有一个线程能写Hashtable，并发性不如ConcurrentHashMap，因为ConcurrentHashMap引入了分段锁。Hashtable不建议在新代码中使用，不需要线程安全的场合可以用HashMap替换，需要线程安全的场合可以用ConcurrentHashMap替换。
3. **LinkedHashMap**：LinkedHashMap是HashMap的一个子类，保存了记录的插入顺序，在用Iterator遍历LinkedHashMap时，先得到的记录肯定是先插入的，也可以在构造时带参数，按照访问次序排序。
4. **TreeMap**：TreeMap实现SortedMap接口，能够把它保存的记录根据键排序，默认是按键值的升序排序，也可以指定排序的比较器，当用Iterator遍历TreeMap时，得到的记录是排过序的。如果使用排序的映射，建议使用TreeMap。在使用TreeMap时，key必须实现Comparable接口或者在构造TreeMap传入自定义的Comparator，否则会在运行时抛出java.lang.ClassCastException类型的异常。

### 链表与数组
线性表分为**顺序线性表**和**链表**，也可以理解是数组与链表。  

**数组**:在内存中有序排列。  
* 数组存储区间是连续的，占用内存严重，故空间复杂的很大
* 寻址容易，插入和删除困难

**链表**:不是用顺序实现的，而是指针，在内存中不连续。将一系列不连续的内存联系起来，将那种碎片内存进行合理的利用，解决空间的问题。
* 占用内存比较宽松，故空间复杂度很小，但时间复杂度很大
* 寻址困难，插入和删除容易

	单项链表：![](../assets/img/JAVA-BASE-TABLE-1.bmp)

	双向链表：![](../assets/img/JAVA-BASE-TABLE-2.bmp)

	循环链表：![](../assets/img/JAVA-BASE-TABLE-3.bmp)

### 红黑树
一种自平衡的二叉查找树。
二叉查找树（BST）。分左右子树，左子树小于等于它的根节点，而右子树是大于等于它的根节点。在数据极端的情况下，如：10、9、8、7、6、5、4、3、2、1。这时候二叉查找树就会一直向左发展，红黑树解决了这一问题。  
Java 的 HashMap 中使用高位运算和取模运算 hash 算法获取 key 的 hash 值，即使加上负载因子和Hash算法设计的再合理，也免不了会出现拉链过长的情况，一旦出现拉链过长，则会严重影响HashMap的性能。于是，在JDK1.8版本中，对数据结构做了进一步的优化，引入了红黑树。而当链表长度太长（默认超过8）时，链表就转换为红黑树，利用红黑树快速增删改查的特点提高HashMap的性能。

红黑树的特性：
1. 节点是红色或者黑色
2. 根节点是黑色
3. 每个叶子的节点都是黑色的空节点（NULL）
4. 每个红色节点的两个子节点都是黑色的。
5. 从任意节点到其每个叶子的所有路径都包含相同的黑色节点。

![](../assets/img/JAVA-BASE-TABLE-MAP-PUT.png)

详细：[Java 8系列之重新认识HashMap](https://tech.meituan.com/2016/06/24/java-hashmap.html)

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

## Lock 锁
[![lock](../assets/img/JAVA-BASE-LOCK-INDEX.png)](https://tech.meituan.com/2018/11/15/java-lock.html)

* 无锁  
无锁没有对资源进行锁定，所有的线程都能访问并修改同一个资源，但同时只有一个线程能修改成功。  
无锁的特点就是修改操作在循环内进行，线程会不断的尝试修改共享资源。如果没有冲突就修改成功并退出，否则就会继续循环尝试。如果有多个线程修改同一个值，必定会有一个线程能修改成功，而其他修改失败的线程会不断重试直到修改成功。上面我们介绍的CAS原理及应用即是无锁的实现。无锁无法全面代替有锁，但无锁在某些场合下的性能是非常高的。
* 偏向锁  
偏向锁是指一段同步代码一直被一个线程所访问，那么该线程会自动获取锁，降低获取锁的代价。  
在大多数情况下，锁总是由同一线程多次获得，不存在多线程竞争，所以出现了偏向锁。其目标就是在只有一个线程执行同步代码块时能够提高性能。  
当一个线程访问同步代码块并获取锁时，会在Mark Word里存储锁偏向的线程ID。在线程进入和退出同步块时不再通过CAS操作来加锁和解锁，而是检测Mark Word里是否存储着指向当前线程的偏向锁。引入偏向锁是为了在无多线程竞争的情况下尽量减少不必要的轻量级锁执行路径，因为轻量级锁的获取及释放依赖多次CAS原子指令，而偏向锁只需要在置换ThreadID的时候依赖一次CAS原子指令即可。  
偏向锁只有遇到其他线程尝试竞争偏向锁时，持有偏向锁的线程才会释放锁，线程不会主动释放偏向锁。偏向锁的撤销，需要等待全局安全点（在这个时间点上没有字节码正在执行），它会首先暂停拥有偏向锁的线程，判断锁对象是否处于被锁定状态。撤销偏向锁后恢复到无锁（标志位为“01”）或轻量级锁（标志位为“00”）的状态。
* 轻量级锁  
是指当锁是偏向锁的时候，被另外的线程所访问，偏向锁就会升级为轻量级锁，其他线程会通过自旋的形式尝试获取锁，不会阻塞，从而提高性能。  
在代码进入同步块的时候，如果同步对象锁状态为无锁状态（锁标志位为“01”状态，是否为偏向锁为“0”），虚拟机首先将在当前线程的栈帧中建立一个名为锁记录（Lock Record）的空间，用于存储锁对象目前的Mark Word的拷贝，然后拷贝对象头中的Mark Word复制到锁记录中。  
拷贝成功后，虚拟机将使用CAS操作尝试将对象的Mark Word更新为指向Lock Record的指针，并将Lock Record里的owner指针指向对象的Mark Word。  
如果这个更新动作成功了，那么这个线程就拥有了该对象的锁，并且对象Mark Word的锁标志位设置为“00”，表示此对象处于轻量级锁定状态。  
如果轻量级锁的更新操作失败了，虚拟机首先会检查对象的Mark Word是否指向当前线程的栈帧，如果是就说明当前线程已经拥有了这个对象的锁，那就可以直接进入同步块继续执行，否则说明多个线程竞争锁。  
若当前只有一个等待线程，则该线程通过自旋进行等待。但是当自旋超过一定的次数，或者一个线程在持有锁，一个在自旋，又有第三个来访时，轻量级锁升级为重量级锁。
* 重量级锁  
升级为重量级锁时，锁标志的状态值变为“10”，此时Mark Word中存储的是指向重量级锁的指针，此时等待锁的线程都会进入阻塞状态。

* 独享锁  
独享锁也叫排他锁，是指该锁一次只能被一个线程所持有。如果线程T对数据A加上排它锁后，则其他线程不能再对A加任何类型的锁。获得排它锁的线程即能读数据又能修改数据。JDK中的synchronized和JUC中Lock的实现类就是互斥锁。
* 共享锁  
共享锁是指该锁可被多个线程所持有。如果线程T对数据A加上共享锁后，则其他线程只能对A再加共享锁，不能加排它锁。获得共享锁的线程只能读数据，不能修改数据。  
独享锁与共享锁也是通过AQS来实现的，通过实现不同的方法，来实现独享或者共享。

### synchronized
悲观锁 | 非公平锁  
锁实现机制：监视器模式  
字节码 `monitorenter` `monitorexit`

### ReentrantLock
悲观锁  
锁实现机制：依赖AQS（AbstractQueuedSynchronizer）


### CAS
Compare And Swap | Compare And Exchange | 自旋锁 | 无锁 | 乐观锁 | 公平&非公平锁

CPU指令：lock cmpxchg

常见问题：  
* ABA问题。可以版本号，时间戳等方法去解决。  
JAVA1.5后提供了`AtomicStampedReference.java`解决ABA问题，可以参考。
* 只能保证一个共享变量的原子操作。对一个共享变量执行操作时，CAS能够保证原子操作，但是对多个共享变量操作时，CAS是无法保证操作的原子性的。  
Java从1.5开始JDK提供了`AtomicReference`类来保证引用对象之间的原子性，可以把多个变量放在一个对象里来进行CAS操作。
* 循环时间长开销大。CAS操作如果长时间不成功，会导致其一直自旋，给CPU带来非常大的开销。

### AQS
`java.util.concurrent.locks.AbstractQueuedSynchronizer` 是JUC(java.util.concurrent) 下面诸多同步工具（ReentrantLock，Semaphore）的基础实现类。明白AQS你可以轻松实现一个同步工具。

|同步工具|	与AQS的关联|
|-------|------|
|ReentrantLock|	使用AQS保存锁重复持有的次数。当一个线程获取锁时，ReentrantLock记录当前获得锁的线程标识，用于检测是否重复获取，以及错误线程试图解锁操作时异常情况的处理。|
|Semaphore	|使用AQS同步状态来保存信号量的当前计数。tryRelease会增加计数，acquireShared会减少计数。|
|CountDownLatch |	使用AQS同步状态来表示计数。计数为0时，所有的Acquire操作（CountDownLatch的await方法）才可以通过。|
|ReentrantReadWriteLock	| 使用AQS同步状态中的16位保存写锁持有的次数，剩下的16位用于保存读锁的持有次数。|
|ThreadPoolExecutor|	Worker利用AQS同步状态实现对独占线程变量的设置（tryAcquire和tryRelease）。|

//TODO

[从ReentrantLock的实现看AQS的原理及应用](https://tech.meituan.com/2019/12/05/aqs-theory-and-apply.html)

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
