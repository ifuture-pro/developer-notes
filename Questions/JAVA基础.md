## Java内存模型
* 原子性
* 可见性
* 有序性

### happens-before原则（先行发生原则）

* 程序次序规则：一个线程内，按照代码顺序，书写在前面的操作先行发生于书写在后面的操作
* 锁定规则：一个unLock操作先行发生于后面对同一个锁额lock操作
* volatile变量规则：对一个变量的写操作先行发生于后面对这个变量的读操作
* 传递规则：如果操作A先行发生于操作B，而操作B又先行发生于操作C，则可以得出操作A先行发生于操作C
* 线程启动规则：Thread对象的start\(\)方法先行发生于此线程的每个一个动作
* 线程中断规则：对线程interrupt\(\)方法的调用先行发生于被中断线程的代码检测到中断事件的发生
* 线程终结规则：线程中所有的操作都先行发生于线程的终止检测，我们可以通过Thread.join\(\)方法结束、Thread.isAlive\(\)的返回值手段检测到线程已经终止执行
* 对象终结规则：一个对象的初始化完成先行发生于他的finalize\(\)方法的开始

#### synchronized
> \['sɪŋkrənaɪzd\]

```
public class Test {
    public  int inc = 0;
 
    public synchronized void increase() {
        inc++;
    }
 
    public static void main(String[] args) {
        final Test test = new Test();
        for(int i=0;i<10;i++){
            new Thread(){
                public void run() {
                    for(int j=0;j<1000;j++)
                        test.increase();
                };
            }.start();
        }
 
        while(Thread.activeCount()>1)  //保证前面的线程都执行完
            Thread.yield();
        System.out.println(test.inc);
    }
}
```

#### Lock

```
public class Test {
    public  int inc = 0;
    Lock lock = new ReentrantLock();
 
    public  void increase() {
        lock.lock();
        try {
            inc++;
        } finally{
            lock.unlock();
        }
    }
 
    public static void main(String[] args) {
        final Test test = new Test();
        for(int i=0;i<10;i++){
            new Thread(){
                public void run() {
                    for(int j=0;j<1000;j++)
                        test.increase();
                };
            }.start();
        }
 
        while(Thread.activeCount()>1)  //保证前面的线程都执行完
            Thread.yield();
        System.out.println(test.inc);
    }
}
```

#### AtomicInteger

> atomic \[ə'tɑmɪk\] adj. 原子的，原子能的；微粒子的

```
public class Test {
    public  AtomicInteger inc = new AtomicInteger();
 
    public  void increase() {
        inc.getAndIncrement();
    }
 
    public static void main(String[] args) {
        final Test test = new Test();
        for(int i=0;i<10;i++){
            new Thread(){
                public void run() {
                    for(int j=0;j<1000;j++)
                        test.increase();
                };
            }.start();
        }
 
        while(Thread.activeCount()>1)  //保证前面的线程都执行完
            Thread.yield();
        System.out.println(test.inc);
    }
}
```




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

