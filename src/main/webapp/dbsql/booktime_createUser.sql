--drop tablespace tbs_booktime;
create tablespace tbs_booktime
datafile 'D:\finalProject\booktime.dbf' size 1000M
autoextend on next 100M;

--drop user booktime
create user booktime 
identified by booktime123
default tablespace tbs_booktime;

--���Ѻο�
grant connect, resource to booktime;

--������
alter user booktime account unlock;

