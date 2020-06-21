@echo off
set DATE_STR=%date:~0,4%%date:~5,2%%date:~8,2%
set USERNAME=%1
set PASSWORD=%2
set TNSNAME=%3
set EXP_DIR=D:\dbbackup\%DATE_STR%
set 7Z_HOME=C:\"Program Files"\7-Zip

if not exist %EXP_DIR% ( mkdir %EXP_DIR% )

exp %USERNAME%/%PASSWORD%@%TNSNAME% file=%EXP_DIR%\%USERNAME%_%DATE_STR%.dmp log=%EXP_DIR%\%USERNAME%_%DATE_STR%_exp.log owner=%USERNAME%

%7Z_HOME%\7z a %EXP_DIR%\%USERNAME%_%DATE_STR%.zip %EXP_DIR%\%USERNAME%_%DATE_STR%.dmp %EXP_DIR%\%USERNAME%_%DATE_STR%_exp.log

rem del %EXP_DIR%\%USERNAME%_%DATE_STR%.dmp
rem del %EXP_DIR%\%USERNAME%_%DATE_STR%_exp.log