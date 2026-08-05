select count(*)
  from dept;

select e.empno,
       e.ename,
       e.job,
       d.dname,
       d.loc
  from emp e
  join dept d
on e.deptno = d.deptno;