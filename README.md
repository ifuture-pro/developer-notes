Developer Notes
--------------------
开发者笔记  
----------
:100: 汇聚，分布式、缓存、JVM、设计模式、数据库、算法、区块链、操作系统、黑客、DevOps、面试题  
:fire: [架构师成长路线](Notepad/软件架构师.md) 、:fire: [Awesome](Notepad/opensource-awesome.md)、:boom:[Emoji List](Notepad/emoji.md)

[![](https://github.com/ifuture-pro/developer-notes/workflows/Node%20CI/badge.svg)](https://github.com/ifuture-pro/developer-notes/actions)
[![](https://img.shields.io/badge/listify-list%20of%20contents-green)](https://github.com/ifuture-pro/listify)
[![](https://img.shields.io/badge/web-ifuture-green?style=plastic&logo=appveyor)](https://developer.ifuture.pro/)
[![](https://badgen.net/badge/icon/Website?icon=chrome&amp;label)](https://ifuture.pro/)

**为什么要做这个库**。现在好多人都把技术文章放微信公众号，各种自媒体上面，看完了，下次就找不到了，就算你收藏起来了也无法搜索，根本无法复习，查找。这里可以借助 docsify search 和 Github search 不仅可以搜索标题，还可以搜索内容。也有完整的目录可以系统的回顾一些关键知识点。欢迎PR。

**tools:**  
- [listify](https://github.com/ifuture-pro/listify)  生成全站目录
- [docsify](https://docsify.js.org/) 生成静态站点
- [Github Page](https://help.github.com/en/github/working-with-github-pages/getting-started-with-github-pages) 发布静态站点
- [Github Actions](https://github.com/marketplace/actions/listify-actions) 自动发布生成的目录

提高阅读体验   
https://developer.ifuture.pro/  


<!-- start listify -->

Table of Contents
-----------
  > *generated with [listify](https://github.com/ifuture-pro/listify)*

# Database

## [MYSQL基础及优化](Database/MYSQL基础及优化.md#mysql%E5%9F%BA%E7%A1%80%E5%8F%8A%E4%BC%98%E5%8C%96)

   - [基本常用操作](Database/MYSQL基础及优化.md#%E5%9F%BA%E6%9C%AC%E5%B8%B8%E7%94%A8%E6%93%8D%E4%BD%9C)
     - [创建数据库](Database/MYSQL基础及优化.md#%E5%88%9B%E5%BB%BA%E6%95%B0%E6%8D%AE%E5%BA%93)
     - [创建用户并授权](Database/MYSQL基础及优化.md#%E5%88%9B%E5%BB%BA%E7%94%A8%E6%88%B7%E5%B9%B6%E6%8E%88%E6%9D%83)
     - [导入导出数据](Database/MYSQL基础及优化.md#%E5%AF%BC%E5%85%A5%E5%AF%BC%E5%87%BA%E6%95%B0%E6%8D%AE)
   - [关键字](Database/MYSQL基础及优化.md#%E5%85%B3%E9%94%AE%E5%AD%97)
   - [索引基础](Database/MYSQL基础及优化.md#%E7%B4%A2%E5%BC%95%E5%9F%BA%E7%A1%80)
     - [聚簇索引](Database/MYSQL基础及优化.md#%E8%81%9A%E7%B0%87%E7%B4%A2%E5%BC%95)
     - [覆盖索引](Database/MYSQL基础及优化.md#%E8%A6%86%E7%9B%96%E7%B4%A2%E5%BC%95)
     - [索引下推](Database/MYSQL基础及优化.md#%E7%B4%A2%E5%BC%95%E4%B8%8B%E6%8E%A8)
     - [查询优化器](Database/MYSQL基础及优化.md#%E6%9F%A5%E8%AF%A2%E4%BC%98%E5%8C%96%E5%99%A8)
   - [事务隔离级别](Database/MYSQL基础及优化.md#%E4%BA%8B%E5%8A%A1%E9%9A%94%E7%A6%BB%E7%BA%A7%E5%88%AB)
   - [SQL基础优化](Database/MYSQL基础及优化.md#sql%E5%9F%BA%E7%A1%80%E4%BC%98%E5%8C%96)

## [数据库](Database/数据库.md#%E6%95%B0%E6%8D%AE%E5%BA%93)

   - [Database](Database/数据库.md#database)
   - [分类与出色产品](Database/数据库.md#%E5%88%86%E7%B1%BB%E4%B8%8E%E5%87%BA%E8%89%B2%E4%BA%A7%E5%93%81)
   - [关键字](Database/数据库.md#%E5%85%B3%E9%94%AE%E5%AD%97)

# DevOps

## [Elasticsearch](DevOps/Elasticsearch.md#elasticsearch)

   - [Elasticsearch](DevOps/Elasticsearch.md#elasticsearch)
   - [关键字](DevOps/Elasticsearch.md#%E5%85%B3%E9%94%AE%E5%AD%97)
     - [安装](DevOps/Elasticsearch.md#%E5%AE%89%E8%A3%85)
   - [elasticsearch-head](DevOps/Elasticsearch.md#elasticsearch-head)
     - [安装](DevOps/Elasticsearch.md#%E5%AE%89%E8%A3%85)

## [Flink](DevOps/Flink.md#flink)

   - [Flink](DevOps/Flink.md#flink)
   - [场景](DevOps/Flink.md#%E5%9C%BA%E6%99%AF)
   - [大数据](DevOps/Flink.md#%E5%A4%A7%E6%95%B0%E6%8D%AE)
     - [数据集类型](DevOps/Flink.md#%E6%95%B0%E6%8D%AE%E9%9B%86%E7%B1%BB%E5%9E%8B)
     - [数据运算模型](DevOps/Flink.md#%E6%95%B0%E6%8D%AE%E8%BF%90%E7%AE%97%E6%A8%A1%E5%9E%8B)
   - [部署](DevOps/Flink.md#%E9%83%A8%E7%BD%B2)
   - [结构](DevOps/Flink.md#%E7%BB%93%E6%9E%84)
     - [API](DevOps/Flink.md#api)
     - [模拟程序与数据流结构](DevOps/Flink.md#%E6%A8%A1%E6%8B%9F%E7%A8%8B%E5%BA%8F%E4%B8%8E%E6%95%B0%E6%8D%AE%E6%B5%81%E7%BB%93%E6%9E%84)
     - [事件时间&处理时间语义](DevOps/Flink.md#%E4%BA%8B%E4%BB%B6%E6%97%B6%E9%97%B4%E5%A4%84%E7%90%86%E6%97%B6%E9%97%B4%E8%AF%AD%E4%B9%89)
     - [窗口机制](DevOps/Flink.md#%E7%AA%97%E5%8F%A3%E6%9C%BA%E5%88%B6)
     - [并行执行任务](DevOps/Flink.md#%E5%B9%B6%E8%A1%8C%E6%89%A7%E8%A1%8C%E4%BB%BB%E5%8A%A1)
     - [状态存储和容错](DevOps/Flink.md#%E7%8A%B6%E6%80%81%E5%AD%98%E5%82%A8%E5%92%8C%E5%AE%B9%E9%94%99)
     - [内存管理机制](DevOps/Flink.md#%E5%86%85%E5%AD%98%E7%AE%A1%E7%90%86%E6%9C%BA%E5%88%B6)

## MQ

### [RabbitMQ](DevOps/MQ/RabbitMQ.md#rabbitmq)

   - [Rabbit MQ](DevOps/MQ/RabbitMQ.md#rabbit-mq)
   - [关键字](DevOps/MQ/RabbitMQ.md#%E5%85%B3%E9%94%AE%E5%AD%97)
   - [基本安装](DevOps/MQ/RabbitMQ.md#%E5%9F%BA%E6%9C%AC%E5%AE%89%E8%A3%85)
   - [消息确认 ACK 机制](DevOps/MQ/RabbitMQ.md#%E6%B6%88%E6%81%AF%E7%A1%AE%E8%AE%A4-ack-%E6%9C%BA%E5%88%B6)
   - [消息持久化](DevOps/MQ/RabbitMQ.md#%E6%B6%88%E6%81%AF%E6%8C%81%E4%B9%85%E5%8C%96)
   - [高可用](DevOps/MQ/RabbitMQ.md#%E9%AB%98%E5%8F%AF%E7%94%A8)
     - [Spring boot](DevOps/MQ/RabbitMQ.md#spring-boot)
     - [HAProxy](DevOps/MQ/RabbitMQ.md#haproxy)

## [SSO](DevOps/SSO.md#sso)

   - [SSO (Single Sign On) 单点登录](DevOps/SSO.md#sso-single-sign-on-%E5%8D%95%E7%82%B9%E7%99%BB%E5%BD%95)
   - [OAuth2](DevOps/SSO.md#oauth2)
     - [角色](DevOps/SSO.md#%E8%A7%92%E8%89%B2)
     - [授权协议](DevOps/SSO.md#%E6%8E%88%E6%9D%83%E5%8D%8F%E8%AE%AE)
       - [授权码模式（authorization code）](DevOps/SSO.md#%E6%8E%88%E6%9D%83%E7%A0%81%E6%A8%A1%E5%BC%8Fauthorization-code)
       - [简化模式（implicit）](DevOps/SSO.md#%E7%AE%80%E5%8C%96%E6%A8%A1%E5%BC%8Fimplicit)
       - [密码模式（Password）](DevOps/SSO.md#%E5%AF%86%E7%A0%81%E6%A8%A1%E5%BC%8Fpassword)
       - [客户端模式（client credentials）](DevOps/SSO.md#%E5%AE%A2%E6%88%B7%E7%AB%AF%E6%A8%A1%E5%BC%8Fclient-credentials)
   - [Open ID](DevOps/SSO.md#open-id)
   - [JWT](DevOps/SSO.md#jwt)
   - [OIDC](DevOps/SSO.md#oidc)
     - [关键字](DevOps/SSO.md#%E5%85%B3%E9%94%AE%E5%AD%97)
   - [SAML](DevOps/SSO.md#saml)
     - [SAML1.1](DevOps/SSO.md#saml11)
     - [SAML2.0](DevOps/SSO.md#saml20)
   - [LDAP](DevOps/SSO.md#ldap)
     - [关键字](DevOps/SSO.md#%E5%85%B3%E9%94%AE%E5%AD%97)
     - [产品](DevOps/SSO.md#%E4%BA%A7%E5%93%81)
       - [服务](DevOps/SSO.md#%E6%9C%8D%E5%8A%A1)
       - [接入方案](DevOps/SSO.md#%E6%8E%A5%E5%85%A5%E6%96%B9%E6%A1%88)

## [分布式系统数据一致性](DevOps/分布式系统数据一致性.md#%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F%E6%95%B0%E6%8D%AE%E4%B8%80%E8%87%B4%E6%80%A7)

   - [分布式系统数据一致性](DevOps/分布式系统数据一致性.md#%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F%E6%95%B0%E6%8D%AE%E4%B8%80%E8%87%B4%E6%80%A7)
   - [分布式系统](DevOps/分布式系统数据一致性.md#%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F)
     - [两阶段提交协议（2PC：Two-Phase Commit）](DevOps/分布式系统数据一致性.md#%E4%B8%A4%E9%98%B6%E6%AE%B5%E6%8F%90%E4%BA%A4%E5%8D%8F%E8%AE%AE2pctwo-phase-commit)
       - [第一阶段：投票](DevOps/分布式系统数据一致性.md#%E7%AC%AC%E4%B8%80%E9%98%B6%E6%AE%B5%E6%8A%95%E7%A5%A8)
       - [第二阶段：事务提交](DevOps/分布式系统数据一致性.md#%E7%AC%AC%E4%BA%8C%E9%98%B6%E6%AE%B5%E4%BA%8B%E5%8A%A1%E6%8F%90%E4%BA%A4)
       - [缺点与存在的问题](DevOps/分布式系统数据一致性.md#%E7%BC%BA%E7%82%B9%E4%B8%8E%E5%AD%98%E5%9C%A8%E7%9A%84%E9%97%AE%E9%A2%98)
     - [三阶段提交协议（3PC：Three-Phase Commit）](DevOps/分布式系统数据一致性.md#%E4%B8%89%E9%98%B6%E6%AE%B5%E6%8F%90%E4%BA%A4%E5%8D%8F%E8%AE%AE3pcthree-phase-commit)
       - [第一阶段：预询盘](DevOps/分布式系统数据一致性.md#%E7%AC%AC%E4%B8%80%E9%98%B6%E6%AE%B5%E9%A2%84%E8%AF%A2%E7%9B%98)
       - [第二阶段：预提交](DevOps/分布式系统数据一致性.md#%E7%AC%AC%E4%BA%8C%E9%98%B6%E6%AE%B5%E9%A2%84%E6%8F%90%E4%BA%A4)
       - [第三阶段：事务提交](DevOps/分布式系统数据一致性.md#%E7%AC%AC%E4%B8%89%E9%98%B6%E6%AE%B5%E4%BA%8B%E5%8A%A1%E6%8F%90%E4%BA%A4)
   - [区块链分布式系统](DevOps/分布式系统数据一致性.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E5%88%86%E5%B8%83%E5%BC%8F%E7%B3%BB%E7%BB%9F)
     - [哈希时间锁定](DevOps/分布式系统数据一致性.md#%E5%93%88%E5%B8%8C%E6%97%B6%E9%97%B4%E9%94%81%E5%AE%9A)
     - [Paxos](DevOps/分布式系统数据一致性.md#paxos)

## [大数据](DevOps/大数据.md#%E5%A4%A7%E6%95%B0%E6%8D%AE)

   - [Big Data](DevOps/大数据.md#big-data)
   - [涉及关键知识点](DevOps/大数据.md#%E6%B6%89%E5%8F%8A%E5%85%B3%E9%94%AE%E7%9F%A5%E8%AF%86%E7%82%B9)
     - [存储引擎](DevOps/大数据.md#%E5%AD%98%E5%82%A8%E5%BC%95%E6%93%8E)
       - [LSM](DevOps/大数据.md#lsm)
     - [容错 数据冗余技术](DevOps/大数据.md#%E5%AE%B9%E9%94%99-%E6%95%B0%E6%8D%AE%E5%86%97%E4%BD%99%E6%8A%80%E6%9C%AF)
       - [副本策略](DevOps/大数据.md#%E5%89%AF%E6%9C%AC%E7%AD%96%E7%95%A5)
       - [纠删码 Erasure Code](DevOps/大数据.md#%E7%BA%A0%E5%88%A0%E7%A0%81-erasure-code)
       - [磁盘阵列](DevOps/大数据.md#%E7%A3%81%E7%9B%98%E9%98%B5%E5%88%97)

## [微服务](DevOps/微服务.md#%E5%BE%AE%E6%9C%8D%E5%8A%A1)

   - [微服务](DevOps/微服务.md#%E5%BE%AE%E6%9C%8D%E5%8A%A1)
   - [Spring cloud 与 Kubernetes 组件](DevOps/微服务.md#spring-cloud-%E4%B8%8E-kubernetes-%E7%BB%84%E4%BB%B6)
       - [优秀案例](DevOps/微服务.md#%E4%BC%98%E7%A7%80%E6%A1%88%E4%BE%8B)
   - [负载均衡](DevOps/微服务.md#%E8%B4%9F%E8%BD%BD%E5%9D%87%E8%A1%A1)
   - [关键问题字](DevOps/微服务.md#%E5%85%B3%E9%94%AE%E9%97%AE%E9%A2%98%E5%AD%97)

## [缓存](DevOps/缓存.md#%E7%BC%93%E5%AD%98)

   - [缓存 cache](DevOps/缓存.md#%E7%BC%93%E5%AD%98-cache)
   - [Cache Aside Pattern](DevOps/缓存.md#cache-aside-pattern)
   - [缓存穿透](DevOps/缓存.md#%E7%BC%93%E5%AD%98%E7%A9%BF%E9%80%8F)
   - [Redis](DevOps/缓存.md#redis)
     - [数据结构](DevOps/缓存.md#%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84)
     - [淘汰策略](DevOps/缓存.md#%E6%B7%98%E6%B1%B0%E7%AD%96%E7%95%A5)
     - [持久化机制](DevOps/缓存.md#%E6%8C%81%E4%B9%85%E5%8C%96%E6%9C%BA%E5%88%B6)
     - [应用](DevOps/缓存.md#%E5%BA%94%E7%94%A8)

# Linux

## [Computer](Linux/Computer.md#computer)

   - [计算机](Linux/Computer.md#%E8%AE%A1%E7%AE%97%E6%9C%BA)
   - [CPU](Linux/Computer.md#cpu)
   - [内存](Linux/Computer.md#%E5%86%85%E5%AD%98)

## [HTTP](Linux/HTTP.md#http)

   - [握手](Linux/HTTP.md#%E6%8F%A1%E6%89%8B)
     - [位码即tcp标志位,有6种标示:](Linux/HTTP.md#%E4%BD%8D%E7%A0%81%E5%8D%B3tcp%E6%A0%87%E5%BF%97%E4%BD%8D%E6%9C%896%E7%A7%8D%E6%A0%87%E7%A4%BA)
     - [状态](Linux/HTTP.md#%E7%8A%B6%E6%80%81)
     - [建立连接](Linux/HTTP.md#%E5%BB%BA%E7%AB%8B%E8%BF%9E%E6%8E%A5)
     - [关闭连接](Linux/HTTP.md#%E5%85%B3%E9%97%AD%E8%BF%9E%E6%8E%A5)

## [HTTPS证书](Linux/HTTPS证书.md#https%E8%AF%81%E4%B9%A6)

   - [关键字](Linux/HTTPS证书.md#%E5%85%B3%E9%94%AE%E5%AD%97)
     - [SSL](Linux/HTTPS证书.md#ssl)
     - [TLS](Linux/HTTPS证书.md#tls)
     - [ACME](Linux/HTTPS证书.md#acme)
   - [申请证书](Linux/HTTPS证书.md#%E7%94%B3%E8%AF%B7%E8%AF%81%E4%B9%A6)
     - [云产商](Linux/HTTPS证书.md#%E4%BA%91%E4%BA%A7%E5%95%86)
     - [免费证书](Linux/HTTPS证书.md#%E5%85%8D%E8%B4%B9%E8%AF%81%E4%B9%A6)
       - [云服务](Linux/HTTPS证书.md#%E4%BA%91%E6%9C%8D%E5%8A%A1)
       - [开源力量](Linux/HTTPS证书.md#%E5%BC%80%E6%BA%90%E5%8A%9B%E9%87%8F)

## [Openconnect](Linux/Openconnect.md#openconnect)

   - [Openconnect](Linux/Openconnect.md#openconnect)
   - [安装 client](Linux/Openconnect.md#%E5%AE%89%E8%A3%85-client)
     - [Ubuntu](Linux/Openconnect.md#ubuntu)
     - [Mac](Linux/Openconnect.md#mac)
     - [Mobile](Linux/Openconnect.md#mobile)
   - [Server](Linux/Openconnect.md#server)

## [mac](Linux/mac.md#mac)

   - [homebrew](Linux/mac.md#homebrew)

# Notepad

## [emoji](Notepad/emoji.md#emoji)

   - [Emoji list](Notepad/emoji.md#emoji-list)
   - [People](Notepad/emoji.md#people)
   - [Nature](Notepad/emoji.md#nature)
   - [Objects](Notepad/emoji.md#objects)
   - [Places](Notepad/emoji.md#places)
   - [Symbols](Notepad/emoji.md#symbols)
   - [Links](Notepad/emoji.md#links)

## [opensource-awesome](Notepad/opensource-awesome.md#opensource-awesome)

   - [精彩的开源项目](Notepad/opensource-awesome.md#%E7%B2%BE%E5%BD%A9%E7%9A%84%E5%BC%80%E6%BA%90%E9%A1%B9%E7%9B%AE)
   - [Opensource](Notepad/opensource-awesome.md#opensource)
   - [Awesome](Notepad/opensource-awesome.md#awesome)
   - [Github 增强](Notepad/opensource-awesome.md#github-%E5%A2%9E%E5%BC%BA)
   - [DveOps](Notepad/opensource-awesome.md#dveops)
     - [自动化](Notepad/opensource-awesome.md#%E8%87%AA%E5%8A%A8%E5%8C%96)
   - [行业产品-开源可替代方案](Notepad/opensource-awesome.md#%E8%A1%8C%E4%B8%9A%E4%BA%A7%E5%93%81-%E5%BC%80%E6%BA%90%E5%8F%AF%E6%9B%BF%E4%BB%A3%E6%96%B9%E6%A1%88)
     - [GitHub](Notepad/opensource-awesome.md#github)
     - [Youtube](Notepad/opensource-awesome.md#youtube)
     - [Slack](Notepad/opensource-awesome.md#slack)
     - [Google Drive](Notepad/opensource-awesome.md#google-drive)
     - [zendesk](Notepad/opensource-awesome.md#zendesk)
     - [Auth0](Notepad/opensource-awesome.md#auth0)
     - [CI/CD](Notepad/opensource-awesome.md#cicd)
     - [Zoom](Notepad/opensource-awesome.md#zoom)
     - [Jira](Notepad/opensource-awesome.md#jira)
   - [区块链](Notepad/opensource-awesome.md#%E5%8C%BA%E5%9D%97%E9%93%BE)
     - [区块链安全](Notepad/opensource-awesome.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E5%AE%89%E5%85%A8)
   - [最佳实践](Notepad/opensource-awesome.md#%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5)
     - [最佳实践-工具使用](Notepad/opensource-awesome.md#%E6%9C%80%E4%BD%B3%E5%AE%9E%E8%B7%B5-%E5%B7%A5%E5%85%B7%E4%BD%BF%E7%94%A8)
   - [Tools](Notepad/opensource-awesome.md#tools)
   - [国内开源镜像](Notepad/opensource-awesome.md#%E5%9B%BD%E5%86%85%E5%BC%80%E6%BA%90%E9%95%9C%E5%83%8F)

## [产品设计](Notepad/产品设计.md#%E4%BA%A7%E5%93%81%E8%AE%BE%E8%AE%A1)

   - [产品设计](Notepad/产品设计.md#%E4%BA%A7%E5%93%81%E8%AE%BE%E8%AE%A1)
   - [KISS 原则](Notepad/产品设计.md#kiss-%E5%8E%9F%E5%88%99)
   - [POC](Notepad/产品设计.md#poc)
   - [图片素材](Notepad/产品设计.md#%E5%9B%BE%E7%89%87%E7%B4%A0%E6%9D%90)
   - [软件版本](Notepad/产品设计.md#%E8%BD%AF%E4%BB%B6%E7%89%88%E6%9C%AC)
   - [通用](Notepad/产品设计.md#%E9%80%9A%E7%94%A8)
   - [微软常用](Notepad/产品设计.md#%E5%BE%AE%E8%BD%AF%E5%B8%B8%E7%94%A8)

## [开源协议](Notepad/开源协议.md#%E5%BC%80%E6%BA%90%E5%8D%8F%E8%AE%AE)

   - [Opensource License](Notepad/开源协议.md#opensource-license)
 - [GUN](Notepad/开源协议.md#gun)
   - [GPL](Notepad/开源协议.md#gpl)
   - [AGPL](Notepad/开源协议.md#agpl)
   - [LGPL](Notepad/开源协议.md#lgpl)
 - [BSD](Notepad/开源协议.md#bsd)
 - [MIT](Notepad/开源协议.md#mit)
 - [Apache](Notepad/开源协议.md#apache)
   - [Creative Commons](Notepad/开源协议.md#creative-commons)
 - [WTFPL](Notepad/开源协议.md#wtfpl)
 - [木兰宽松许可证](Notepad/开源协议.md#%E6%9C%A8%E5%85%B0%E5%AE%BD%E6%9D%BE%E8%AE%B8%E5%8F%AF%E8%AF%81)

## [日常杂项](Notepad/日常杂项.md#%E6%97%A5%E5%B8%B8%E6%9D%82%E9%A1%B9)

   - [Linux](Notepad/日常杂项.md#linux)
     - [系统](Notepad/日常杂项.md#%E7%B3%BB%E7%BB%9F)
       - [查看系统](Notepad/日常杂项.md#%E6%9F%A5%E7%9C%8B%E7%B3%BB%E7%BB%9F)
       - [设置时区](Notepad/日常杂项.md#%E8%AE%BE%E7%BD%AE%E6%97%B6%E5%8C%BA)
     - [编辑](Notepad/日常杂项.md#%E7%BC%96%E8%BE%91)
       - [VIM](Notepad/日常杂项.md#vim)
         - [中文乱码](Notepad/日常杂项.md#%E4%B8%AD%E6%96%87%E4%B9%B1%E7%A0%81)
         - [实用操作](Notepad/日常杂项.md#%E5%AE%9E%E7%94%A8%E6%93%8D%E4%BD%9C)
       - [sed](Notepad/日常杂项.md#sed)
     - [安全](Notepad/日常杂项.md#%E5%AE%89%E5%85%A8)
       - [nmap](Notepad/日常杂项.md#nmap)
   - [OpenSSL](Notepad/日常杂项.md#openssl)
     - [生成RSA秘钥对](Notepad/日常杂项.md#%E7%94%9F%E6%88%90rsa%E7%A7%98%E9%92%A5%E5%AF%B9)
   - [Git](Notepad/日常杂项.md#git)
     - [基础](Notepad/日常杂项.md#%E5%9F%BA%E7%A1%80)
       - [查看所有分支(包括远程)](Notepad/日常杂项.md#%E6%9F%A5%E7%9C%8B%E6%89%80%E6%9C%89%E5%88%86%E6%94%AF%E5%8C%85%E6%8B%AC%E8%BF%9C%E7%A8%8B)
       - [删除分支](Notepad/日常杂项.md#%E5%88%A0%E9%99%A4%E5%88%86%E6%94%AF)
       - [新建分支](Notepad/日常杂项.md#%E6%96%B0%E5%BB%BA%E5%88%86%E6%94%AF)
       - [tags](Notepad/日常杂项.md#tags)
     - [子项目](Notepad/日常杂项.md#%E5%AD%90%E9%A1%B9%E7%9B%AE)
     - [保存密码](Notepad/日常杂项.md#%E4%BF%9D%E5%AD%98%E5%AF%86%E7%A0%81)
     - [Github](Notepad/日常杂项.md#github)
     - [其他](Notepad/日常杂项.md#%E5%85%B6%E4%BB%96)
   - [Docker](Notepad/日常杂项.md#docker)
     - [基础安装](Notepad/日常杂项.md#%E5%9F%BA%E7%A1%80%E5%AE%89%E8%A3%85)
   - [Kubernetes](Notepad/日常杂项.md#kubernetes)
     - [Ingress](Notepad/日常杂项.md#ingress)

## [软件架构师](Notepad/软件架构师.md#%E8%BD%AF%E4%BB%B6%E6%9E%B6%E6%9E%84%E5%B8%88)

 - [什么是软件架构师](Notepad/软件架构师.md#%E4%BB%80%E4%B9%88%E6%98%AF%E8%BD%AF%E4%BB%B6%E6%9E%B6%E6%9E%84%E5%B8%88)
 - [架构师级别](Notepad/软件架构师.md#%E6%9E%B6%E6%9E%84%E5%B8%88%E7%BA%A7%E5%88%AB)
 - [基本工作内容](Notepad/软件架构师.md#%E5%9F%BA%E6%9C%AC%E5%B7%A5%E4%BD%9C%E5%86%85%E5%AE%B9)
 - [应具备的技能](Notepad/软件架构师.md#%E5%BA%94%E5%85%B7%E5%A4%87%E7%9A%84%E6%8A%80%E8%83%BD)
   - [1. 设计](Notepad/软件架构师.md#1-%E8%AE%BE%E8%AE%A1)
   - [2. 决策](Notepad/软件架构师.md#2-%E5%86%B3%E7%AD%96)
   - [3. 简化](Notepad/软件架构师.md#3-%E7%AE%80%E5%8C%96)
   - [4. 编码](Notepad/软件架构师.md#4-%E7%BC%96%E7%A0%81)
   - [5. 文档](Notepad/软件架构师.md#5-%E6%96%87%E6%A1%A3)
   - [6. 沟通](Notepad/软件架构师.md#6-%E6%B2%9F%E9%80%9A)
   - [7. 评估](Notepad/软件架构师.md#7-%E8%AF%84%E4%BC%B0)
   - [8. 平衡](Notepad/软件架构师.md#8-%E5%B9%B3%E8%A1%A1)
   - [9. 指导、答疑](Notepad/软件架构师.md#9-%E6%8C%87%E5%AF%BC%E7%AD%94%E7%96%91)
   - [10. 市场](Notepad/软件架构师.md#10-%E5%B8%82%E5%9C%BA)
 - [路线图](Notepad/软件架构师.md#%E8%B7%AF%E7%BA%BF%E5%9B%BE)

## [_coverpage](_coverpage.md#_coverpage)

 - [Developer notes](_coverpage.md#developer-notes)
   - [开发者笔记](_coverpage.md#%E5%BC%80%E5%8F%91%E8%80%85%E7%AC%94%E8%AE%B0)

# algorithm

## [BloomFilter](algorithm/BloomFilter.md#bloomfilter)

   - [布隆过滤器 Bloom Filter](algorithm/BloomFilter.md#%E5%B8%83%E9%9A%86%E8%BF%87%E6%BB%A4%E5%99%A8-bloom-filter)
   - [应用场景](algorithm/BloomFilter.md#%E5%BA%94%E7%94%A8%E5%9C%BA%E6%99%AF)
   - [原理](algorithm/BloomFilter.md#%E5%8E%9F%E7%90%86)
   - [实现](algorithm/BloomFilter.md#%E5%AE%9E%E7%8E%B0)
     - [基础实现](algorithm/BloomFilter.md#%E5%9F%BA%E7%A1%80%E5%AE%9E%E7%8E%B0)
     - [生产实现](algorithm/BloomFilter.md#%E7%94%9F%E4%BA%A7%E5%AE%9E%E7%8E%B0)

## [算法学习](algorithm/算法学习.md#%E7%AE%97%E6%B3%95%E5%AD%A6%E4%B9%A0)

   - [算法学习 algorithm](algorithm/算法学习.md#%E7%AE%97%E6%B3%95%E5%AD%A6%E4%B9%A0-algorithm)
   - [基础](algorithm/算法学习.md#%E5%9F%BA%E7%A1%80)
   - [寻路算法](algorithm/算法学习.md#%E5%AF%BB%E8%B7%AF%E7%AE%97%E6%B3%95)
   - [搜索](algorithm/算法学习.md#%E6%90%9C%E7%B4%A2)
   - [协同编辑](algorithm/算法学习.md#%E5%8D%8F%E5%90%8C%E7%BC%96%E8%BE%91)

# blockchain

## [区块链与随机数](blockchain/区块链与随机数.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E4%B8%8E%E9%9A%8F%E6%9C%BA%E6%95%B0)

   - [区块链与随机数](blockchain/区块链与随机数.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E4%B8%8E%E9%9A%8F%E6%9C%BA%E6%95%B0)
   - [计算机的随机数](blockchain/区块链与随机数.md#%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%9A%84%E9%9A%8F%E6%9C%BA%E6%95%B0)
   - [区块链中的随机数](blockchain/区块链与随机数.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E4%B8%AD%E7%9A%84%E9%9A%8F%E6%9C%BA%E6%95%B0)
     - [可验证随机函数 VRF](blockchain/区块链与随机数.md#%E5%8F%AF%E9%AA%8C%E8%AF%81%E9%9A%8F%E6%9C%BA%E5%87%BD%E6%95%B0-vrf)
     - [ETH2.0 方案 RANDAO + VDF](blockchain/区块链与随机数.md#eth20-%E6%96%B9%E6%A1%88-randao--vdf)
     - [其他随机数项目](blockchain/区块链与随机数.md#%E5%85%B6%E4%BB%96%E9%9A%8F%E6%9C%BA%E6%95%B0%E9%A1%B9%E7%9B%AE)

## [区块链概念汇总](blockchain/区块链概念汇总.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E6%A6%82%E5%BF%B5%E6%B1%87%E6%80%BB)

   - [区块链概念汇总](blockchain/区块链概念汇总.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E6%A6%82%E5%BF%B5%E6%B1%87%E6%80%BB)
   - [基础名词](blockchain/区块链概念汇总.md#%E5%9F%BA%E7%A1%80%E5%90%8D%E8%AF%8D)
     - [钱包](blockchain/区块链概念汇总.md#%E9%92%B1%E5%8C%85)
       - [冷钱包](blockchain/区块链概念汇总.md#%E5%86%B7%E9%92%B1%E5%8C%85)
       - [热钱包](blockchain/区块链概念汇总.md#%E7%83%AD%E9%92%B1%E5%8C%85)
     - [节点](blockchain/区块链概念汇总.md#%E8%8A%82%E7%82%B9)
     - [智能合约](blockchain/区块链概念汇总.md#%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6)
     - [分叉](blockchain/区块链概念汇总.md#%E5%88%86%E5%8F%89)
       - [软分叉](blockchain/区块链概念汇总.md#%E8%BD%AF%E5%88%86%E5%8F%89)
       - [硬分叉](blockchain/区块链概念汇总.md#%E7%A1%AC%E5%88%86%E5%8F%89)
     - [TPS](blockchain/区块链概念汇总.md#tps)
   - [共识](blockchain/区块链概念汇总.md#%E5%85%B1%E8%AF%86)
     - [共识算法](blockchain/区块链概念汇总.md#%E5%85%B1%E8%AF%86%E7%AE%97%E6%B3%95)
   - [隐私保护](blockchain/区块链概念汇总.md#%E9%9A%90%E7%A7%81%E4%BF%9D%E6%8A%A4)
     - [隐私保护算法](blockchain/区块链概念汇总.md#%E9%9A%90%E7%A7%81%E4%BF%9D%E6%8A%A4%E7%AE%97%E6%B3%95)
   - [区块链产品](blockchain/区块链概念汇总.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E4%BA%A7%E5%93%81)
     - [Ethereum (ETH)](blockchain/区块链概念汇总.md#ethereum-eth)
   - [攻击](blockchain/区块链概念汇总.md#%E6%94%BB%E5%87%BB)
     - [恶意挖矿攻击](blockchain/区块链概念汇总.md#%E6%81%B6%E6%84%8F%E6%8C%96%E7%9F%BF%E6%94%BB%E5%87%BB)
     - [无利益攻击](blockchain/区块链概念汇总.md#%E6%97%A0%E5%88%A9%E7%9B%8A%E6%94%BB%E5%87%BB)
     - [双花攻击](blockchain/区块链概念汇总.md#%E5%8F%8C%E8%8A%B1%E6%94%BB%E5%87%BB)
       - [控制矿工费](blockchain/区块链概念汇总.md#%E6%8E%A7%E5%88%B6%E7%9F%BF%E5%B7%A5%E8%B4%B9)
       - [控制区块的广播时间](blockchain/区块链概念汇总.md#%E6%8E%A7%E5%88%B6%E5%8C%BA%E5%9D%97%E7%9A%84%E5%B9%BF%E6%92%AD%E6%97%B6%E9%97%B4)
       - [一次确认攻击](blockchain/区块链概念汇总.md#%E4%B8%80%E6%AC%A1%E7%A1%AE%E8%AE%A4%E6%94%BB%E5%87%BB)
       - [51% 攻击](blockchain/区块链概念汇总.md#51-%E6%94%BB%E5%87%BB)
     - [异形攻击](blockchain/区块链概念汇总.md#%E5%BC%82%E5%BD%A2%E6%94%BB%E5%87%BB)
     - [供应链攻击](blockchain/区块链概念汇总.md#%E4%BE%9B%E5%BA%94%E9%93%BE%E6%94%BB%E5%87%BB)
     - [交易回滚攻击](blockchain/区块链概念汇总.md#%E4%BA%A4%E6%98%93%E5%9B%9E%E6%BB%9A%E6%94%BB%E5%87%BB)
     - [交易排挤攻击](blockchain/区块链概念汇总.md#%E4%BA%A4%E6%98%93%E6%8E%92%E6%8C%A4%E6%94%BB%E5%87%BB)
     - [随机数攻击](blockchain/区块链概念汇总.md#%E9%9A%8F%E6%9C%BA%E6%95%B0%E6%94%BB%E5%87%BB)
     - [hard_fail状态攻击](blockchain/区块链概念汇总.md#hard_fail%E7%8A%B6%E6%80%81%E6%94%BB%E5%87%BB)
     - [重放攻击](blockchain/区块链概念汇总.md#%E9%87%8D%E6%94%BE%E6%94%BB%E5%87%BB)
     - [重入攻击](blockchain/区块链概念汇总.md#%E9%87%8D%E5%85%A5%E6%94%BB%E5%87%BB)
     - [短地址攻击](blockchain/区块链概念汇总.md#%E7%9F%AD%E5%9C%B0%E5%9D%80%E6%94%BB%E5%87%BB)
     - [整型溢出攻击](blockchain/区块链概念汇总.md#%E6%95%B4%E5%9E%8B%E6%BA%A2%E5%87%BA%E6%94%BB%E5%87%BB)
     - [条件竞争攻击](blockchain/区块链概念汇总.md#%E6%9D%A1%E4%BB%B6%E7%AB%9E%E4%BA%89%E6%94%BB%E5%87%BB)
     - [越权访问攻击](blockchain/区块链概念汇总.md#%E8%B6%8A%E6%9D%83%E8%AE%BF%E9%97%AE%E6%94%BB%E5%87%BB)
     - [交易顺序依赖攻击](blockchain/区块链概念汇总.md#%E4%BA%A4%E6%98%93%E9%A1%BA%E5%BA%8F%E4%BE%9D%E8%B5%96%E6%94%BB%E5%87%BB)
     - [女巫攻击](blockchain/区块链概念汇总.md#%E5%A5%B3%E5%B7%AB%E6%94%BB%E5%87%BB)
     - [假错误通知攻击](blockchain/区块链概念汇总.md#%E5%81%87%E9%94%99%E8%AF%AF%E9%80%9A%E7%9F%A5%E6%94%BB%E5%87%BB)
     - [粉尘攻击](blockchain/区块链概念汇总.md#%E7%B2%89%E5%B0%98%E6%94%BB%E5%87%BB)
     - [命令执行与控制 C2](blockchain/区块链概念汇总.md#%E5%91%BD%E4%BB%A4%E6%89%A7%E8%A1%8C%E4%B8%8E%E6%8E%A7%E5%88%B6-c2)

## [区块链设计](blockchain/区块链设计.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E8%AE%BE%E8%AE%A1)

   - [共识算法](blockchain/区块链设计.md#%E5%85%B1%E8%AF%86%E7%AE%97%E6%B3%95)
     - [PBFT](blockchain/区块链设计.md#pbft)
       - [leader 选举](blockchain/区块链设计.md#leader-%E9%80%89%E4%B8%BE)
       - [角色](blockchain/区块链设计.md#%E8%A7%92%E8%89%B2)
       - [共识流程](blockchain/区块链设计.md#%E5%85%B1%E8%AF%86%E6%B5%81%E7%A8%8B)
         - [打包区块 生成Prepare](blockchain/区块链设计.md#%E6%89%93%E5%8C%85%E5%8C%BA%E5%9D%97-%E7%94%9F%E6%88%90prepare)
         - [Pre-prepare](blockchain/区块链设计.md#pre-prepare)
         - [Prepare](blockchain/区块链设计.md#prepare)
         - [Commit](blockchain/区块链设计.md#commit)
         - [ViewChange](blockchain/区块链设计.md#viewchange)
   - [轻节点](blockchain/区块链设计.md#%E8%BD%BB%E8%8A%82%E7%82%B9)
     - [默克尔树 Merkle tree](blockchain/区块链设计.md#%E9%BB%98%E5%85%8B%E5%B0%94%E6%A0%91-merkle-tree)
     - [MPT(Merkle Patricia Tree)](blockchain/区块链设计.md#mptmerkle-patricia-tree)
   - [加密算法](blockchain/区块链设计.md#%E5%8A%A0%E5%AF%86%E7%AE%97%E6%B3%95)

## [智能合约-solidity](blockchain/智能合约-solidity.md#%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6-solidity)

   - [Solidity](blockchain/智能合约-solidity.md#solidity)
   - [ABI](blockchain/智能合约-solidity.md#abi)
   - [Event/Log](blockchain/智能合约-solidity.md#eventlog)
   - [修饰符](blockchain/智能合约-solidity.md#%E4%BF%AE%E9%A5%B0%E7%AC%A6)
   - [抽象类与接口](blockchain/智能合约-solidity.md#%E6%8A%BD%E8%B1%A1%E7%B1%BB%E4%B8%8E%E6%8E%A5%E5%8F%A3)
   - [常见问题](blockchain/智能合约-solidity.md#%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98)

## [智能合约-设计模式](blockchain/智能合约-设计模式.md#%E6%99%BA%E8%83%BD%E5%90%88%E7%BA%A6-%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F)

   - [设计模式](blockchain/智能合约-设计模式.md#%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F)
     - [安全 Security](blockchain/智能合约-设计模式.md#%E5%AE%89%E5%85%A8-security)
     - [可维护性 Maintaince](blockchain/智能合约-设计模式.md#%E5%8F%AF%E7%BB%B4%E6%8A%A4%E6%80%A7-maintaince)
     - [生命周期 Lifecycle](blockchain/智能合约-设计模式.md#%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F-lifecycle)
     - [权限 Authorization](blockchain/智能合约-设计模式.md#%E6%9D%83%E9%99%90-authorization)
     - [行为控制 Action And Control](blockchain/智能合约-设计模式.md#%E8%A1%8C%E4%B8%BA%E6%8E%A7%E5%88%B6-action-and-control)

## [白皮书-以太坊](blockchain/白皮书-以太坊.md#%E7%99%BD%E7%9A%AE%E4%B9%A6-%E4%BB%A5%E5%A4%AA%E5%9D%8A)

   - [以太坊白皮书 ETH White paper](blockchain/白皮书-以太坊.md#%E4%BB%A5%E5%A4%AA%E5%9D%8A%E7%99%BD%E7%9A%AE%E4%B9%A6-eth-white-paper)
   - [历史](blockchain/白皮书-以太坊.md#%E5%8E%86%E5%8F%B2)
     - [作为状态转换系统的比特币](blockchain/白皮书-以太坊.md#%E4%BD%9C%E4%B8%BA%E7%8A%B6%E6%80%81%E8%BD%AC%E6%8D%A2%E7%B3%BB%E7%BB%9F%E7%9A%84%E6%AF%94%E7%89%B9%E5%B8%81)
     - [挖矿](blockchain/白皮书-以太坊.md#%E6%8C%96%E7%9F%BF)
     - [默克尔树](blockchain/白皮书-以太坊.md#%E9%BB%98%E5%85%8B%E5%B0%94%E6%A0%91)
     - [其它的区块链应用](blockchain/白皮书-以太坊.md#%E5%85%B6%E5%AE%83%E7%9A%84%E5%8C%BA%E5%9D%97%E9%93%BE%E5%BA%94%E7%94%A8)
     - [脚本](blockchain/白皮书-以太坊.md#%E8%84%9A%E6%9C%AC)
   - [以太坊](blockchain/白皮书-以太坊.md#%E4%BB%A5%E5%A4%AA%E5%9D%8A)
     - [以太坊账户](blockchain/白皮书-以太坊.md#%E4%BB%A5%E5%A4%AA%E5%9D%8A%E8%B4%A6%E6%88%B7)
     - [消息和交易](blockchain/白皮书-以太坊.md#%E6%B6%88%E6%81%AF%E5%92%8C%E4%BA%A4%E6%98%93)
     - [以太坊状态转换函数](blockchain/白皮书-以太坊.md#%E4%BB%A5%E5%A4%AA%E5%9D%8A%E7%8A%B6%E6%80%81%E8%BD%AC%E6%8D%A2%E5%87%BD%E6%95%B0)
     - [代码执行](blockchain/白皮书-以太坊.md#%E4%BB%A3%E7%A0%81%E6%89%A7%E8%A1%8C)
     - [区块链和挖矿](blockchain/白皮书-以太坊.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E5%92%8C%E6%8C%96%E7%9F%BF)
   - [应用](blockchain/白皮书-以太坊.md#%E5%BA%94%E7%94%A8)
     - [令牌系统](blockchain/白皮书-以太坊.md#%E4%BB%A4%E7%89%8C%E7%B3%BB%E7%BB%9F)
     - [金融衍生品和价值稳定的货币](blockchain/白皮书-以太坊.md#%E9%87%91%E8%9E%8D%E8%A1%8D%E7%94%9F%E5%93%81%E5%92%8C%E4%BB%B7%E5%80%BC%E7%A8%B3%E5%AE%9A%E7%9A%84%E8%B4%A7%E5%B8%81)
     - [身份和信誉系统](blockchain/白皮书-以太坊.md#%E8%BA%AB%E4%BB%BD%E5%92%8C%E4%BF%A1%E8%AA%89%E7%B3%BB%E7%BB%9F)
     - [去中心化存储](blockchain/白皮书-以太坊.md#%E5%8E%BB%E4%B8%AD%E5%BF%83%E5%8C%96%E5%AD%98%E5%82%A8)
     - [去中心化自治组织](blockchain/白皮书-以太坊.md#%E5%8E%BB%E4%B8%AD%E5%BF%83%E5%8C%96%E8%87%AA%E6%B2%BB%E7%BB%84%E7%BB%87)
     - [进一步的应用](blockchain/白皮书-以太坊.md#%E8%BF%9B%E4%B8%80%E6%AD%A5%E7%9A%84%E5%BA%94%E7%94%A8)
   - [杂项和关注](blockchain/白皮书-以太坊.md#%E6%9D%82%E9%A1%B9%E5%92%8C%E5%85%B3%E6%B3%A8)
     - [改进版幽灵协议的实施](blockchain/白皮书-以太坊.md#%E6%94%B9%E8%BF%9B%E7%89%88%E5%B9%BD%E7%81%B5%E5%8D%8F%E8%AE%AE%E7%9A%84%E5%AE%9E%E6%96%BD)
     - [费用](blockchain/白皮书-以太坊.md#%E8%B4%B9%E7%94%A8)
     - [计算和图灵完备](blockchain/白皮书-以太坊.md#%E8%AE%A1%E7%AE%97%E5%92%8C%E5%9B%BE%E7%81%B5%E5%AE%8C%E5%A4%87)
     - [货币和发行](blockchain/白皮书-以太坊.md#%E8%B4%A7%E5%B8%81%E5%92%8C%E5%8F%91%E8%A1%8C)
     - [发行分解](blockchain/白皮书-以太坊.md#%E5%8F%91%E8%A1%8C%E5%88%86%E8%A7%A3)
     - [挖矿的中心化](blockchain/白皮书-以太坊.md#%E6%8C%96%E7%9F%BF%E7%9A%84%E4%B8%AD%E5%BF%83%E5%8C%96)
     - [扩展性](blockchain/白皮书-以太坊.md#%E6%89%A9%E5%B1%95%E6%80%A7)
   - [综述：去中心化应用](blockchain/白皮书-以太坊.md#%E7%BB%BC%E8%BF%B0%E5%8E%BB%E4%B8%AD%E5%BF%83%E5%8C%96%E5%BA%94%E7%94%A8)
   - [结论](blockchain/白皮书-以太坊.md#%E7%BB%93%E8%AE%BA)
   - [注解与进阶阅读](blockchain/白皮书-以太坊.md#%E6%B3%A8%E8%A7%A3%E4%B8%8E%E8%BF%9B%E9%98%B6%E9%98%85%E8%AF%BB)
     - [　注解](blockchain/白皮书-以太坊.md#%E6%B3%A8%E8%A7%A3)
     - [　进阶阅读](blockchain/白皮书-以太坊.md#%E8%BF%9B%E9%98%B6%E9%98%85%E8%AF%BB)

## [白皮书-比特币](blockchain/白皮书-比特币.md#%E7%99%BD%E7%9A%AE%E4%B9%A6-%E6%AF%94%E7%89%B9%E5%B8%81)

   - [Bitcoin: A Peer-to-Peer Electronic Cash System](blockchain/白皮书-比特币.md#bitcoin-a-peer-to-peer-electronic-cash-system)
   - [比特币：一种点对点电子货币系统](blockchain/白皮书-比特币.md#%E6%AF%94%E7%89%B9%E5%B8%81%E4%B8%80%E7%A7%8D%E7%82%B9%E5%AF%B9%E7%82%B9%E7%94%B5%E5%AD%90%E8%B4%A7%E5%B8%81%E7%B3%BB%E7%BB%9F)
   - [1. Introduction](blockchain/白皮书-比特币.md#1-introduction)
   - [1、简介](blockchain/白皮书-比特币.md#1%E7%AE%80%E4%BB%8B)
   - [2. Transactions](blockchain/白皮书-比特币.md#2-transactions)
   - [2、交易](blockchain/白皮书-比特币.md#2%E4%BA%A4%E6%98%93)
   - [3. Timestamp Server](blockchain/白皮书-比特币.md#3-timestamp-server)
   - [3、时间戳服务器](blockchain/白皮书-比特币.md#3%E6%97%B6%E9%97%B4%E6%88%B3%E6%9C%8D%E5%8A%A1%E5%99%A8)
   - [4. Proof-of-Work](blockchain/白皮书-比特币.md#4-proof-of-work)
   - [4、工作量证明](blockchain/白皮书-比特币.md#4%E5%B7%A5%E4%BD%9C%E9%87%8F%E8%AF%81%E6%98%8E)
   - [5. Network](blockchain/白皮书-比特币.md#5-network)
   - [5、网络](blockchain/白皮书-比特币.md#5%E7%BD%91%E7%BB%9C)
   - [6. Incentive](blockchain/白皮书-比特币.md#6-incentive)
   - [6、激励](blockchain/白皮书-比特币.md#6%E6%BF%80%E5%8A%B1)
   - [7. Reclaiming Disk Space](blockchain/白皮书-比特币.md#7-reclaiming-disk-space)
   - [7、回收磁盘空间](blockchain/白皮书-比特币.md#7%E5%9B%9E%E6%94%B6%E7%A3%81%E7%9B%98%E7%A9%BA%E9%97%B4)
   - [8. Simplified Payment Verification](blockchain/白皮书-比特币.md#8-simplified-payment-verification)
   - [8、 简化的支付验证](blockchain/白皮书-比特币.md#8-%E7%AE%80%E5%8C%96%E7%9A%84%E6%94%AF%E4%BB%98%E9%AA%8C%E8%AF%81)
   - [9. Combining and Splitting Value](blockchain/白皮书-比特币.md#9-combining-and-splitting-value)
   - [9、合并和分割交易额](blockchain/白皮书-比特币.md#9%E5%90%88%E5%B9%B6%E5%92%8C%E5%88%86%E5%89%B2%E4%BA%A4%E6%98%93%E9%A2%9D)
   - [10. Privacy](blockchain/白皮书-比特币.md#10-privacy)
   - [10、隐私](blockchain/白皮书-比特币.md#10%E9%9A%90%E7%A7%81)
   - [11. Calculations](blockchain/白皮书-比特币.md#11-calculations)
   - [11、计算](blockchain/白皮书-比特币.md#11%E8%AE%A1%E7%AE%97)
   - [12. Conclusion](blockchain/白皮书-比特币.md#12-conclusion)
   - [12、总结](blockchain/白皮书-比特币.md#12%E6%80%BB%E7%BB%93)
   - [参考文献 (References)](blockchain/白皮书-比特币.md#%E5%8F%82%E8%80%83%E6%96%87%E7%8C%AE-references)

## [联盟链](blockchain/联盟链.md#%E8%81%94%E7%9B%9F%E9%93%BE)

   - [联盟链 consortium blockchain](blockchain/联盟链.md#%E8%81%94%E7%9B%9F%E9%93%BE-consortium-blockchain)
   - [FISCO BCOS](blockchain/联盟链.md#fisco-bcos)
     - [节点准入机制](blockchain/联盟链.md#%E8%8A%82%E7%82%B9%E5%87%86%E5%85%A5%E6%9C%BA%E5%88%B6)
       - [网络准入机制](blockchain/联盟链.md#%E7%BD%91%E7%BB%9C%E5%87%86%E5%85%A5%E6%9C%BA%E5%88%B6)
       - [群组准入机制](blockchain/联盟链.md#%E7%BE%A4%E7%BB%84%E5%87%86%E5%85%A5%E6%9C%BA%E5%88%B6)
     - [国密算法](blockchain/联盟链.md#%E5%9B%BD%E5%AF%86%E7%AE%97%E6%B3%95)
     - [WeBASE](blockchain/联盟链.md#webase)
     - [WeIdentity](blockchain/联盟链.md#weidentity)

# design-patterns

## [代理](design-patterns/代理.md#%E4%BB%A3%E7%90%86)

   - [代理模式](design-patterns/代理.md#%E4%BB%A3%E7%90%86%E6%A8%A1%E5%BC%8F)
   - [场景](design-patterns/代理.md#%E5%9C%BA%E6%99%AF)
   - [静态代理](design-patterns/代理.md#%E9%9D%99%E6%80%81%E4%BB%A3%E7%90%86)
   - [动态代理](design-patterns/代理.md#%E5%8A%A8%E6%80%81%E4%BB%A3%E7%90%86)
   - [cglib](design-patterns/代理.md#cglib)

## [单例](design-patterns/单例.md#%E5%8D%95%E4%BE%8B)

   - [单例模式 singleton](design-patterns/单例.md#%E5%8D%95%E4%BE%8B%E6%A8%A1%E5%BC%8F-singleton)
   - [场景](design-patterns/单例.md#%E5%9C%BA%E6%99%AF)
   - [JDK源码中的案例](design-patterns/单例.md#jdk%E6%BA%90%E7%A0%81%E4%B8%AD%E7%9A%84%E6%A1%88%E4%BE%8B)
   - [Best Way](design-patterns/单例.md#best-way)
   - [Other Way](design-patterns/单例.md#other-way)
     - [懒饿汉及双重检查锁](design-patterns/单例.md#%E6%87%92%E9%A5%BF%E6%B1%89%E5%8F%8A%E5%8F%8C%E9%87%8D%E6%A3%80%E6%9F%A5%E9%94%81)

## [桥接](design-patterns/桥接.md#%E6%A1%A5%E6%8E%A5)

   - [Bridge](design-patterns/桥接.md#bridge)
   - [场景](design-patterns/桥接.md#%E5%9C%BA%E6%99%AF)
   - [代码示例](design-patterns/桥接.md#%E4%BB%A3%E7%A0%81%E7%A4%BA%E4%BE%8B)
   - [项目案例](design-patterns/桥接.md#%E9%A1%B9%E7%9B%AE%E6%A1%88%E4%BE%8B)
   - [Tutorial](design-patterns/桥接.md#tutorial)

## [模板](design-patterns/模板.md#%E6%A8%A1%E6%9D%BF)

   - [Template method](design-patterns/模板.md#template-method)
   - [场景](design-patterns/模板.md#%E5%9C%BA%E6%99%AF)
   - [示例](design-patterns/模板.md#%E7%A4%BA%E4%BE%8B)
   - [JDK及各大框架源码中的应用](design-patterns/模板.md#jdk%E5%8F%8A%E5%90%84%E5%A4%A7%E6%A1%86%E6%9E%B6%E6%BA%90%E7%A0%81%E4%B8%AD%E7%9A%84%E5%BA%94%E7%94%A8)

## [装饰者](design-patterns/装饰者.md#%E8%A3%85%E9%A5%B0%E8%80%85)

   - [装饰者 Decorator](design-patterns/装饰者.md#%E8%A3%85%E9%A5%B0%E8%80%85-decorator)
   - [场景](design-patterns/装饰者.md#%E5%9C%BA%E6%99%AF)
   - [JDK及各大框架源码中的案例](design-patterns/装饰者.md#jdk%E5%8F%8A%E5%90%84%E5%A4%A7%E6%A1%86%E6%9E%B6%E6%BA%90%E7%A0%81%E4%B8%AD%E7%9A%84%E6%A1%88%E4%BE%8B)
   - [代码案例](design-patterns/装饰者.md#%E4%BB%A3%E7%A0%81%E6%A1%88%E4%BE%8B)

## [观察者](design-patterns/观察者.md#%E8%A7%82%E5%AF%9F%E8%80%85)

   - [Observer](design-patterns/观察者.md#observer)
   - [应用案例](design-patterns/观察者.md#%E5%BA%94%E7%94%A8%E6%A1%88%E4%BE%8B)
   - [JDK源码及各大框架中的应用](design-patterns/观察者.md#jdk%E6%BA%90%E7%A0%81%E5%8F%8A%E5%90%84%E5%A4%A7%E6%A1%86%E6%9E%B6%E4%B8%AD%E7%9A%84%E5%BA%94%E7%94%A8)

## [设计模式](design-patterns/设计模式.md#%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F)

   - [23种设计模式](design-patterns/设计模式.md#23%E7%A7%8D%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F)
   - [关键字](design-patterns/设计模式.md#%E5%85%B3%E9%94%AE%E5%AD%97)
     - [开闭原则](design-patterns/设计模式.md#%E5%BC%80%E9%97%AD%E5%8E%9F%E5%88%99)
     - [里氏替换原则](design-patterns/设计模式.md#%E9%87%8C%E6%B0%8F%E6%9B%BF%E6%8D%A2%E5%8E%9F%E5%88%99)
     - [依赖倒置原则](design-patterns/设计模式.md#%E4%BE%9D%E8%B5%96%E5%80%92%E7%BD%AE%E5%8E%9F%E5%88%99)
     - [单一职责原则](design-patterns/设计模式.md#%E5%8D%95%E4%B8%80%E8%81%8C%E8%B4%A3%E5%8E%9F%E5%88%99)
     - [接口隔离原则](design-patterns/设计模式.md#%E6%8E%A5%E5%8F%A3%E9%9A%94%E7%A6%BB%E5%8E%9F%E5%88%99)
     - [迪米特法则](design-patterns/设计模式.md#%E8%BF%AA%E7%B1%B3%E7%89%B9%E6%B3%95%E5%88%99)
     - [合成复用原则](design-patterns/设计模式.md#%E5%90%88%E6%88%90%E5%A4%8D%E7%94%A8%E5%8E%9F%E5%88%99)

## [责任链](design-patterns/责任链.md#%E8%B4%A3%E4%BB%BB%E9%93%BE)

   - [责任链模式 Chain of Responsibility Pattern](design-patterns/责任链.md#%E8%B4%A3%E4%BB%BB%E9%93%BE%E6%A8%A1%E5%BC%8F-chain-of-responsibility-pattern)
   - [代码示例](design-patterns/责任链.md#%E4%BB%A3%E7%A0%81%E7%A4%BA%E4%BE%8B)
   - [JDK源码在的案例](design-patterns/责任链.md#jdk%E6%BA%90%E7%A0%81%E5%9C%A8%E7%9A%84%E6%A1%88%E4%BE%8B)

## [迭代器](design-patterns/迭代器.md#%E8%BF%AD%E4%BB%A3%E5%99%A8)

   - [Iterator 迭代器模式](design-patterns/迭代器.md#iterator-%E8%BF%AD%E4%BB%A3%E5%99%A8%E6%A8%A1%E5%BC%8F)
   - [场景](design-patterns/迭代器.md#%E5%9C%BA%E6%99%AF)
   - [代码示例](design-patterns/迭代器.md#%E4%BB%A3%E7%A0%81%E7%A4%BA%E4%BE%8B)
   - [JDK源码中的案例](design-patterns/迭代器.md#jdk%E6%BA%90%E7%A0%81%E4%B8%AD%E7%9A%84%E6%A1%88%E4%BE%8B)

## [适配器](design-patterns/适配器.md#%E9%80%82%E9%85%8D%E5%99%A8)

   - [适配器模式 Adapter](design-patterns/适配器.md#%E9%80%82%E9%85%8D%E5%99%A8%E6%A8%A1%E5%BC%8F-adapter)
   - [场景](design-patterns/适配器.md#%E5%9C%BA%E6%99%AF)
   - [JDK源码中的案例](design-patterns/适配器.md#jdk%E6%BA%90%E7%A0%81%E4%B8%AD%E7%9A%84%E6%A1%88%E4%BE%8B)

# hacker

## [blackchain-bug-erc](hacker/blackchain-bug-erc.md#blackchain-bug-erc)

   - [ATN 抵御合约攻击的报告](hacker/blackchain-bug-erc.md#atn-%E6%8A%B5%E5%BE%A1%E5%90%88%E7%BA%A6%E6%94%BB%E5%87%BB%E7%9A%84%E6%8A%A5%E5%91%8A)
     - [基于ERC223与DS-AUTH的混合漏洞](hacker/blackchain-bug-erc.md#%E5%9F%BA%E4%BA%8Eerc223%E4%B8%8Eds-auth%E7%9A%84%E6%B7%B7%E5%90%88%E6%BC%8F%E6%B4%9E)
       - [攻击：](hacker/blackchain-bug-erc.md#%E6%94%BB%E5%87%BB)
       - [漏洞评估：](hacker/blackchain-bug-erc.md#%E6%BC%8F%E6%B4%9E%E8%AF%84%E4%BC%B0)
       - [应对措施：](hacker/blackchain-bug-erc.md#%E5%BA%94%E5%AF%B9%E6%8E%AA%E6%96%BD)
       - [总结](hacker/blackchain-bug-erc.md#%E6%80%BB%E7%BB%93)
       - [对其他以太坊Token合约的预警:](hacker/blackchain-bug-erc.md#%E5%AF%B9%E5%85%B6%E4%BB%96%E4%BB%A5%E5%A4%AA%E5%9D%8Atoken%E5%90%88%E7%BA%A6%E7%9A%84%E9%A2%84%E8%AD%A6)

## [blackchain-bug-parity-wallets](hacker/blackchain-bug-parity-wallets.md#blackchain-bug-parity-wallets)

   - [Parity Wallet Multisig Hack](hacker/blackchain-bug-parity-wallets.md#parity-wallet-multisig-hack)
   - [第一次攻击](hacker/blackchain-bug-parity-wallets.md#%E7%AC%AC%E4%B8%80%E6%AC%A1%E6%94%BB%E5%87%BB)
     - [解决方案](hacker/blackchain-bug-parity-wallets.md#%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88)
   - [第二次攻击](hacker/blackchain-bug-parity-wallets.md#%E7%AC%AC%E4%BA%8C%E6%AC%A1%E6%94%BB%E5%87%BB)
   - [最后](hacker/blackchain-bug-parity-wallets.md#%E6%9C%80%E5%90%8E)

## [github-bug](hacker/github-bug.md#github-bug)

   - [GitHub Security Bug Bounty](hacker/github-bug.md#github-security-bug-bounty)
   - [绕开 GitHub OAuth](hacker/github-bug.md#%E7%BB%95%E5%BC%80-github-oauth)
     - [滥用 HTTP HEAD 请求](hacker/github-bug.md#%E6%BB%A5%E7%94%A8-http-head-%E8%AF%B7%E6%B1%82)
     - [参考](hacker/github-bug.md#%E5%8F%82%E8%80%83)

# web

## [README](web/README.md#readme)

 - [汇编](web/README.md#%E6%B1%87%E7%BC%96)
   - [WebAssembly](web/README.md#webassembly)
   - [asm.js](web/README.md#asmjs)

# 面试

## [JAVA响应式编程](面试/JAVA响应式编程.md#java%E5%93%8D%E5%BA%94%E5%BC%8F%E7%BC%96%E7%A8%8B)

   - [Reactive 响应式编程](面试/JAVA响应式编程.md#reactive-%E5%93%8D%E5%BA%94%E5%BC%8F%E7%BC%96%E7%A8%8B)

## [JAVA基础](面试/JAVA基础.md#java%E5%9F%BA%E7%A1%80)

   - [打印JAVA信息](面试/JAVA基础.md#%E6%89%93%E5%8D%B0java%E4%BF%A1%E6%81%AF)
   - [版本](面试/JAVA基础.md#%E7%89%88%E6%9C%AC)
     - [JDK 1.0](面试/JAVA基础.md#jdk-10)
     - [JDK 1.1](面试/JAVA基础.md#jdk-11)
     - [J2SE 1.2](面试/JAVA基础.md#j2se-12)
     - [J2SE 1.3](面试/JAVA基础.md#j2se-13)
     - [J2SE 1.4](面试/JAVA基础.md#j2se-14)
     - [J2SE 5.0](面试/JAVA基础.md#j2se-50)
     - [Java SE 6](面试/JAVA基础.md#java-se-6)
     - [Java SE 7](面试/JAVA基础.md#java-se-7)
     - [Java SE 8](面试/JAVA基础.md#java-se-8)
     - [Java SE 9](面试/JAVA基础.md#java-se-9)
     - [Java SE 10](面试/JAVA基础.md#java-se-10)
     - [Java SE 11](面试/JAVA基础.md#java-se-11)
     - [Java SE 12](面试/JAVA基础.md#java-se-12)
     - [Java SE 13](面试/JAVA基础.md#java-se-13)
     - [Java SE 14](面试/JAVA基础.md#java-se-14)
   - [HashMap](面试/JAVA基础.md#hashmap)
     - [链表与数组](面试/JAVA基础.md#%E9%93%BE%E8%A1%A8%E4%B8%8E%E6%95%B0%E7%BB%84)
     - [红黑树](面试/JAVA基础.md#%E7%BA%A2%E9%BB%91%E6%A0%91)
   - [List集合，多线程计算总和](面试/JAVA基础.md#list%E9%9B%86%E5%90%88%E5%A4%9A%E7%BA%BF%E7%A8%8B%E8%AE%A1%E7%AE%97%E6%80%BB%E5%92%8C)
   - [List 去重](面试/JAVA基础.md#list-%E5%8E%BB%E9%87%8D)
   - [三个线程顺序打印ABC](面试/JAVA基础.md#%E4%B8%89%E4%B8%AA%E7%BA%BF%E7%A8%8B%E9%A1%BA%E5%BA%8F%E6%89%93%E5%8D%B0abc)
   - [可以实现多继承吗？](面试/JAVA基础.md#%E5%8F%AF%E4%BB%A5%E5%AE%9E%E7%8E%B0%E5%A4%9A%E7%BB%A7%E6%89%BF%E5%90%97)
   - [画一下RPC的架构图](面试/JAVA基础.md#%E7%94%BB%E4%B8%80%E4%B8%8Brpc%E7%9A%84%E6%9E%B6%E6%9E%84%E5%9B%BE)
   - [Lock 锁](面试/JAVA基础.md#lock-%E9%94%81)
     - [synchronized](面试/JAVA基础.md#synchronized)
     - [ReentrantLock](面试/JAVA基础.md#reentrantlock)
     - [CAS](面试/JAVA基础.md#cas)
     - [AQS](面试/JAVA基础.md#aqs)
     - [ThreadLocal](面试/JAVA基础.md#threadlocal)
   - [对象在内存中的存储布局](面试/JAVA基础.md#%E5%AF%B9%E8%B1%A1%E5%9C%A8%E5%86%85%E5%AD%98%E4%B8%AD%E7%9A%84%E5%AD%98%E5%82%A8%E5%B8%83%E5%B1%80)
   - [堆外内存是什么？会溢出吗？什么时候会触发堆外内存回收？](面试/JAVA基础.md#%E5%A0%86%E5%A4%96%E5%86%85%E5%AD%98%E6%98%AF%E4%BB%80%E4%B9%88%E4%BC%9A%E6%BA%A2%E5%87%BA%E5%90%97%E4%BB%80%E4%B9%88%E6%97%B6%E5%80%99%E4%BC%9A%E8%A7%A6%E5%8F%91%E5%A0%86%E5%A4%96%E5%86%85%E5%AD%98%E5%9B%9E%E6%94%B6)
   - [序列化](面试/JAVA基础.md#%E5%BA%8F%E5%88%97%E5%8C%96)
   - [IO](面试/JAVA基础.md#io)
     - [零拷贝](面试/JAVA基础.md#%E9%9B%B6%E6%8B%B7%E8%B4%9D)

## [JVM](面试/JVM.md#jvm)

 - [CPU](面试/JVM.md#cpu)
   - [Cache line](面试/JVM.md#cache-line)
   - [MESI](面试/JVM.md#mesi)
   - [合并写](面试/JVM.md#%E5%90%88%E5%B9%B6%E5%86%99)
 - [JVM](面试/JVM.md#jvm)
   - [Volatile](面试/JVM.md#volatile)
   - [as-if-serial](面试/JVM.md#as-if-serial)
   - [Java内存模型](面试/JVM.md#java%E5%86%85%E5%AD%98%E6%A8%A1%E5%9E%8B)
     - [happens-before原则（先行发生原则）](面试/JVM.md#happens-before%E5%8E%9F%E5%88%99%E5%85%88%E8%A1%8C%E5%8F%91%E7%94%9F%E5%8E%9F%E5%88%99)
   - [Java 对象初始化](面试/JVM.md#java-%E5%AF%B9%E8%B1%A1%E5%88%9D%E5%A7%8B%E5%8C%96)
   - [类加载机制](面试/JVM.md#%E7%B1%BB%E5%8A%A0%E8%BD%BD%E6%9C%BA%E5%88%B6)
     - [类加载器](面试/JVM.md#%E7%B1%BB%E5%8A%A0%E8%BD%BD%E5%99%A8)
   - [GC](面试/JVM.md#gc)

## [Spring](面试/Spring.md#spring)

   - [Spring 问答](面试/Spring.md#spring-%E9%97%AE%E7%AD%94)
     - [Spring Bean 生命周期](面试/Spring.md#spring-bean-%E7%94%9F%E5%91%BD%E5%91%A8%E6%9C%9F)
     - [PostConstruct,PreDestroy 实现原理](面试/Spring.md#postconstructpredestroy-%E5%AE%9E%E7%8E%B0%E5%8E%9F%E7%90%86)
     - [Spring 事务隔离级别与传播机制](面试/Spring.md#spring-%E4%BA%8B%E5%8A%A1%E9%9A%94%E7%A6%BB%E7%BA%A7%E5%88%AB%E4%B8%8E%E4%BC%A0%E6%92%AD%E6%9C%BA%E5%88%B6)
       - [事务传播机制](面试/Spring.md#%E4%BA%8B%E5%8A%A1%E4%BC%A0%E6%92%AD%E6%9C%BA%E5%88%B6)
       - [隔离级别](面试/Spring.md#%E9%9A%94%E7%A6%BB%E7%BA%A7%E5%88%AB)
     - [Bean的作用域](面试/Spring.md#bean%E7%9A%84%E4%BD%9C%E7%94%A8%E5%9F%9F)
     - [Spring框架中用到了哪些设计模式](面试/Spring.md#spring%E6%A1%86%E6%9E%B6%E4%B8%AD%E7%94%A8%E5%88%B0%E4%BA%86%E5%93%AA%E4%BA%9B%E8%AE%BE%E8%AE%A1%E6%A8%A1%E5%BC%8F)
   - [Spring Security](面试/Spring.md#spring-security)
     - [Spring-Security-OAuth](面试/Spring.md#spring-security-oauth)
       - [授权](面试/Spring.md#%E6%8E%88%E6%9D%83)
       - [获得 token](面试/Spring.md#%E8%8E%B7%E5%BE%97-token)
       - [获得 Token Key](面试/Spring.md#%E8%8E%B7%E5%BE%97-token-key)
       - [验证解析 Token](面试/Spring.md#%E9%AA%8C%E8%AF%81%E8%A7%A3%E6%9E%90-token)
       - [异常](面试/Spring.md#%E5%BC%82%E5%B8%B8)

## [分布式锁](面试/分布式锁.md#%E5%88%86%E5%B8%83%E5%BC%8F%E9%94%81)

   - [分布式锁](面试/分布式锁.md#%E5%88%86%E5%B8%83%E5%BC%8F%E9%94%81)
   - [常见的实现方式](面试/分布式锁.md#%E5%B8%B8%E8%A7%81%E7%9A%84%E5%AE%9E%E7%8E%B0%E6%96%B9%E5%BC%8F)
   - [Redis 实现分布式锁](面试/分布式锁.md#redis-%E5%AE%9E%E7%8E%B0%E5%88%86%E5%B8%83%E5%BC%8F%E9%94%81)
     - [在 Spring 的实现](面试/分布式锁.md#%E5%9C%A8-spring-%E7%9A%84%E5%AE%9E%E7%8E%B0)
     - [实现代码 参考](面试/分布式锁.md#%E5%AE%9E%E7%8E%B0%E4%BB%A3%E7%A0%81-%E5%8F%82%E8%80%83)

## [如何限流](面试/如何限流.md#%E5%A6%82%E4%BD%95%E9%99%90%E6%B5%81)

   - [如何限流](面试/如何限流.md#%E5%A6%82%E4%BD%95%E9%99%90%E6%B5%81)
   - [主流框架的实现](面试/如何限流.md#%E4%B8%BB%E6%B5%81%E6%A1%86%E6%9E%B6%E7%9A%84%E5%AE%9E%E7%8E%B0)
     - [Nginx](面试/如何限流.md#nginx)
     - [spring-cloud-gateway](面试/如何限流.md#spring-cloud-gateway)
     - [Alibaba Sentinel](面试/如何限流.md#alibaba-sentinel)
       - [配置方式](面试/如何限流.md#%E9%85%8D%E7%BD%AE%E6%96%B9%E5%BC%8F)
   - [自己实现](面试/如何限流.md#%E8%87%AA%E5%B7%B1%E5%AE%9E%E7%8E%B0)
     - [计数器](面试/如何限流.md#%E8%AE%A1%E6%95%B0%E5%99%A8)
     - [队列](面试/如何限流.md#%E9%98%9F%E5%88%97)
     - [**令牌桶**](面试/如何限流.md#%E4%BB%A4%E7%89%8C%E6%A1%B6)
<!-- end listify -->










