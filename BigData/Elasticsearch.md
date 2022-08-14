## Elasticsearch
## 关键字
* Cluster：集群。

  ES可以作为一个独立的单个搜索服务器。不过，为了处理大型数据集，实现容错和高可用性，ES可以运行在许多互相合作的服务器上。这些服务器的集合称为集群。

* Node：节点。
  形成集群的每个服务器称为节点。

* Shard：分片。

  当有大量的文档时，由于内存的限制、磁盘处理能力不足、无法足够快的响应客户端的请求等，一个节点可能不够。这种情况下，数据可以分为较小的分片。每个分片放到不同的服务器上。
  当你查询的索引分布在多个分片上时，ES会把查询发送给每个相关的分片，并将结果组合在一起，而应用程序并不知道分片的存在。即：这个过程对用户来说是透明的。

* Replia：副本。

  为提高查询吞吐量或实现高可用性，可以使用分片副本。
  副本是一个分片的精确复制，每个分片可以有零个或多个副本。ES中可以有许多相同的分片，其中之一被选择更改索引操作，这种特殊的分片称为主分片。
  当主分片丢失时，如：该分片所在的数据不可用时，集群将副本提升为新的主分片。

* 全文检索。

  全文检索就是对一篇文章进行索引，可以根据关键字搜索，类似于mysql里的like语句。
  全文索引就是把内容根据词的意义进行分词，然后分别创建索引，例如”你们的激情是因为什么事情来的” 可能会被分词成：“你们“，”激情“，“什么事情“，”来“ 等token，这样当你搜索“你们” 或者 “激情” 都会把这句搜出来。

|Elasticsearch|MySQL|
|------|------|
|Index|Database|
|Type| Table|
|Mapping|Schema|
|Document| Row|
|Field| Column|
|Query DSL| SQL|
|Restful API|insert select update delete|

### 安装
* Docker
```bash
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 --restart=always elasticsearch:6.8.5
```
* 极限网关
http://gateway.infinilabs.com/zh/

### 常用API
```shell
-- 所有节点
curl http://127.0.0.1:9200/_cat/nodes?v
-- 所有 index
curl 'localhost:9200/_cat/indices?v'

-- 导入导出 https://github.com/elasticsearch-dump/elasticsearch-dump
elasticdump --input=http://localhost:9200/index-law --output=my_index.json --type=data

```

#### 备份
```shell
vim /etc/elasticsearch/elasticsearch.yml
path.repo: "/data/elasticsearch/backup

curl -XPOST -H 'Content-Type: application/json' http://127.0.0.1:9200/_snapshot/my_es_backup -d '
{
    "type": "fs",
    "settings": {
        "location": "/home/sdb1/my_es_backup",
        "max_snapshot_bytes_per_sec" : "100mb",
        "max_restore_bytes_per_sec" : "100mb",
        "compress" : true
    }
}'

-- 查看
curl -XGET "localhost:9200/_snapshot/my_es_backup/_all?pretty"
-- 恢复
curl -XPOST http://127.0.0.1:9200/_snapshot/my_es_backup/snapshot_1/_restore?wait_for_completion=true
```

## elasticsearch-head
> A web front end for an elastic search cluster
### 安装

* Docker
```bash
docker run -d --name es-head -p 9100:9100 mobz/elasticsearch-head:5
```
* 跨域问题 `No 'Access-Control-Allow-Origin'`

  **修改 elasticsearch 配置文件**
  ```bash
  vim /usr/share/elasticsearch/config/elasticsearch.yml

  #开启跨域访问支持，默认为false
  http.cors.enabled: true
  #跨域访问允许的域名地址，(允许所有域名)以上使用正则
  http.cors.allow-origin: /.*/

  ```

* 请求方式错误 `406 Not Acceptable`

  一般在使用elasticsearch 6.x 才会出现，因为`elasticsearch-head` 只适配到了5，而6.X 请求方式变成 `json` 方式请求  
  **修改 elasticsearch-head 源码**
  ```bash
  vim /usr/src/app/_site/vendor.js

  将
  contentType: "application/x-www-form-urlencoded"
  改为
  contentType: "application/json"

  ```
