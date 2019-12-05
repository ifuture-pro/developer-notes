## 握手
### 位码即tcp标志位,有6种标示:

- SYN(synchronous建立联机)
- ACK(acknowledgement 确认)
- PSH(push传送)
- FIN(finish结束)
- RST(reset重置)
- URG(urgent紧急)
- Sequence number(顺序号码)
- Acknowledge number(确认号码)

### 状态
- LISTEN - 侦听来自远方TCP端口的连接请求；
- SYN-SENT -在发送连接请求后等待匹配的连接请求；
- SYN-RECEIVED - 在收到和发送一个连接请求后等待对连接请求的确认；
- ESTABLISHED- 代表一个打开的连接，数据可以传送给用户；  *[ə'stæblɪʃt]adj. 确定的；已制定的，已建立的*
- FIN-WAIT-1 - 等待远程TCP的连接中断请求，或先前的连接中断请求的确认；
- FIN-WAIT-2 - 从远程TCP等待连接中断请求；
- CLOSE-WAIT - 等待从本地用户发来的连接中断请求；
- CLOSING -等待远程TCP对连接中断的确认；
- LAST-ACK - 等待原来发向远程TCP的连接中断请求的确认；
- TIME-WAIT -等待足够的时间以确保远程TCP接收到连接中断请求的确认；
- CLOSED - 没有任何连接状态

### 建立连接

TCP/IP协议中，TCP协议提供可靠的连接服务，采用三次握手建立一个连接。

- 第一次握手：建立连接时，客户端A发送SYN包（SYN=j）到服务器B，并进入SYN_SEND状态，等待服务器B确认。
- 第二次握手：服务器B收到SYN包，必须确认客户A的SYN（ACK=j+1），同时自己也发送一个SYN包（SYN=k），即SYN+ACK包，此时服务器B进入SYN_RECV状态。
- 第三次握手：客户端A收到服务器B的SYN＋ACK包，向服务器B发送确认包ACK（ACK=k+1），此包发送完毕，客户端A和服务器B进入ESTABLISHED状态，完成三次握手。

完成三次握手，客户端与服务器开始传送数据。


### 关闭连接

由于TCP连接是全双工的，因此每个方向都必须单独进行关闭。这个原则是当一方完成它的数据发送任务后就能发送一个FIN来终止这个方向的连接。收到一个 FIN只意味着这一方向上没有数据流动，一个TCP连接在收到一个FIN后仍能发送数据。首先进行关闭的一方将执行主动关闭，而另一方执行被动关闭。

 TCP的连接的拆除需要发送四个包，因此称为四次挥手(four-way handshake)。客户端或服务器均可主动发起挥手动作，在socket编程中，任何一方执行close()操作即可产生挥手操作。

- （1）客户端A发送一个FIN，用来关闭客户A到服务器B的数据传送。
- （2）服务器B收到这个FIN，它发回一个ACK，确认序号为收到的序号加1。和SYN一样，一个FIN将占用一个序号。
- （3）服务器B关闭与客户端A的连接，发送一个FIN给客户端A。
- （4）客户端A发回ACK报文确认，并将确认序号设置为收到序号加1。

[参考](https://www.cnblogs.com/Jessy/p/3535612.html)
