   set transaction read only;
insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values
   ( 80011,
     'LE VAN A',
     'MANAGER',
     7839,
     sysdate,
     5000,
     null,
     60 );