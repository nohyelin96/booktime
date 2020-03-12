--drop tablespace tbs_booktime;
create tablespace tbs_booktime
datafile 'D:\finalProject\booktime.dbf' size 1000M
autoextend on next 100M;

--drop user booktime
create user booktime 
identified by booktime123
default tablespace tbs_booktime;

--권한부여
grant connect, resource to booktime;

--락해제
alter user booktime account unlock;

