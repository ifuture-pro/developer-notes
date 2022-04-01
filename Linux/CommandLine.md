# 命令行

## Windows

* 程序后台运行
更好的方式[WinHidden](../Python/WinHidden.md)
```SHELL
@echo off
if "%1" == "h" goto begin
start mshta vbscript:createobject("wscript.shell").run("%~nx0 h",0)(window.close)&&exit
:begin
##前四行是隐藏cmd窗口必不可少代码##

##下一句引号中内容
echo "Hello Wrold"

##下一句 cd 后面跟exe程序的绝对路径
cd D:\常用软件\6b\

##下一句 start /b 后跟exe程序 【全名】
start /b epoch.exe
```

* 路由表
```SHELL
route print -

===========================================================================
Interface List
 19...78 dd 08 a4 40 f4 ......Bluetooth Device (Personal Area Network)
11...00 27 10 5b 26 fc ......Intel(R) Centrino(R) Advanced-N  AGN
 13...f0 de f1 08  f4 ......Intel(R) 82577LM Gigabit Network Connection
 15...00 50 56 c0 00 01 ......VMware Virtual Ethernet Adapter for VMnet1
 16...00 50 56 c0 00 08 ......VMware Virtual Ethernet Adapter for VMnet8
  1...........................Software Loopback Interface 1
 23...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter
 12...00 00 00 00 00 00 00 e0 Teredo Tunneling Pseudo-Interface
 21...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter #2
 17...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter #4
 20...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter #5
 22...00 00 00 00 00 00 00 e0 Microsoft ISATAP Adapter #6
===========================================================================

IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0      192.168.0.1     192.168.1.12     26
       10.108.0.0      255.255.0.0      10.108.58.1     10.108.58.18     21
      10.108.58.0    255.255.255.0         On-link      10.108.58.18    276
     10.108.58.18  255.255.255.255         On-link      10.108.58.18    276
    10.108.58.255  255.255.255.255         On-link      10.108.58.18    276
        127.0.0.0        255.0.0.0         On-link         127.0.0.1    306
        127.0.0.1  255.255.255.255         On-link         127.0.0.1    306
  127.255.255.255  255.255.255.255         On-link         127.0.0.1    306
       172.16.0.0      255.255.0.0      10.108.58.1     10.108.58.18     21
      192.168.0.0    255.255.252.0         On-link      192.168.1.12    281
     192.168.1.12  255.255.255.255         On-link      192.168.1.12    281
    192.168.3.255  255.255.255.255         On-link      192.168.1.12    281
     192.168.10.0    255.255.255.0         On-link      192.168.10.1    276
     192.168.10.1  255.255.255.255         On-link      192.168.10.1    276
   192.168.10.255  255.255.255.255         On-link      192.168.10.1    276
    192.168.159.0    255.255.255.0         On-link     192.168.159.1    276
    192.168.159.1  255.255.255.255         On-link     192.168.159.1    276
  192.168.159.255  255.255.255.255         On-link     192.168.159.1    276
        224.0.0.0        240.0.0.0         On-link         127.0.0.1    306
        224.0.0.0        240.0.0.0         On-link      10.108.58.18    276
        224.0.0.0        240.0.0.0         On-link     192.168.159.1    276
        224.0.0.0        240.0.0.0         On-link      192.168.10.1    276
        224.0.0.0        240.0.0.0         On-link      192.168.1.12    281
  255.255.255.255  255.255.255.255         On-link         127.0.0.1    306
  255.255.255.255  255.255.255.255         On-link      10.108.58.18    276
  255.255.255.255  255.255.255.255         On-link     192.168.159.1    276
  255.255.255.255  255.255.255.255         On-link      192.168.10.1    276
  255.255.255.255  255.255.255.255         On-link      192.168.1.12    281
===========================================================================
Persistent Routes:
  Network Address          Netmask  Gateway Address  Metric
      172.21.10.0    255.255.255.0    172.16.56.190       1
       10.108.0.0      255.255.0.0      10.108.58.1       1
       172.16.0.0      255.255.0.0      10.108.58.1       1
===========================================================================

Interface List: 网络卡列表
Active Routes: 活动路由
Network Destination: 目的网段
Netmask: 子网掩码，与目的网段共同定义了此条路由适用的网络地址
Gateway: 网关，又称下一跳路由器，在发送IP数据包时，网关定义了针对特定的网络目的地址，数据包发送到的下一跳服务器
Interface: 接口，接口定义了针对特定的网络目的地址，本地计算机用于发送数据包的网络接口
Metric: 跳数，跳数用于指出路由的成本，通常情况下代表到达目标地址所需要经过的跳跃数量，一个跳数代表经过一个路由器。跳数越低，代表路由成本越低，优先级越高
Persistent Routes: 手动配置静态路由

route print: 打印当前的路由表
route delete：删除一条路由
route add: 增加一条路由, 如果最后加上 –p 选项，表示永久增加静态路由，重启后不会失效
route change: 更改一条路由

:删除默认设置
route delete 0.0.0.0
:外网路由，全走无线
route add 0.0.0.0 mask 0.0.0.0 192.168.0.1 –p
:公司内网全部在10.108.*.*网段，增加此路由
route add 10.108.0.0 mask 255.255.0.0 10.108.58.1 -p
```


## Linux

* 系统日志

```shell
vim /etc/rsyslog.d/50-default.conf
service rsyslog restart
```

* 重启时间

  `last reboot`

* 随机数

  `cat /proc/sys/kernel/random/uuid`

* iptables
```shell
# CentOS7默认的防火墙firewalld
## 停止firewalld服务
systemctl stop firewalld
## 禁用firewalld服务
systemctl mask firewalld

## 先检查是否安装了iptables
service iptables status
## 安装iptables
yum install -y iptables
## 升级iptables
yum update iptables
## 安装iptables-services
yum install iptables-services

## 查看iptables现有规则
iptables -L -n
## 先允许所有,不然有可能会杯具
iptables -P INPUT ACCEPT
## 清空所有默认规则
iptables -F
## 清空所有自定义规则
iptables -X
## 所有计数器归0
iptables -Z
## 允许来自于lo接口的数据包(本地访问)
iptables -A INPUT -i lo -j ACCEPT
## 开放22端口
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
## 开放21端口(FTP)
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
## 开放80端口(HTTP)
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
## 开放443端口(HTTPS)
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
## 允许ping
iptables -A INPUT -p icmp --icmp-type 8 -j ACCEPT
## 允许接受本机请求之后的返回数据 RELATED,是为FTP设置的
iptables -A INPUT -m state --state  RELATED,ESTABLISHED -j ACCEPT
## 其他入站一律丢弃
iptables -P INPUT DROP
## 所有出站一律绿灯
iptables -P OUTPUT ACCEPT
## 所有转发一律丢弃
iptables -P FORWARD DROP
## 保存上述规则
service iptables save

## -A：规则直接加在末尾
## -I：后面跟具体的位置，将规则插入到指定的位置
## -D: 删除规则
## -p: 协议类型，如tcp类型，还有特定的-dport端口参数
## -j: 处理方法，如ACCEPT接受， DROP丢弃， REJECT拒绝


## 如果要添加内网ip信任（接受其所有TCP请求）
## ***.***.***.***为ip地址
iptables -A INPUT -p tcp -s ***.***.***.*** -j ACCEPT
## 过滤所有非以上规则的请求
iptables -P INPUT DROP
## 要封停一个IP，使用下面这条命令：
iptables -I INPUT -s ***.***.***.*** -j DROP
## 要解封一个IP，使用下面这条命令:
iptables -D INPUT -s ***.***.***.*** -j DROP

## 注册iptables服务开机启动
## 相当于以前的chkconfig iptables on
systemctl enable iptables.service
## 在开机时禁用服务
systemctl disable iptables.service
## 查看服务是否开机启动
systemctl is-enabled iptables
## 启动服务
## 相对于之前service iptables stop/start/status/restart/reload等
systemctl start iptables
## 关闭服务
systemctl stop iptables
## 重启服务
systemctl restart iptables
## 服务状态
systemctl status iptables

iptables -I INPUT 1 -p udp --dport 1212 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 1212 -j ACCEPT
```

* tcpdump 抓包
https://www.tcpdump.org/manpages/tcpdump.1.html
```SHELL
-- 所有网卡中捕获数据包 -X 以十六进制打印出数据报文内容，-A 打印数据报文的 ASCII 值
tcpdump -i any -X
-- 指定IP的数据包
tcpdump host 114.114.114.114 -X
tcpdump src 192.168.174.128 || dst 192.168.174.2
-- 制定端口
tcpdump port 80
tcpdump portrange 22-125
-- 写入文件
tcpdump -i eth0 -w packets_file
-- 读取文件
tcpdump -r packets_file
-- 整个网络段
tcpdump net 192.168.174.0/24
```
