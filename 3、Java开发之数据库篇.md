# 一、Mysql

## 1、常用基础命令

​		

## 2、相关知识点

### 1、导致索引失效的情况

```sql
# 模型数空运最快

-- 模————模糊查询 like 如果以 % 开头，索引会失效。

-- 型————如果数据类型错误了，索引会失效。

-- 数————对索引字段使用内部函数，索引会失效，应该建立基于函数的索引。

-- 空————null，索引不存储控制，如果不限制索引列是not null，数据库会认为索引列可能存在空值，也不会按照索引进行计算。

-- 运————对索引列进行加减乘除等运算会导致索引失效。

-- 最————最左原则的意思，在复合索引中，索引列的顺序非常重要，如果不是按照索引列最左列开始进行查找，则无法使用索引。

-- 快————全表扫描更快的意思，如果数据库预计使用全表扫描比使用索引更快，那就不会使用索引。

```

## 3、利用mysqldump导出表结构或者表数据

```markdown
# 说明————加-d参数代表只导表结构，不加此参数则代表导出结构以及表数据，> 代表录入某一文件，若为>>则表示将内容追加到某文件末尾
-- 导出数据库为dbname的表结构
mysqldump -uuser -pdbpasswd -d dbname >db.sql; 
 
-- 导出数据库为dbname某张表结构
mysqldump -uuser -pdbpasswd -d dbname table_name>db.sql;
 
-- 导出数据库为dbname所有表结构及表数据
mysqldump -uuser -pdbpasswd  dbname >db.sql;
 
-- 导出数据库为dbname某张表结构及表数据
mysqldump -uuser -pdbpasswd dbname table_name>db.sql;
 
-- 批量导出dbname数据库中多张表结构及表数据
mysqldump -uuser -pdbpasswd dbname table_name1 table_name2 table_name3>db.sql;
 
-- 批量导出dbname数据库中多张表结构
mysqldump -uuser -pdbpasswd -d dbname table_name1 table_name2 table_name3>db.sql;
```



# 二、Oracle

## 1、常用基础命令

### 	1、用户

```sql
# 创建用户
CREATE USER [用户名：username] IDENTIFIED BY [密码：1] DEFAULT TABLESPACE [默认表空间：grp] TEMPORARY TABLESPACE [临时表空间：temp];
# 赋予用户权限
-- 授权用户连接权限
GRANT CONNECT TO [用户名：username];  
GRANT RESOURCE TO [用户名：username];  
GRANT DBA TO [用户名：username];
-- 授权用户查询所有表的权限
GRANT SELECT ANY TABLE TO [用户名：username];
-- 授权用户创建视图权限
GRANT CREATE VIEW TO [用户名：username];
# 修改用户密码
ALTER USER [用户名：username] IDENTIFIED BY [新密码：1];
# 删除用户及其下数据
DROP USER [用户名：username] CASCADE;
# 查询用户SID和SERIAL
SELECT sid,serial FROM v$session WHERE USERNAME=[用户名：'username'];
# 解锁用户
ALTER USER [被锁用户名：username] IDENTIFIED BY [被锁用户密码] ACCOUNT UNLOCK;
# 当前的session连接数
select count(*) from v$session;
# 当前的数据库连接数
select count(*) from v$process ;
# 数据库允许的最大连接数
select value from v$parameter where name ='processes';
# 修改processes和sessions值
alter system set processes=1000 scope=spfile;
alter system set sessions=1105 scope=spfile;
# 重启数据库
shutdown immediate;
startup;
```



### 	2、表空间

```sql
# 创建表空间
CREATE TABLESPACE [表空间名：grp] DATAFILE [表控件存储全路径：'F:\Oracle\data\grp.dbf'] SIZE 30M AUTOEXTEND ON;
# 修改表空间名称
ALTER TABLESPACE [表空间名：grp] RENAME TO [新的表空间名：newGrp];
# 查询数据库所有表空间
SELECT * FROM DBA_TABLESPACES;
# 删除表空间
DROP TABLESPACE [表空间名：grp] INCLUDING CONTENTS AND DATAFILES;
# 查看表所属表空间
SELECT TABLESPACE_NAME,TABLE_NAME FROM USER_TABLES WHERE TABLE_NAME=[表名：'tb_name'];
# 查看用户所属的默认表空间
SELECT USERNAME,DEFAULT_TABLESPACE FROM DBA_USERS WHERE USERNAME=[用户名：’username‘];
# 查看表空间所有文件
SELECT * FROM DBA_FILES WHERE TABLESPACE_NAME=[表空间名：'grp'];
# 查看表空间使用情况
SELECT TBS 表空间名,       
SUM(TOTALM) 总共大小M,       
SUM(USEDM) 已使用空间M,       
SUM(REMAINEDM) 剩余空间M,       
SUM(USEDM) / SUM(TOTALM) * 100 已使用百分比,       
SUM(REMAINEDM) / SUM(TOTALM) * 100 剩余百分比  
FROM (SELECT B.FILE_ID ID,                                                         
      B.TABLESPACE_NAME TBS,               
      B.FILE_NAME NAME,               
      B.BYTES / 1024 / 1024 TOTALM,               
      (B.bytes - SUM(NVL(A.BYTES, 0))) / 1024 / 1024 USEDM,               
      SUM(NVL(A.BYTES, 0) / 1024 / 1024) REMAINEDM,               
      SUM(NVL(A.BYTES, 0) / (B.BYTES) * 100),               
      (100 - (SUM(NVL(A.BYTES, 0)) / (B.BYTES) * 100))          
      FROM DBA_FREE_SPACE A, DBA_DATA_FILES B         
      WHERE A.FILE_ID = B.FILE_ID         
      GROUP BY B.TABLESPACE_NAME, B.FILE_NAME, B.FILE_ID, B.BYTES         
      ORDER BY B.TABLESPACE_NAME) 
GROUP BY TBS
# 表空间不足解决办法
-- 扩展表空间，注：50m是表空间大小，可以根据实际需要加大，但最大不得超过32G
ALTER DATABASE DATAFILE [表空间文件：'D:\ORACLE\PRODUCT\ORADATA\TEST\USERS01.DBF'] RESIZE 50m;
-- 设置表空间自动增长
ALTER DATABASE DATAFILE [表空间文件：'D:\ORACLE\PRODUCT\ORADATA\TEST\USERS01.DBF'] AUTOEXTEND ON NEXT 50m MAXSIZE 500m; 
-- 当表空间中的数据文件已经足够大（达到32G），此时仅增加表空间大小是不行的，需要增加该表空间的数据文件，此时该表空间的大小最大就变为64G了
ALTER TABLESPACE [表控件名：grp] ADD DATAFILE [新加的表控件数据文件：'D:\oracle\product\10.2.0\oradata\GRP2.ora']  SZIE 800M AUTOEXTEND ON NEXT 50m MAXSIZE 500m; 
```



### 	3、数据表

```sql
# 创建表（可指定表空间）
CREATE TABLE [表名：table_name]([字段名：id] [字段类型：number]，...) --TABLESPACE [表空间名：grp];
# 创建带有主键约束的表（可指定表空间）
CREATE TABLE [表名：table_name]([字段名：id] [字段类型：number]，...,PRIMARY KEY([主键字段名])) --TABLESPACE [表空间名：grp];
# 删除表约束
ALTER TABLE [表名：table_name] DROP CONSTRAINT [约束名];
# 删除主键约束（如果出错使用第二句）
ALTER TABLE [表名：table_name] DROP PRIMARY KEY;
ALTER TABLE [表名：table_name] DROP PRIMARY KEY CASCADE;
# 删除主键被引用的表
DROP TABLE [表名：table_name] CASCADE CONSTRAINT;
# 删除表主键的同时也删除索引
ALTER TABLE [表名：table_name] DROP CONSTRAINT [约束名] CASCADE DROP INDEX;
# 查看表结构(命令窗口)
DESC [表名：table_name];
# 增加列
ALTER TABLE [表名：table_name] ADD([新增列名 类型(长度)]);
# 修改字段长度
ALTER TABLE [表名：table_name] MODIFY([列名 类型(长度)],...);
# 修改字段类型
ALTER TABLE [表名：table_name] MODIFY ([列名 数据类型]);
# 重命名列
ALTER TABLE [表名：table_name] RENAME COLUMN [列名] TO [新列名];
# 删除列
ALTER TABLE [表名：table_name] DROP COLUMN [列名];
# 重命名表
ALTER TABLE [表名：table_name] RENAME TO [新表名];
# 根据表名模糊查询表
SELECT * FROM USER_TABLES WHERE TABLE_NAME LIKE ['%模糊表名%'];
# 添加列名注释
COMMENT ON COLUMN [表名.列名] is ['列注释信息'];
# 根据表名查询表的注释
SELECT 'ODS_BUSI_'||A.TABLE_NAME,A.COMMENTS FROM USER_TAB_COMMENTS A WHERE A.TABLE_NAME LIKE ['模糊表名%'];
# 根据表名查询表列注释
SELECT * FROM USER_COL_COMMENTS A WHERE A.TABLE_NAME LIKE ['模糊表名%'];
# 获取空数据记录的表
select * from user_tables  where nvl(num_rows,0) = 0;
```



### 	4、视图

```sql
# 创建视图（可给访问权限）
CREATE OR REPLACE VIEW [视图名] AS [创建视图的SQL] --WITH READ ONLY;
# 删除视图
DROP VIEW [视图名];
# 创建物化视图
-- 该物化视图在每天00:00:00进行刷新
CREATE MATERIALIZED VIEW [物化视图名] REFRESH FORCE ON DEMAND START WITH SYSDATE NEXT TO_DATE(CONCAT(TO_CHAR(SYSDATE+1,'dd-mm-yyyy'),'00:00:00'),'dd-mm-yyyy hh24:mi:ss') AS [创建物化视图的SQL];
```



### 	5、数据处理

```sql
# 数据导入
-- 原始文件导入
imp [创建好的用户名]/[密码]@orcl full=y file=[数据库文件全路径：F:\Oracle\admin\orcl\dpdump\CSCZ.DMP] ignore=y
-- 版本不对应时
impdp [已存在的其他用户名]/[密码]@orcl directory=DATA_PUMP_DIR dumpfile=[数据库文件：blog.dmp] logfile=[导入数据库文件日志：blog.log] schemas=[已新建的用户名：blog]
-- 不用先创建用户
impdp [已存在用户名]/[密码]@orcl dumpfile=[数据库文件：blog.dmp] logfile=[导入数据库文件日志：blog.log] remap_schema=(原始账户名):（执行过程中创建的账户名） transform=oid:n EXCLUDE=STATISTICS

# 数据导出
-- 原始文件导出
exp username/password@SID file=F:\xx.dmp statistics=none (owner=username)/(tables=(xxxx))--(query=\"where rownum<10\")
-- 版本不对应时
expdp blog/123456@orcl directory=DATA_PUMP_DIR dumpfile=blog.dmp logfile=blog.log + schemas=blog或者remap_schema=eamprd(用户?):eamprduat(密码?)                                             
```



### 	6、DBLink

```sql
# 创建DBLink
CREATE  DATABASE LINK [DBLink名]  CONNECT TO [链接的用户名：ZHB20180521] IDENTIFIED BY ['密码：1'] USING '(DESCRIPTION = (ADDRESS_LIST =(ADDRESS =(PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521)))(CONNECT_DATA =(SERVICE_NAME = orcl)))';
# 删除DBLink
DROP DATABASE LINK [DBLink名];
```



### 	7、触发器

```sql
#	启用/停用触发器
ALTER TRIGGER [触发器名] DISABLE/ENABLE;
#	启用/停用指定表中所有触发器
ALTER TABLE [表名：table_name] DISABLE/ENABLE ALL TRIGGERS;
```



### 	8、其他

```sql
#	断开会话
ALTER SYSTEM KILL SESSION ['sid,serial'];


# 查看是否有被锁的表
SELECT b.owner, b.object_name, a.session_id, a.locked_mode
	FROM v$locked_object a, dba_objects b
  WHERE b.object_id = a.object_id

# 查看是哪个进程锁的
select b.username,b.sid,b.serial#,logon_time
	from v$locked_object a,v$session b
	where a.session_id = b.sid order by b.logon_time

# 杀掉进程 sid,serial#
	alter system kill session '284,38112';
```





