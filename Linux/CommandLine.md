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


## Linux

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
