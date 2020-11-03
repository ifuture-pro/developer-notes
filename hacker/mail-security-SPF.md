# SPF (Sender Policy Framework)
SMTP(SimpleMail Transfer Protocol)即简单邮件传输协议，正如名字所暗示的那样，它其实是一个非常简单的传输协议，无需身份认证，而且发件人的邮箱地址是可以由发信方任意声明的，利用这个特性可以伪造任意发件人。

[SPF](https://www.ietf.org/rfc/rfc4408.txt)一种以IP地址认证电子邮件发件人身份的技术，是为了防范垃圾邮件而提出来的一种DNS记录类型，它是一种TXT类型的记录。 接收邮件方会首先检查域名的SPF记录，来确定发件人的IP地址是否被包含在SPF记录里面，如果在，就认为是一封正确的邮件，否则会认为是一封伪造的邮件进行退回。

## 检测
```shell
➜  ~ dig -t txt 163.com

; <<>> DiG 9.10.6 <<>> -t txt 163.com
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 33760
;; flags: qr rd ra; QUERY: 1, ANSWER: 4, AUTHORITY: 7, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1280
;; QUESTION SECTION:
;163.com.			IN	TXT

;; ANSWER SECTION:
163.com.		18000	IN	TXT	"google-site-verification=hRXfNWRtd9HKlh-ZBOuUgGrxBJh526R8Uygp0jEZ9wY"
163.com.		18000	IN	TXT	"v=spf1 include:spf.163.com -all"
163.com.		18000	IN	TXT	"qdx50vkxg6qpn3n1k6n1tg2syg5wp96y"
163.com.		18000	IN	TXT	"57c23e6c1ed24f219803362dadf8dea3"

;; AUTHORITY SECTION:
163.com.		172800	IN	NS	ns8.166.com.
163.com.		172800	IN	NS	ns1.nease.net.
163.com.		172800	IN	NS	ns2.166.com.
163.com.		172800	IN	NS	ns3.nease.net.
163.com.		172800	IN	NS	ns4.nease.net.
163.com.		172800	IN	NS	ns5.nease.net.
163.com.		172800	IN	NS	ns6.nease.net.

;; Query time: 53 msec
;; SERVER: 240e:472:8010:7fb::f#53(240e:472:8010:7fb::f)
;; WHEN: Tue Nov 03 20:57:54 CST 2020
;; MSG SIZE  rcvd: 390
```

在结果中发现存在**v=spf1 include:spf.163.com** 表示配置了SFP记录

检测工具[SPF Record Testing Tools](https://www.kitterman.com/spf/validate.html)


## 伪造工具
Swaks（SWiss Army Knife Smtp）  
https://github.com/jetmore/swaks
