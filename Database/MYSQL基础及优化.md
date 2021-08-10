## 基本常用操作
### 创建数据库
```sql
--创建数据库，并设定编码集为utf8
CREATE DATABASE IF NOT EXISTS database_name DEFAULT CHARSET utf8 COLLATE utf8_general_ci;
--但其实MySQL中的UTF-8不是正在的UTF-8应该转为utf8mb4,如果已经设置了建议修改
CREATE DATABASE IF NOT EXISTS database_name DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- For each database:
ALTER DATABASE database_name CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
-- For each table:
ALTER TABLE table_name CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- For each column:
ALTER TABLE table_name CHANGE column_name column_name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- 删除数据库
DROP DATABASE database_name;

--查看当前登录用户
select user();
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


--修改用户密码
mysql> set password for test =password('1122');
mysql> set password for root@localhost = password('123456');
--mysql8删除了password函数,需要刷新
alter user 'root'@'localhost' identified by '123123'
--需要刷新
mysql> update  mysql.user set  password=password('1234')  where user='test'


--授予用户通过任意IP对数据库“testdb”的全部权限
grant all privileges on testdb.* to 'test'@'%' identified by '1234';  
grant create,alter,drop,select,insert,update,delete on testdb.* to test@'%';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456' WITH GRANT OPTION;

--刷新权限
flush privileges;

--查看用户权限
show grants for test;
--查看表状态
show table status \G

```

### 忘记ROOT密码
```bash
vim /etc/my.cnf

[mysqld] 下添加 skip-grant-tables

重启 mysql 服务

MySQL> UPDATE mysql.user SET Password=PASSWORD('新密码') where USER='root';

[mysqld] 下删除 skip-grant-tables

重启 mysql 服务
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

## 关键字
* 数据库查询语言（DQL Data Query Language）：select
* 数据库定义语言（DDL Data Definition Language）：create database、drop database 、create table、drop table、alter
* 数据库操作语言（DML Data Manipulation Language）：update 、insert 、delete


## 索引基础
与CPU类似为了提高性能，CPU寄存器向内存取数据时可能会连带数据的邻居数据一起取出，这是CPU的`缓存行对齐`以64个字节为一个基本单位取数据。（这部分在其他笔记中记载了，可以在整个笔记中搜索`缓存行对齐`查找）。MySQL 数据库也使用类似的方式，减少对磁盘的IO次数以提高性能，MySQL 中使用了 `Page` 页，在InnoDb引擎中页的大小是16KB，插入数据时进行排序形成多个页目录，最终形成索引结构 `B+树` 优化查询效率。  
在联合索引中排序有这么一个原则，从左往右依次比较大小也就是`最左前缀匹配原则`。如联合索引(key1,key2,key3)，相当于创建了（key1）、(key1,key2)和(key1,key2,key3)三个索引，这就是最左匹配原则
### 聚簇索引
所谓聚簇索引，就是将索引和数据放到一起，找到索引也就找到了数据，我们刚才看到的B+树索引就是一种聚簇索引，而非聚簇索引就是将数据和索引分开，查找时需要先查找到索引，然后通过索引回表找到相应的数据。InnoDB有且只有一个聚簇索引，而MyISAM中都是非聚簇索引。
### 覆盖索引
覆盖索引（covering index）指一个查询语句的执行只用从索引中就能够取得，不必从数据表中读取。也可以称之为实现了索引覆盖。 当一条查询语句符合覆盖索引条件时，MySQL只需要通过索引就可以返回查询所需要的数据，这样避免了查到索引后再返回表操作，减少I/O提高效率。 如，表covering_index_sample中有一个普通索引 idx_key1_key2(key1,key2)。当我们通过SQL语句：select key2 from covering_index_sample where key1 = 'keytest';的时候，就可以通过覆盖索引查询，无需回表。

### 索引下推
MySQL5.6引入了索引下推优化，默认开启，使用`SET optimizer_switch = 'index_condition_pushdown=off'`;可以将其关闭。  
官方文档中给的例子和解释如下： `people`表中`（zipcode，lastname，firstname）`构成一个索引
```sql
SELECT * FROM people WHERE zipcode='95054' AND lastname LIKE '%etrunia%' AND address LIKE '%Main Street%'
```
如果没有使用索引下推技术，则MySQL会通过`zipcode='95054'`从存储引擎中查询对应的数据，返回到MySQL服务端，然后MySQL服务端基于`lastname LIKE '%etrunia%'和address LIKE '%Main Street%'`来判断数据是否符合条件。   
如果使用了索引下推技术，则MYSQL首先会返回符合`zipcode='95054'`的索引，然后根据`lastname LIKE '%etrunia%'和address LIKE '%Main Street%'`来判断索引是否符合条件。如果符合条件，则根据该索引来定位对应的数据，如果不符合，则直接reject掉。 有了索引下推优化，**可以在有like条件查询的情况下，减少回表次数**。

`SELECT COUNT(*) FROM table_name` 也不一定会进行全表扫描。针对无 where_clause 的 `COUNT(*)`，MySQL 是有优化的，优化器会选择成本最小的辅助索引查询计数，其实反而性能最高。可以使用`EXPLAIN SELECT COUNT(*) FROM table_name` 验证

### 查询优化器
一条SQL语句的查询，可以有不同的执行方案，至于最终选择哪种方案，需要通过优化器进行选择，选择执行成本最低的方案。 在一条单表查询语句真正执行之前，MySQL的查询优化器会找出执行该语句所有可能使用的方案，对比之后找出成本最低的方案。这个成本最低的方案就是所谓的执行计划。 优化过程大致如下：
1. 根据搜索条件，找出所有可能使用的索引
2. 计算全表扫描的代价
3. 计算使用不同索引执行查询的代价
4. 对比各种执行方案的代价，找出成本最低的那一个

所以并非创建索引就一定会通过索引来查找

### 测试表
```SQL
-- 创建表
CREATE TABLE `person` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `score` int(11) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `name_score` (`name`(191),`score`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
-- 使用存储过程模拟100W条数据
CREATE PROCEDURE insert_person()
begin
    declare c_id integer default 1;
    while c_id<=1000000 do
    insert into person values(c_id, concat('name',c_id), c_id+100, date_sub(NOW(), interval c_id second));
    set c_id=c_id+1;
    end while;
end
-- 执行存储过程
call insert_person()
-- 查询索引使用情况
explain select count(*) from person;
+----+-------------+--------+-------+---------------+-------------+---------+------+---------+-------------+
| id | select_type | table  | type  | possible_keys | key         | key_len | ref  | rows    | Extra       |
+----+-------------+--------+-------+---------------+-------------+---------+------+---------+-------------+
|  1 | SIMPLE      | person | index | NULL          | create_time | 4       | NULL | 3023554 | Using index |
+----+-------------+--------+-------+---------------+-------------+---------+------+---------+-------------+

-- optimizer trace 功能来查看优化器生成计划的整个过程
SET optimizer_trace="enabled=on";
SELECT create_time FROM person WHERE NAME >'name84059' AND create_time > '2020-05-23 14:39:18';
SELECT * FROM information_schema.OPTIMIZER_TRACE;
SET optimizer_trace="enabled=off";
```
![mysql explain](../assets/img/mysql-explain.png)

## 事务隔离级别
* 读未提交（read uncommitted）：一个事务还没有提交时，它做的变更就能被别的事务看到。
* 读提交（read committed）：一个事物提交之后，它做的变更才会被其他事务看到。
* 可重复读（repeatable read）：一个事物执行过程中看到的数据，总是跟这个事务在启动时看到的数据是一致的。未提交变更对其他事务也是不可见的。
* 串行化（serializable）：对于同一行记录，写会加“写锁”，读会加“读锁”，当出现锁冲突时，后访问的事务需要等前一个事务执行完成，才能继续执行。
```sql
--默认REPEATABLE-READ
show variables like 'tx_isolation';
--查看没有提交的事务
select * from information_schema.innodb_trx;
--查找持续时间超过 60s 的事务,一般都超时了，默认 50s
--my.ini innodb_lock_wait_timeout = 50
select * from information_schema.innodb_trx where TIME_TO_SEC(timediff(now(),trx_started))>60;
--查看进程
show full processlist;
```
|事务A|\||事务B|
|----|---|----|
|开启事务 `mysql> start transaction;` | \|| 开启事务 |
|查询得到值：1 `select val from mytable where id=1;` | \|| 查询得到值：1 |
| | \| | 将1改成2 `update mytable set val=2 where id=1` |
|查询得到值：v1| \| | |
| | \| |提交事务B `commit`|
|查询得到值：v2| \| | |
|提交事务A | \| | |
|查询得到值：v3 | v | |

在不同的隔离级别下，事务A查到的结果是不一样的：
* **读未提交**: v1 的值是2，这时候事务 B 虽然还没有提交，但是结果已经被事务 A 看到了，因此 v2、v3 也都是2。
* **读提交**: v1 是1，v2 的值是 2 ，事务 B 的更新在提交后才被事务 A 看到。所以 v3 的值也是 2。
* **可重复读**: v1、v2是 1，v3 是2，之所以 v2 还是1，遵循的就是这个要求：事务在执行期间看到的数据前后必须是一致的。
* **串行化**: 则在事务 B 执行“将 1 改成 2”的时候，会被锁住，直到事务 A 提交后，事务 B 才可以继续执行，所以从事务 A 的角度看，v1、v2的值是1，v3的值是2。

在实现上，数据库里面会创建一个视图，访问的时候以视图的逻辑结果为准。在“可重复读”隔离级别下，这个视图是在事务启动时创建的，整个事务存在期间都用这个视图。在“读提交”隔离级别下，这个视图是在每个SQL语句开始执行的时候创建的。这里需要注意的是，“读未提交”隔离界别下直接返回记录上的最新值，没有视图概念；而“串行化”隔离级别下直接用加锁的方式来避免并行访问。

* **脏读** : 当前事务可以查看到别的事务未提交的数据（侧重点在于别的事务未提交）。
* **不可重读** : 不可重读的侧重点在于更新修改数据。表示在同一事务中，查询相同的数据范围时，同一个数据资源莫名的改变了。
* **幻读** : 幻读的侧重点在于新增和删除。表示在同一事务中，使用相同的查询语句，第二次查询时，莫名的多出了一些之前不存在数据，或者莫名的不见了一些数据。

事务的隔离级别越高，隔离性越强，所拥有的问题越少，并发能力越弱，所以，我们可以用如下表格进行总结

|隔离级别\问题|脏读 (Dirty)| 不可重读 (NonRepeatable Read) | 幻读 （Phantom Read）|
|-----|-----|------|----|
|读未提交|o|o|o|
|读提交|x|o|o|
|可重复读|x|x|o|
|串行化|x|x|x|

## Binlog
MySQL二进制日志,用于记录用户对数据库操作的SQL语句（(除了数据查询语句）信息。可以使用mysqlbin命令查看二进制日志的内容。

### 模式分类
* STATMENT  
  基于SQL语句的复制(statement-based replication, SBR)，每一条会修改数据的sql语句会记录到binlog中。
  * 优点：不需要记录每一条SQL语句与每行的数据变化，这样子binlog的日志也会比较少，减少了磁盘IO，提高性能。
  * 缺点：在某些情况下会导致master-slave中的数据不一致(如sleep()函数， last_insert_id()，以及user-defined functions(udf)等会出现问题)

* ROW  
  基于行的复制(row-based replication, RBR)：不记录每一条SQL语句的上下文信息，仅需记录哪条数据被修改了，修改成了什么样子了。
  * 优点：不会出现某些特定情况下的存储过程、或function、或trigger的调用和触发无法被正确复制的问题。
  * 缺点：会产生大量的日志，尤其是alter table的时候会让日志暴涨。

* MIXED  
  混合模式复制(mixed-based replication, MBR)：以上两种模式的混合使用，一般的复制使用STATEMENT模式保存binlog，对于STATEMENT模式无法复制的操作使用ROW模式保存binlog，MySQL会根据执行的SQL语句选择日志保存方式。

### 配置
```cnf
[mysqld]

#设置日志格式
binlog_format = mixed

#设置日志路径，注意路经需要mysql用户有权限写
log-bin = /data/mysql/logs/mysql-bin.log

#设置binlog清理时间
expire_logs_days = 7

#binlog每个日志文件大小
max_binlog_size = 100m

#binlog缓存大小
binlog_cache_size = 4m

#最大binlog缓存大小
max_binlog_cache_size = 512m
```

### 命令
* `show variables like 'log_%'` 查看binlog日志是否开启
* `show master logs` 查看所有binlog日志列表
* `mysqlbinlog mysql-bin.0000001` 查看具体日志

## SQL基础优化

### LIMIT 1000000,10
```SQL
SELECT *
FROM   operation
WHERE  type = 'SQLStats'
       AND name = 'SlowLog'
ORDER  BY create_time
LIMIT  1000, 10;
```
一般情况在type, name, create_time字段上加组合索引，这样条件排序都能有效的利用到索引，性能迅速提升。  
但当 LIMIT 子句变成 “LIMIT 1000000,10”，会发现我只取10条记录为什么还是慢，知道数据库也并不知道第1000000条记录从什么地方开始，即使有索引也需要从头计算一次。   
解决：在前端数据浏览翻页，或者大数据分批导出等场景下，是可以将上一页的最大值当成参数作为查询条件的。SQL重新设计如下,查询时间基本固定，不会随着数据量的增长而发生变化。
```SQL
SELECT   *
FROM     operation
WHERE    type = 'SQLStats'
AND      name = 'SlowLog'
AND      create_time > '2017-03-16 14:00:00'
ORDER BY create_time limit 10;
```

### 隐式转换
```SQL
mysql> explain extended SELECT *
     > FROM   my_balance b
     > WHERE  b.bpn = 14000000123
     >       AND b.isverified IS NULL ;
mysql> show warnings;
| Warning | 1739 | Cannot use ref access on index 'bpn' due to type or collation conversion on field 'bpn'
```
字段bpn的定义为varchar(20)，MySQL的策略是将字符串转换为数字之后再比较。**函数作用于表字段，索引失效**。

### EXISTS语句
MySQL对待EXISTS子句时，仍然采用嵌套子查询的执行方式。如下面的SQL语句：
```SQL
SELECT *
FROM   my_neighbor n
       LEFT JOIN my_neighbor_apply sra
              ON n.id = sra.neighbor_id
                 AND sra.user_id = 'xxx'
WHERE  n.topic_status < 4
       AND EXISTS(SELECT 1
                  FROM   message_info m
                  WHERE  n.id = m.neighbor_id
                         AND m.inuser = 'xxx')
       AND n.topic_type <> 5
```
```
+----+--------------------+-------+------+-----+------------------------------------------+---------+-------+---------+ -----+
| id | select_type        | table | type | possible_keys     | key   | key_len | ref   | rows    | Extra   |
+----+--------------------+-------+------+ -----+------------------------------------------+---------+-------+---------+ -----+
|  1 | PRIMARY            | n     | ALL  |  | NULL     | NULL    | NULL  | 1086041 | Using where                   |
|  1 | PRIMARY            | sra   | ref  |  | idx_user_id | 123     | const |       1 | Using where          |
|  2 | DEPENDENT SUBQUERY | m     | ref  |  | idx_message_info   | 122     | const |       1 | Using index condition; Using where |
+----+--------------------+-------+------+ -----+------------------------------------------+---------+-------+---------+ -----+
```
去掉exists更改为join，能够避免嵌套子查询，将执行时间从1.93秒降低为1毫秒。
```SQL
SELECT *
FROM   my_neighbor n
       INNER JOIN message_info m
               ON n.id = m.neighbor_id
                  AND m.inuser = 'xxx'
       LEFT JOIN my_neighbor_apply sra
              ON n.id = sra.neighbor_id
                 AND sra.user_id = 'xxx'
WHERE  n.topic_status < 4
       AND n.topic_type <> 5
```
```
+----+-------------+-------+--------+ -----+------------------------------------------+---------+ -----+------+ -----+
| id | select_type | table | type   | possible_keys     | key       | key_len | ref   | rows | Extra                 |
+----+-------------+-------+--------+ -----+------------------------------------------+---------+ -----+------+ -----+
|  1 | SIMPLE      | m     | ref    | | idx_message_info   | 122     | const    |    1 | Using index condition |
|  1 | SIMPLE      | n     | eq_ref | | PRIMARY   | 122     | ighbor_id |    1 | Using where      |
|  1 | SIMPLE      | sra   | ref    | | idx_user_id | 123     | const     |    1 | Using where           |
+----+-------------+-------+--------+ -----+------------------------------------------+---------+ -----+------+ -----+
```

出自：https://developer.aliyun.com/article/72501

### SELECT 执行顺序
```sql
FROM
<表名> # 选取表，将多个表数据通过笛卡尔积变成一个表。
ON
<筛选条件> # 对笛卡尔积的虚表进行筛选
JOIN <join, left join, right join...>
<join表> # 指定join，用于添加数据到on之后的虚表中，例如left join会将左表的剩余数据添加到虚表中
WHERE
<where条件> # 对上述虚表进行筛选
GROUP BY
<分组条件> # 分组
<SUM()等聚合函数> # 用于having子句进行判断，在书写上这类聚合函数是写在having判断里面的
HAVING
<分组筛选> # 对分组后的结果进行聚合筛选
SELECT
<返回数据列表> # 返回的单列必须在group by子句中，聚合函数除外
DISTINCT
# 数据除重
ORDER BY
<排序条件> # 排序
LIMIT
<行数限制>
```

* 比较运算符能用 “=”就不用“<>”
> “=”增加了索引的使用几率

* 明知只有一条查询结果，使用 “LIMIT 1”
> “LIMIT 1”可以避免全表扫描，找到对应结果就不会再继续扫描

*  为列选择合适的数据类型
> 能用TINYINT就不用SMALLINT，能用SMALLINT就不用INT，磁盘和内存消耗越小越好

* 最好都加默认值

  ```SQL
  --尽量避免进行 null 值的判断，会导致数据库引擎放弃索引进行全表扫描
  SELECT * FROM t WHERE score IS NULL
  --有默认值就能解决这问题
  SELECT * FROM t WHERE score = 0
  ```

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

* 尽量避免使用 `SELECT *`
> 如果不查询表中所有的列，尽量避免使用 `SELECT *`，因为它会进行全表扫描，不能有效利用索引，增大了数据库服务器的负担，以及它与应用程序客户端之间的网络IO开销。

* 尽量避免在字段开头模糊查询

  * ❌`WHERE username LIKE '%陈%'`
  * ✅`WHERE username LIKE '陈%'`
  * 考虑使用 FullText 全文索引，用 match against 检索
  * 考虑使用函数 `INSTR`
  * 考虑使用 ElasticSearch、Solr

* 尽量避免 `in`

  ```SQL
  -- 不走索引
  select * from A where A.id in (select id from B);
  -- 走索引
  select * from A where exists (select * from B where B.id = A.id);
  ```

* WHERE , JOIN , ORDER BY 子句里面的列尽量被索引
  > 只是“尽量”，并不是说所有的列。根据实际情况进行调整，因为有时索引太多也会降低性能。

  > order by 条件要与 where 中条件一致，否则 order by 不会利用索引进行排序

* 使用 LIMIT 实现分页逻辑
> 不仅提高了性能，同时减少了不必要的数据库和应用间的网络传输

  如果条件允许，可以使用 `Cursor Pagination` 优化 `limit` 效率
  ```sql
  mysql> select * from tablename limit 20 offset 800001
  10 rows in set (12.80 sec)
  mysql> select * from tablename where id>800000 limit 20
  10 rows in set (0.01 sec)
  ```

* 使用 EXPLAIN 关键字去查看执行计划
> EXPLAIN 可以检查索引使用情况以及扫描的行。
