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
