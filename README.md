Developer Notes
--------------------
开发者笔记  

-----------

**tools:**  
- [listify](https://github.com/ifuture-pro/listify)  生成全站目录
- [docsify](https://docsify.js.org/) 生成静态站点
- [github page](https://help.github.com/en/github/working-with-github-pages/getting-started-with-github-pages) 发布静态站点

提高阅读体验   
https://developer.ifuture.pro/  


<!-- start listify -->

Table of Contents
-----------
  > *generated with [listify](https://github.com/ifuture-pro/listify)*

[区块链概念汇总](blockchain/区块链概念汇总.md#%E5%8C%BA%E5%9D%97%E9%93%BE%E6%A6%82%E5%BF%B5%E6%B1%87%E6%80%BB)
-------
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
       - [PBFT](blockchain/区块链概念汇总.md#pbft)
   - [隐私保护](blockchain/区块链概念汇总.md#%E9%9A%90%E7%A7%81%E4%BF%9D%E6%8A%A4)
     - [隐私保护算法](blockchain/区块链概念汇总.md#%E9%9A%90%E7%A7%81%E4%BF%9D%E6%8A%A4%E7%AE%97%E6%B3%95)
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

[MYSQL基础优化](database/MYSQL基础优化.md#mysql%E5%9F%BA%E7%A1%80%E4%BC%98%E5%8C%96)
-------
   - [SQL基础优化](database/MYSQL基础优化.md#sql%E5%9F%BA%E7%A1%80%E4%BC%98%E5%8C%96)

[微服务](devops/微服务.md#%E5%BE%AE%E6%9C%8D%E5%8A%A1)
-------
   - [微服务](devops/微服务.md#%E5%BE%AE%E6%9C%8D%E5%8A%A1)
   - [Spring cloud 与 Kubernetes 组件](devops/微服务.md#spring-cloud-%E4%B8%8E-kubernetes-%E7%BB%84%E4%BB%B6)
       - [优秀案例](devops/微服务.md#%E4%BC%98%E7%A7%80%E6%A1%88%E4%BE%8B)

[日常杂项](notepad/日常杂项.md#%E6%97%A5%E5%B8%B8%E6%9D%82%E9%A1%B9)
-------
   - [Linux](notepad/日常杂项.md#linux)
     - [系统](notepad/日常杂项.md#%E7%B3%BB%E7%BB%9F)
       - [查看系统](notepad/日常杂项.md#%E6%9F%A5%E7%9C%8B%E7%B3%BB%E7%BB%9F)
       - [设置时区](notepad/日常杂项.md#%E8%AE%BE%E7%BD%AE%E6%97%B6%E5%8C%BA)
     - [编辑](notepad/日常杂项.md#%E7%BC%96%E8%BE%91)
       - [VIM中文乱码](notepad/日常杂项.md#vim%E4%B8%AD%E6%96%87%E4%B9%B1%E7%A0%81)
       - [sed](notepad/日常杂项.md#sed)
   - [Git](notepad/日常杂项.md#git)
     - [基础](notepad/日常杂项.md#%E5%9F%BA%E7%A1%80)
       - [查看所有分支(包括远程)](notepad/日常杂项.md#%E6%9F%A5%E7%9C%8B%E6%89%80%E6%9C%89%E5%88%86%E6%94%AF%E5%8C%85%E6%8B%AC%E8%BF%9C%E7%A8%8B)
       - [删除分支](notepad/日常杂项.md#%E5%88%A0%E9%99%A4%E5%88%86%E6%94%AF)
       - [新建分支](notepad/日常杂项.md#%E6%96%B0%E5%BB%BA%E5%88%86%E6%94%AF)
       - [tags](notepad/日常杂项.md#tags)
   - [Mysql](notepad/日常杂项.md#mysql)
     - [创建数据库](notepad/日常杂项.md#%E5%88%9B%E5%BB%BA%E6%95%B0%E6%8D%AE%E5%BA%93)
     - [创建用户并授权](notepad/日常杂项.md#%E5%88%9B%E5%BB%BA%E7%94%A8%E6%88%B7%E5%B9%B6%E6%8E%88%E6%9D%83)
     - [导入导出数据](notepad/日常杂项.md#%E5%AF%BC%E5%85%A5%E5%AF%BC%E5%87%BA%E6%95%B0%E6%8D%AE)
   - [Docker](notepad/日常杂项.md#docker)
   - [Kubernetes](notepad/日常杂项.md#kubernetes)
     - [Ingress](notepad/日常杂项.md#ingress)
<!-- end listify -->














































