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
### 查询优化器
一条SQL语句的查询，可以有不同的执行方案，至于最终选择哪种方案，需要通过优化器进行选择，选择执行成本最低的方案。 在一条单表查询语句真正执行之前，MySQL的查询优化器会找出执行该语句所有可能使用的方案，对比之后找出成本最低的方案。这个成本最低的方案就是所谓的执行计划。 优化过程大致如下：
1. 根据搜索条件，找出所有可能使用的索引
2. 计算全表扫描的代价
3. 计算使用不同索引执行查询的代价
4. 对比各种执行方案的代价，找出成本最低的那一个

所以并非创建索引就一定会通过索引来查找

## 事务隔离级别
* 读未提交（read uncommitted）：一个事务还没有提交时，它做的变更就能被别的事务看到。
* 读提交（read committed）：一个事物提交之后，它做的变更才会被其他事务看到。
* 可重复读（repeatable read）：一个事物执行过程中看到的数据，总是跟这个事务在启动时看到的数据是一致的。未提交变更对其他事务也是不可见的。
* 串行化（serializable）：对于同一行记录，写会加“写锁”，读会加“读锁”，当出现锁冲突时，后访问的事务需要等前一个事务执行完成，才能继续执行。
```sql
show variables like 'tx_isolation';--默认REPEATABLE-READ
select * from information_schema.innodb_trx where TIME_TO_SEC(timediff(now(),trx_started))>60;--查找持续时间超过 60s 的事务
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
