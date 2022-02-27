# PostgreSQL
PostgreSQL 是一个免费的对象-关系数据库服务器(ORDBMS)，在灵活的BSD许可证下发行。

## 基础操作

```shell
sudo apt-get update
sudo apt-get install postgresql postgresql-client

sudo -i -u postgres
~$ psql -U postgres -h 127.0.0.1 -p 5432
psql (9.5.17)
Type "help" for help.

postgres=#

\q 退出
```

```shell
-- 查看所有数据库
postgres=# \l
                                   List of databases
        Name         |  Owner   | Encoding | Collate |  Ctype  |   Access privileges
---------------------+----------+----------+---------+---------+-----------------------
 mastodon_production | mastodon | UTF8     | C.UTF-8 | C.UTF-8 |
 postgres            | postgres | UTF8     | C.UTF-8 | C.UTF-8 |
 template0           | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                     |          |          |         |         | postgres=CTc/postgres
 template1           | postgres | UTF8     | C.UTF-8 | C.UTF-8 | =c/postgres          +
                     |          |          |         |         | postgres=CTc/postgres
(4 rows)

-- 切换数据库
postgres=# \c mastodon_production
You are now connected to database "mastodon_production" as user "postgres".
mastodon_production=#

-- 列出所有的表
\dt

-- 查看数据表
select * from pg_tables;
select tablename from pg_tables where tableowner='mastodon';
select tablename from pg_tables where schemaname='public';

-- 查看表结构
\d 表名

```
