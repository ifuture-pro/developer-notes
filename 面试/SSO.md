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

#### 密码模式（Password）  
适用于受信任客户端应用，例如同个组织的内部或外部应用。
#### 客户端模式（client credentials）  
适用于客户端调用主服务API型应用（比如百度API Store）


## JWT
## Open ID
## SAML
