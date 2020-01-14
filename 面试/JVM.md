# CPU
## Cache line
缓存行对齐。  
CPU寄存器每次去内存读数据时，都是以64个字节为一个基本单位的。缓存行 64byte 是 CPU 同步的基本单位，缓存行隔离会比伪共享效率高。

##  MESI
cache一致性协议 Modify, Exclusive, Shared, Invalid

## 合并写
CPU内部4byte buffer

# JVM
## Volatile
内存屏障

//TODO
