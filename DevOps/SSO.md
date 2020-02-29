SSO (Single Sign On) 单点登录
------
简而言之就是在多个应用系统中，只需要登录一次，就可以访问其他相互信任的应用系统。
* **同域下的单点登录**
  比如两个系统为 `a.z.com`,`b.z.com` 。由于`Cookie`是不能跨域的,所以我们只需要将 `Cookie` 的 `domain` 设置成 `.z.com` 即可。
* **不同域**
  主要原理是系统共同拥有一个`认证服务器` a 系统使用认证服务器获得授权 token ，在进入 b 系统时，将 这个 token 以参数形式带到 b 系统，b 系统收到 token ，去认证服务器认证 token 是否有效，有效即可正常访问 b 系统资源，实现单点登录。


## OAuth2
OAuth2是一个开放标准，允许用户授权第三方应用访问他们存储在另外的服务提供者上的信息，而不需要将用户名和密码提供给第三方应用或分享他们数据的所有内容。https://tools.ietf.org/html/rfc6749#section-4.1

### 角色
* Authorization Server 认证服务器
* Resource server 资源服务器
* Resource Owner 资源拥有者。可以理解为`用户`
* Client 客户端。可以理解为需要获取授权资源的`第三方应用程序`
* User Agent：用户代理。可以理解为`浏览器`

### 授权协议
Grant Type：
#### 授权码模式（authorization code）  
功能最完整、流程最严密的授权模式。它的特点就是通过客户端的后台服务器，与"服务提供商"的认证服务器进行互动。


     +----------+
     | Resource |
     |   Owner  |
     |          |
     +----------+
          ^
          |
         (B)
     +----|-----+          Client Identifier      +---------------+
     |         -+----(A)-- & Redirection URI ---->|               |
     |  User-   |                                 | Authorization |
     |  Agent  -+----(B)-- User authenticates --->|     Server    |
     |          |                                 |               |
     |         -+----(C)-- Authorization Code ---<|               |
     +-|----|---+                                 +---------------+
       |    |                                         ^      v
      (A)  (C)                                        |      |
       |    |                                         |      |
       ^    v                                         |      |
     +---------+                                      |      |
     |         |>---(D)-- Authorization Code ---------'      |
     |  Client |          & Redirection URI                  |
     |         |                                             |
     |         |<---(E)----- Access Token -------------------'
     +---------+       (w/ Optional Refresh Token)

A. 用户访问客户端，后者将前者导向认证服务器；  
B. 用户选择是否给予客户端授权；  
C. 假设用户给予授权，认证服务器将用户导向客户端事先指定的"重定向URI"（redirection URI），同时附上一个授权码；  
D. 客户端收到授权码，附上早先的"重定向URI"，向认证服务器申请令牌。这一步是在客户端的后台的服务器上完成的，对用户不可见；  
E. 认证服务器核对了授权码和重定向URI，确认无误后，向客户端发送访问令牌（access token）和更新令牌（refresh token）  


```
//获取授权码。一般情况下会跳到认证服务器的登录页面，让用户登录，并确认授权
GET https://auth.ifuture.pro/oauth/authorize?client_id=zzzclient&response_type=code&redirect_uri=https://admin.z.com/

//拿到 code 后向认证服务器请求获得 token。一般情况这个请求得在后台进行
POST https://auth.ifuture.pro/oauth/token?code=kQoo2G&client_id=zzzclient&client_secret=111111&grant_type=authorization_code&redirect_uri=https://admin.z.com/
```


#### 简化模式（implicit）  
采用Implicit Grant（隐式授权）方式获取Access Token的授权验证流程与OAuth 2.0标准的User-Agent Flow相同，适用于所有无Server端配合的应用（由于应用往往位于一个User Agent里，如浏览器里面，因此这类应用在某些平台下又被称为Client-Side Application），如手机/桌面客户端程序、浏览器插件等, 他们的一个共同特点是，应用无法妥善保管其应用密钥（App Secret Key），如果采取Authorization Code模式，则会存在泄漏其应用密钥的可能性。



     +----------+
     | Resource |
     |  Owner   |
     |          |
     +----------+
          ^
          |
         (B)
     +----|-----+          Client Identifier     +---------------+
     |         -+----(A)-- & Redirection URI --->|               |
     |  User-   |                                | Authorization |
     |  Agent  -|----(B)-- User authenticates -->|     Server    |
     |          |                                |               |
     |          |<---(C)--- Redirection URI ----<|               |
     |          |          with Access Token     +---------------+
     |          |            in Fragment
     |          |                                +---------------+
     |          |----(D)--- Redirection URI ---->|   Web-Hosted  |
     |          |          without Fragment      |     Client    |
     |          |                                |    Resource   |
     |     (F)  |<---(E)------- Script ---------<|               |
     |          |                                +---------------+
     +-|--------+
       |    |
      (A)  (G) Access Token
       |    |
       ^    v
     +---------+
     |         |
     |  Client |
     |         |
     +---------+




A. 客户端将用户导向认证服务器；  
B. 用户决定是否给于客户端授权；  
C. 假设用户给予授权，认证服务器将用户导向客户端指定的"重定向URI"，并在URI的Hash部分包含了访问令牌；  
D. 浏览器向资源服务器发出请求，其中不包括上一步收到的Hash值；  
E. 资源服务器返回一个网页，其中包含的代码可以获取Hash值中的令牌；  
F. 浏览器执行上一步获得的脚本，提取出令牌；  
G. 浏览器将令牌发给客户端；  

主要就是没有获取 code 这一步了

```
// 发起请求，用户登录
https://auth.ifuture.pro/oauth/authorize?client_id=client&response_type=token&redirect_uri=https://ifuture.pro/callback/
// 直接返回 token
https://auth.ifuture.pro/callback/#access_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOnsiaWQiOjEsInVzZXJuYW1lIjoienp6.-WJP1h9_FE6CzrB_WAL09gxmyvrmrcBi604pRIj8er0&token_type=bearer&expires_in=86399&scope=all%20read%20write&jti=547d4c82-426c-48ef-bc56-2d0095a01c3a
```

#### 密码模式（Password）  
适用于受信任客户端应用，例如同个组织的内部或外部应用。

客户端可能也有自己的登录页面，并且与用户认证服务器之间互相信任，因为需要暴露用户密码给客户端。  

```
//登录页面获取用户密码后，在后台发起下面请求获取 token
POST https://auth.ifuture.pro/oauth/token?username=zzz&password=123123&grant_type=password&client_id=zzzApp&client_secret=111111
```

#### 客户端模式（client credentials）  
* 客户端调用认证服务器，认证客户端的合法性，获得合法 token 。**与用户无关**
  > 因为与用户无关，所以不能获取用户信息（并没有当前登录用户这一概念），一般是服务与服务直接的调用认证使用，与用户无关。

* 资源服务器与认证服务器之间的鉴权认证

* 用于客户端调用主服务API型应用（比如百度API Store）

```
POST http://localhost:8000/oauth/token?client_id=client&client_secret=111111&grant_type=client_credentials
```


## Open ID
OpenID 与 OAuth2 类似。

OpenID ：只用于 **身份认证（Authentication）**，允许你以 同一个账户 在 多个网站登陆。它仅仅是为你的 合法身份 背书，当你以 Facebook 账号登陆某个站点之后，该站点 无权访问 你的在 Facebook 上的 数据

OAuth2：用于 **授权（Authorisation）**，允许 被授权方 访问 授权方 的 用户数据。




## JWT
[JSON Web token](https://tools.ietf.org/html/rfc7519)

包含：
* Header: 标题包含了令牌的元数据，并且在最小包含签名和/或加密算法的类型
* Claims: Claims 也称 Payload 包含您想要签署的任何信息
  - iss: 该JWT的签发者
  - sub: 该JWT所面向的用户
  - aud: 接收该JWT的一方
  - exp(expires): 什么时候过期，这里是一个Unix时间戳
  - iat(issued at): 在什么时候签发的
  - nbf: 定义在什么时间之前，该jwt都是不可用的.
  - jti: jwt的唯一身份标识，主要用来作为一次性token,从而回避重放攻击。

* [JSON Web Signature (JWS)](https://tools.ietf.org/html/rfc7515): 在header中指定的使用该算法的数字签名和声明
[在线解析](https://jwt.io/#encoded-jwt)


## OIDC

[OpenID Connect](https://openid.net/connect/) = (Identity, Authentication) + OAuth 2.0

OpenId的身份标识 + OAuth2的授权 + JWT数据包装方式 = OIDC


### 关键字
* EU：End User：用户。
* RP：Relying Party ,用来代指OAuth2中的受信任的客户端，身份认证和授权信息的消费方；
* OP：OpenID Provider，有能力提供EU认证的服务（比如OAuth2中的授权服务），用来为RP提供EU的身份认证信息；
* ID Token：JWT格式的数据，包含EU身份认证的信息。
* UserInfo Endpoint：用户信息接口（受OAuth2保护），当RP使用Access Token访问时，返回授权用户的信息，此接口必须使用HTTPS。

+--------+                                   +--------+
|        |                                   |        |
|        |---------(1) AuthN Request-------->|        |
|        |                                   |        |
|        |  +--------+                       |        |
|        |  |        |                       |        |
|        |  |  End-  |<--(2) AuthN & AuthZ-->|        |
|        |  |  User  |                       |        |
|   RP   |  |        |                       |   OP   |
|        |  +--------+                       |        |
|        |                                   |        |
|        |<--------(3) AuthN Response--------|        |
|        |                                   |        |
|        |---------(4) UserInfo Request----->|        |
|        |                                   |        |
|        |<--------(5) UserInfo Response-----|        |
|        |                                   |        |
+--------+                                   +--------+

https://openid.net/specs/openid-connect-core-1_0.html

1. RP发送一个认证请求给OP；
2. OP对EU进行身份认证，然后提供授权；
3. OP把ID Token和Access Token（需要的话）返回给RP；
4. RP使用Access Token发送一个请求UserInfo EndPoint；
5. UserInfo EndPoint返回EU的Claims。

AuthN=Authentication（认证），AuthZ=Authorization（授权）

https://github.com/mitreid-connect/OpenID-Connect-Java-Spring-Server/
https://blog.csdn.net/iamlake/article/details/93415206

## SAML
SAML (Security Assertion Markup Language) 安全断言标记语言。诞生于2005年。

### SAML1.1

### SAML2.0

![SAML](../assets/img/SAML.png)

1. 还 未登陆 的用户 打开浏览器 访问你的网站（SP），网站 提供服务 但是并 不负责用户认证。
2. 于是 SP 会生成一个 SAML 的认证请求数据包，把这个请求放在一个 html 的 form 表达的隐藏域中，这个 form 后面有一句 javascript 自动提交这个 form。 而 form 的action地址就是 提前配置好的 idp地址
3. 提交这个 form 用户浏览器 重定向到 IDP。
4. IDP 在验证完来自 SP 的 请求无误 之后，在浏览器中呈现 登陆表单
5. 用户填写 用户名 和 密码 进行登陆。
6. 用户登陆成功， IDP 会生成一个包含 用户信息的 SAML token（SAML token 又称为 SAML Assertion，本质上是 XML ）。生产一个带 token 的 form 表单 返回至浏览器。
7. 自动提交这个带 token 的表单，用户重定向 到 SP 。
8. SP 对拿到的 token 进行验证，并从中解析出 用户信息（双方持有对方的公钥），例如 用户是谁 以及 用户的权限 有哪些。此时就能够根据这些信息允许用户访问我们网站的内容。

[OpenSAML](https://www.jianshu.com/p/d041935641b4)


## LDAP

LDAP（Light Directory Access Portocol），它是基于X.500标准的 **轻量级目录访问协议**

**目录数据库和关系数据库不同**，它有优异的读性能，但写性能差，并且没有事务处理、回滚等复杂功能，不适于存储修改频繁的数据。所以目录天生是用来查询的，就好象它的名字一样。LDAP目录服务是由目录数据库和一套访问协议组成的系统。

### 关键字

|关键字 |英文全称 |含义 |
|-----|-------|-----|
|dc  |Domain Component| 域名的部分，其格式是将完整的域名分成几部分，如域名为example.com变成dc=example,dc=com（一条记录的所属位置）|
|uid |User Id |用户ID songtao.xu（一条记录的ID）|
|ou |Organization Unit |组织单位，组织单位可以包含其他各种对象（包括其他组织单元），如“oa组”（一条记录的所属组织）|
|cn | Common Name |公共名称，如“Thomas Johansson”（一条记录的名称）|
|sn |Surname |姓，如“万”|
|dn| Distinguished Name |“uid=songtao.xu,ou=oa组,dc=example,dc=com”，一条记录的位置（唯一）|
|rdn |Relative dn |相对辨别名，类似于文件系统中的相对路径，它是与目录树结构无关的部分，如“uid=tom”或“cn= Thomas Johansson”|

### 产品

#### 服务
* Microsoft Active Directory 使用非常广
* OpenLDAP

#### 接入方案
* [Spring LDAP](https://spring.io/projects/spring-ldap)
