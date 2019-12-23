GitHub Security Bug Bounty
--------
[Github 安全漏洞赏金计划](https://bounty.github.com/)

记录 GitHub 历史 bug 。  
> 与成功学一样，一味地学习他人怎么成功是不可取的方法。成功路上的坎坷、失败、经验、教学更值得大家学习。  
学习他人的错误，避免自己再犯错

## 绕开 GitHub OAuth
[GitHub enterprise 2.17.3修复了此 bug](https://enterprise.github.com/releases/2.17.3/notes)

### 滥用 HTTP HEAD 请求

[HTTP HEAD](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/HEAD) 自 HTTP 最初创建就一直存在，但好像开发者们对他使用的并不多。简单讲它只请求页面的首部，它与 GET 方法几乎是一样的，对于 HEAD 请求的回应部分来说，它的HTTP头部中包含的信息与通过 GET 请求所得到的信息是相同的。利用这个方法，不必传输整个资源内容，就可以得到 Request-URI 所标识的资源的信息。该方法常用于测试超链接的有效性，是否可以访问，以及最近是否更新，检查大文件大小（使用 Content-Length 响应头）  
大多情况开发者不需要特意的处理它，因为像 `Rails` 以及其他的 web 框架一样，他们已经帮我们处理了，它们尝试将 HEAD 请求路由到一个地址一样的 GET 请求那里去处理，然后省略响应体。这确实是一个聪明的做法，并符合 HTTP HEAD 规范。

非常巧 github 认证正好符合这一点。GET 返回 html 认证页面，POST 请求授权应用，参考代码：

```ruby
# In the router

match "/login/oauth/authorize", # For every request with this path...
  :to => "[the controller]", # ...send it to the controller...
  :via => [:get, :post] # ... as long as it's a GET or a POST request.


# In the controller

if request.get?
  # serve authorization page HTML
else
  # grant permissions to app
end

```

控制器根据 HTTP 请求 分别处理 GET 与 POST 看似并没有什么问题。  
但是如果我们向 `https://github.com/login/oauth/authorize` 发出 `HEAD` 已认证请求，通过上面的分析，我们可以得知路由会将它当成 `GET` 请求来处理，但到了控制器时，他终究不是个 `GET` 所以他将执行本应 POST 执行的代码段，那么这个经过认证的假 POST 请求， GITHUB 将授权请求中指定应用并给与用户数据。在这里  `CSRF` 为什么没有起作用，因为 `HEAD` 请求没有这个限制。因此我们可以发送一个跨站并进过身份认证的 `HEAD` 请求，这个请求将授权任意 OAuth 权限，而不需要向用户展示确认页面。

### 参考
* https://blog.teddykatz.com/2019/11/05/github-oauth-bypass.html
* https://hackerone.com/hacktivity
