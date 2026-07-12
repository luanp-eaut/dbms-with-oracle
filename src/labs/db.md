## Cơ sở dữ liệu thực hành

Cơ sở dữ liệu EMP/DEPT chuẩn Oracle sẽ được sử dụng cho các bài tập thực hành chương 2 và chương 3, gồm 2 bảng:

### Bảng DEPT (Phòng ban)

| Cột    | Kiểu dữ liệu | Ràng buộc   | Mô tả     |
| ------ | ------------ | ----------- | --------- |
| DEPTNO | NUMBER(2)    | PRIMARY KEY | Mã phòng  |
| DNAME  | VARCHAR2(14) |             | Tên phòng |
| LOC    | VARCHAR2(13) |             | Địa điểm  |

### Bảng EMP (Nhân viên)

| Cột      | Kiểu dữ liệu | Ràng buộc   | Mô tả            |
| -------- | ------------ | ----------- | ---------------- |
| EMPNO    | NUMBER(4)    | PRIMARY KEY | Mã nhân viên     |
| ENAME    | VARCHAR2(10) |             | Tên nhân viên    |
| JOB      | VARCHAR2(9)  |             | Chức vụ          |
| MGR      | NUMBER(4)    |             | Mã người quản lý |
| HIREDATE | DATE         |             | Ngày vào làm     |
| SAL      | NUMBER(7,2)  |             | Lương            |
| COMM     | NUMBER(7,2)  |             | Hoa hồng         |
| DEPTNO   | NUMBER(2)    | FOREIGN KEY | Mã phòng (FK)    |

### Code khởi tạo

```sql
-- ====================================================
-- 1. Xóa bảng (nếu đã tồn tại) để chạy lại từ đầu
-- ====================================================
drop table emp cascade constraints;
drop table dept cascade constraints;

-- ====================================================
-- 2. Tạo bảng DEPT (Phòng ban)
-- ====================================================
create table dept (
   deptno number(2) primary key,  -- Mã phòng
   dname  varchar2(14),           -- Tên phòng
   loc    varchar2(13)            -- Địa điểm
);

-- ====================================================
-- 3. Tạo bảng EMP (Nhân viên)
-- ====================================================
create table emp (
   empno    number(4) primary key, -- Mã nhân viên
   ename    varchar2(10),          -- Tên nhân viên
   job      varchar2(9),           -- Chức vụ
   mgr      number(4),             -- Mã người quản lý (FK tham chiếu chính bảng EMP)
   hiredate date,                  -- Ngày vào làm
   sal      number(7,2),           -- Lương
   comm     number(7,2),           -- Hoa hồng
   deptno   number(2),             -- Mã phòng (FK tham chiếu bảng DEPT)

    -- Ràng buộc khóa ngoại: MGR tham chiếu EMPNO của chính bảng EMP
   constraint fk_emp_mgr foreign key ( mgr )
      references emp ( empno ),

    -- Ràng buộc khóa ngoại: DEPTNO tham chiếu DEPTNO của bảng DEPT
   constraint fk_emp_deptno foreign key ( deptno )
      references dept ( deptno )
);

-- ====================================================
-- 4. Chèn dữ liệu mẫu (Bộ dữ liệu của Oracle)
-- ====================================================

-- Chèn dữ liệu vào bảng DEPT
insert into dept (
   deptno,
   dname,
   loc
) values ( 10,
           'ACCOUNTING',
           'NEW YORK' );
insert into dept (
   deptno,
   dname,
   loc
) values ( 20,
           'RESEARCH',
           'DALLAS' );
insert into dept (
   deptno,
   dname,
   loc
) values ( 30,
           'SALES',
           'CHICAGO' );
insert into dept (
   deptno,
   dname,
   loc
) values ( 40,
           'OPERATIONS',
           'BOSTON' );

-- Chèn dữ liệu vào bảng EMP
insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7839,
           'KING',
           'PRESIDENT',
           null,
           to_date('1981-11-17','YYYY-MM-DD'),
           5000,
           null,
           10 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7698,
           'BLAKE',
           'MANAGER',
           7839,
           to_date('1981-05-01','YYYY-MM-DD'),
           2850,
           null,
           30 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7782,
           'CLARK',
           'MANAGER',
           7839,
           to_date('1981-06-09','YYYY-MM-DD'),
           2450,
           null,
           10 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7566,
           'JONES',
           'MANAGER',
           7839,
           to_date('1981-04-02','YYYY-MM-DD'),
           2975,
           null,
           20 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7788,
           'SCOTT',
           'ANALYST',
           7566,
           to_date('1987-04-19','YYYY-MM-DD'),
           3000,
           null,
           20 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7902,
           'FORD',
           'ANALYST',
           7566,
           to_date('1981-12-03','YYYY-MM-DD'),
           3000,
           null,
           20 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7369,
           'SMITH',
           'CLERK',
           7902,
           to_date('1980-12-17','YYYY-MM-DD'),
           800,
           null,
           20 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7499,
           'ALLEN',
           'SALESMAN',
           7698,
           to_date('1981-02-20','YYYY-MM-DD'),
           1600,
           300,
           30 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7521,
           'WARD',
           'SALESMAN',
           7698,
           to_date('1981-02-22','YYYY-MM-DD'),
           1250,
           500,
           30 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7654,
           'MARTIN',
           'SALESMAN',
           7698,
           to_date('1981-09-28','YYYY-MM-DD'),
           1250,
           1400,
           30 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7844,
           'TURNER',
           'SALESMAN',
           7698,
           to_date('1981-09-08','YYYY-MM-DD'),
           1500,
           0,
           30 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7876,
           'ADAMS',
           'CLERK',
           7788,
           to_date('1987-05-23','YYYY-MM-DD'),
           1100,
           null,
           20 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7900,
           'JAMES',
           'CLERK',
           7698,
           to_date('1981-12-03','YYYY-MM-DD'),
           950,
           null,
           30 );

insert into emp (
   empno,
   ename,
   job,
   mgr,
   hiredate,
   sal,
   comm,
   deptno
) values ( 7934,
           'MILLER',
           'CLERK',
           7782,
           to_date('1982-01-23','YYYY-MM-DD'),
           1300,
           null,
           10 );

commit;

-- ====================================================
-- 6. Kiểm tra kết quả (tuỳ chọn)
-- ====================================================
-- SELECT * FROM DEPT;
-- SELECT * FROM EMP;
```
