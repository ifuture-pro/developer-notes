## Elasticsearch
### 安装
* Docker
```bash
docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 --restart=always elasticsearch:6.8.5
```

## elasticsearch-head
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
