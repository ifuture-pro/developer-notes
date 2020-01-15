## 基本常用操作
### 创建数据库
```sql
--创建数据库，并设定编码集为utf8
CREATE DATABASE IF NOT EXISTS database_name DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
--但其实MySQL中的UTF-8不是正在的UTF-8应该转为utf8mb4,如果已经设置了建议修改
-- For each database:
ALTER DATABASE database_name CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- For each table:
ALTER TABLE table_name CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- For each column:
ALTER TABLE table_name CHANGE column_name column_name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```
/etc/mysql/my.cnf
```
[client]
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
```

```
mysql> SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';
+--------------------------+--------------------+
| Variable_name            | Value              |
+--------------------------+--------------------+
| character_set_client     | utf8mb4            |
| character_set_connection | utf8mb4            |
| character_set_database   | utf8mb4            |
| character_set_filesystem | binary             |
| character_set_results    | utf8mb4            |
| character_set_server     | utf8mb4            |
| character_set_system     | utf8               |
| collation_connection     | utf8mb4_unicode_ci |
| collation_database       | utf8mb4_unicode_ci |
| collation_server         | utf8mb4_unicode_ci |
+--------------------------+--------------------+
10 rows in set (0.00 sec)
```

### 创建用户并授权
```sql
--创建了一个名为：test 密码为：1234 的用户
 create user 'test'@'localhost' identified by '1234';


--删除用户“test”
drop user 'test'@'localhost' ;
--若创建的用户允许任何电脑登陆，删除用户如下
drop user 'test'@'%';


修改用户密码
mysql> set password for test =password('1122');
mysql> set password for root@localhost = password('123456');
需要刷新
mysql> update  mysql.user set  password=password('1234')  where user='test'


--授予用户通过任意IP对数据库“testdb”的全部权限
grant all privileges on testdb.* to 'test'@'%' identified by '1234';  
grant create,alter,drop,select,insert,update,delete on testdb.* to test@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;

--刷新权限
flush privileges;

查看用户权限
show grants for test;
```

### 导入导出数据
```bash
#导出
mysqldump -udbuser -p 数据库名 > dbname.sql
mysqldump -udbuser -p 数据库名 表名> dbname_tables.sql
mysqldump -udbuser -p -d --add-drop-table dbname >d:/dbname_db.sql
#-d 没有数据 --add-drop-table 在每个create语句之前增加一个drop table

#导入
login mysql then:
source /home/ubuntu/dbname.sql
```

## SQL基础优化

* 比较运算符能用 “=”就不用“<>”
> “=”增加了索引的使用几率

* 明知只有一条查询结果，使用 “LIMIT 1”
> “LIMIT 1”可以避免全表扫描，找到对应结果就不会再继续扫描

*  为列选择合适的数据类型
> 能用TINYINT就不用SMALLINT，能用SMALLINT就不用INT，磁盘和内存消耗越小越好

* 将大的DELETE，UPDATE or INSERT 查询变成多个小查询
> 能写一个几十行、几百行的SQL语句是不是显得逼格很高？然而，为了达到更好的性能以及更好的数据控制，你可以将他们变成多个小查询。

* 使用UNION ALL 代替 UNION
> 前提是结果集允许重复。因为 UNION ALL 不去重，效率高于 UNION。

* 为获得相同结果集的多次执行，请保持SQL语句前后一致
> 这样做的目的是为了充分利用查询缓冲。
  比如根据地域和产品id查询产品价格，第一次使用了：
  ```sql
select price from orders where id='123' and regin='beijing';
```
> 那么第二次同样的查询，请保持以上语句的一致性，比如不要将where语句里面的id和region位置调换顺序。

* 尽量避免使用 “SELECT *”
> 如果不查询表中所有的列，尽量避免使用 SELECT *，因为它会进行全表扫描，不能有效利用索引，增大了数据库服务器的负担，以及它与应用程序客户端之间的网络IO开销。

* WHERE , JOIN , ORDER BY 子句里面的列尽量被索引
> 只是“尽量”，并不是说所有的列。根据实际情况进行调整，因为有时索引太多也会降低性能。

* 使用 LIMIT 实现分页逻辑
> 不仅提高了性能，同时减少了不必要的数据库和应用间的网络传输

* 使用 EXPLAIN 关键字去查看执行计划
> EXPLAIN 可以检查索引使用情况以及扫描的行。
