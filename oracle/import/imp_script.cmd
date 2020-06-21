@echo off
set DATE_STR=%1
set USERNAME=%2
set PASSWORD=%3
set TNSNAME=%4
set NAMESPACE=%5
set SYS_PWD=1
set EXP_DIR=D:\dbbackup\%DATE_STR%

rem 删除用户
echo drop user %USERNAME% cascade; > tmp_rebuild.sql
rem 创建用户
echo create user %USERNAME% identified by %PASSWORD% default tablespace %NAMESPACE% temporary tablespace TEMP profile default; >> tmp_rebuild.sql
rem 赋权
echo grant connect,resource,create view,dba to %USERNAME%; >> tmp_rebuild.sql

echo exit; >> tmp_rebuild.sql

sqlplus sys/%SYS_PWD%@%TNSNAME% as sysdba @.\tmp_rebuild.sql

imp %USERNAME%/%PASSWORD%@%TNSNAME% file=%EXP_DIR%\%USERNAME%_%DATE_STR%.dmp log=%EXP_DIR%\%USERNAME%_%DATE_STR%_imp.log full=y

del tmp_rebuild.sql