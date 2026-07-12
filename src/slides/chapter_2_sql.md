---
marp: true
theme: eaut
paginate: true
---

<!-- _class: cover -->

<div class="middle">

# Hệ quản trị CSDL Oracle

## Chương 2. SQL trong Oracle

</div>

### Giảng viên: Nguyễn Phồn Lữa

---

<!-- _class: toc -->

# Nội dung

- Tổng quan về SQL trong Oracle
- Data Definition Language (DDL)
- Data Manipulation Language (DML)
- Data Control Language (DCL)
- Transaction Control Language (TCL)
- Thực hành

---

<!-- _class: section -->

# Tổng quan về SQL trong Oracle

---

# Tổng quan về SQL (1)

- **SQL (Structured Query Language)**: Ngôn ngữ chuẩn để giao tiếp với Hệ quản trị CSDL quan hệ (RDBMS).
- **Phiên bản chuẩn**: ISO/ANSI định nghĩa qua các chuẩn SQL-92, SQL:1999, SQL:2003, SQL:2016...
- **Đặc trưng**:
  - Là ngôn ngữ **khai báo (Declarative)**: Người dùng chỉ cần mô tả "cần lấy/cập nhật gì", hệ quản trị tự tối ưu cách thực thi.
  - Thực thi từng lệnh riêng lẻ, không yêu cầu cấu trúc điều khiển phức tạp.
  - **Độc lập nền tảng**: Cú pháp lõi tương thích trên Oracle, SQL Server, MySQL, PostgreSQL (mỗi RDBMS có phần mở rộng riêng).
- **Phân nhóm lệnh chính**: DDL, DML, DCL, TCL.

---

# Tổng quan về SQL (2)

- **Mô hình thực thi**:
  - SQL gửi yêu cầu → Trình tối ưu (Optimizer) của Oracle phân tích → Thực thi kế hoạch → Trả kết quả.
  - Mỗi lệnh SQL có thể viết trên một hoặc nhiều dòng, kết thúc bằng dấu `;`.
- **Không hỗ trợ cấu trúc điều khiển trong chuẩn SQL gốc**:
  - Không có `IF`, `LOOP`, `EXCEPTION` → Cần kết hợp PL/SQL nếu muốn xử lý logic phức tạp.
- **Tính tương thích**:
  - Oracle 19c tuân thủ chuẩn SQL nhưng bổ sung nhiều tính năng nâng cao (PL/SQL, Analytic Functions, Partitioning...).
  - CSDL mẫu `EMP/DEPT` được thiết kế sẵn để minh họa toàn bộ cú pháp chuẩn.

---

# Kiểu dữ liệu trong SQL

Mỗi cột/biến trong CSDL phải được khai báo kiểu dữ liệu xác định phạm vi giá trị hợp lệ.

<div class="columns">
<div>

- **Kiểu số**:
  - `NUMBER(p,s)`: Kiểu số tổng quát của Oracle (thay thế `INTEGER`, `DECIMAL`). Ví dụ: `SAL NUMBER(7,2)`
- **Kiểu ký tự**:
  - `VARCHAR2(n)`: Chuỗi biến độ dài (tối đa 4000 bytes trong Oracle). Ví dụ: `ENAME VARCHAR2(10)`
  - `CHAR(n)`: Chuỗi cố định độ dài.
  - `CLOB`: Lưu trữ văn bản lớn (>4KB).
  </div>

<div>

- **Kiểu thời gian**:
  - `DATE`: Lưu ngày, giờ, phút, giây (Oracle mặc định có cả thời gian).
  - `TIMESTAMP`: Độ chính xác đến phần triệu giây.
- **Kiểu nhị phân**: `BLOB`, `RAW` (lưu hình ảnh, file).
- **Lưu ý**: Oracle không hỗ trợ `BOOLEAN` trong SQL thuần túy, chỉ dùng trong PL/SQL.

</div>
</div>

---

# Lệnh SQL

SQL chuẩn (ANSI/ISO) được chia thành 4 nhóm lệnh chính, mỗi nhóm phục vụ một mục đích quản trị và thao tác dữ liệu:

- **DDL (Data Definition Language)**: Định nghĩa cấu trúc CSDL (tạo, sửa, xóa bảng, chỉ mục...).
- **DML (Data Manipulation Language)**: Thao tác dữ liệu bên trong bảng (thêm, sửa, xóa, truy vấn).
- **DCL (Data Control Language)**: Quản lý phân quyền truy cập (cấp, thu hồi quyền).
- **TCL (Transaction Control Language)**: Quản lý giao dịch (xác nhận, hủy bỏ, điểm khôi phục).
- **Lưu ý**: Trong Oracle, mỗi nhóm có cơ chế `COMMIT`/`ROLLBACK` khác nhau, cần phân biệt rõ để đảm bảo tính toàn vẹn dữ liệu.

---

<!-- _class: section -->

# Data Definition Language (DDL)

---

# Data Definition Language (DDL)

- **Định nghĩa**: Nhóm lệnh dùng để tạo, thay đổi hoặc xóa các đối tượng trong CSDL (TABLE, VIEW, INDEX, SEQUENCE, SCHEMA...).
- **Đặc điểm quan trọng**:
  - Tự động thực hiện `COMMIT` ngầm định ngay khi lệnh thành công.
  - **Không thể `ROLLBACK`** sau khi lệnh DDL thực thi xong.
- **Các lệnh chính**:
  - `CREATE`: Tạo mới đối tượng.
  - `ALTER`: Thay đổi cấu trúc đối tượng.
  - `DROP`: Xóa đối tượng kèm dữ liệu.
  - `TRUNCATE`: Xóa nhanh toàn bộ dữ liệu, giữ cấu trúc.
  - `RENAME`: Đổi tên đối tượng.

---

# CREATE

- **Cú pháp**:
  ```sql
  CREATE TABLE table_name (
      column1 datatype [constraint],
      column2 datatype [constraint],
      ...
  );
  ```
- **Ví dụ thực hành (EMP/DEPT)**: Tạo bảng sao lưu thông tin nhân viên đã nghỉ việc.
  ```sql
  CREATE TABLE EMP_HISTORY (
      EMPNO NUMBER(4) PRIMARY KEY,
      ENAME VARCHAR2(10),
      JOB VARCHAR2(9),
      HIREDATE DATE,
      SEPARATION_DATE DATE DEFAULT SYSDATE
  );
  ```
- **Lưu ý**: Oracle luôn khai báo ràng buộc `PRIMARY KEY`, `NOT NULL` ngay khi tạo để đảm bảo tính toàn vẹn.

---

# DROP

- **Cú pháp**:
  ```sql
  DROP TABLE table_name [CASCADE CONSTRAINTS];
  ```
- **Tùy chọn**:
  - `CASCADE CONSTRAINTS`: Xóa bảng kèm các ràng buộc khóa ngoại tham chiếu đến nó (Oracle không hỗ trợ `RESTRICT` như chuẩn SQL, thay vào đó sẽ báo lỗi nếu có ràng buộc và không dùng `CASCADE`).
- **Ví dụ**:
  ```sql
  DROP TABLE EMP_HISTORY CASCADE CONSTRAINTS;
  ```
- **Cảnh báo**: Lệnh này xóa **vĩnh viễn** cả cấu trúc và dữ liệu. Không thể khôi phục bằng `ROLLBACK`. Trong Oracle 19c, bảng bị xóa sẽ chuyển vào `RECYCLEBIN`, có thể khôi phục bằng `FLASHBACK TABLE ... TO BEFORE DROP`.

---

# ALTER

- **Định nghĩa**: Sửa đổi cấu trúc của đối tượng đã tồn tại (thường là bảng).
- **Cú pháp cơ bản**:
  ```sql
  ALTER TABLE table_name action_clause;
  ```
- **Các hành động chính**:
  - `ADD`: Thêm cột mới.
  - `MODIFY`: Thay đổi kiểu dữ liệu, độ rộng, hoặc ràng buộc `NULL/NOT NULL`.
  - `DROP`: Xóa cột hoặc ràng buộc.
  - `RENAME`: Đổi tên cột.
- **Lưu ý**: `ALTER` cũng là lệnh DDL → Tự động `COMMIT`.

---

# Các lệnh thay đổi với ALTER

- **Thêm cột**:
  ```sql
  ALTER TABLE EMP ADD (BONUS NUMBER(7,2));
  ```
- **Thay đổi kiểu dữ liệu/độ rộng** (chỉ giảm độ rộng nếu cột rỗng):
  ```sql
  ALTER TABLE EMP MODIFY (ENAME VARCHAR2(20));
  ```
- **Đổi tên cột**:
  ```sql
  ALTER TABLE EMP RENAME COLUMN BONUS TO COMMISSION;
  ```
- **Xóa cột**:
  ```sql
  ALTER TABLE EMP DROP COLUMN COMMISSION;
  ```
- **Xóa ràng buộc**:
  ```sql
  ALTER TABLE EMP DROP CONSTRAINT SYS_C0012345;
  ```

---

# TRUNCATE

- **Định nghĩa**: Xóa toàn bộ dữ liệu trong bảng nhưng giữ nguyên cấu trúc, chỉ mục và ràng buộc.
- **Khác biệt so với `DELETE`**:
  - Nhanh hơn, không ghi vào `UNDO` log → Không thể `ROLLBACK`.
  - Tự động `COMMIT`, reset bộ đếm `SEQUENCE` (nếu có).
- **Cú pháp**:
  ```sql
  TRUNCATE TABLE table_name;
  ```
- **Ví dụ**:
  ```sql
  TRUNCATE TABLE EMP_HISTORY;
  ```
- **Ứng dụng**: Dùng khi cần làm sạch bảng log, bảng tạm hoặc reset dữ liệu test mà không muốn xóa cấu trúc.

---

# RENAME

- **Định nghĩa**: Đổi tên đối tượng CSDL.
- **Cú pháp Oracle** (khác chuẩn SQL):
  ```sql
  ALTER TABLE old_name RENAME TO new_name;
  -- Hoặc
  RENAME old_name TO new_name; (chỉ áp dụng cho table/view trong cùng schema)
  ```
- **Ví dụ**:
  ```sql
  ALTER TABLE EMP_HISTORY RENAME TO EMP_ARCHIVE;
  ```
- **Lưu ý**:
  - Đổi tên bảng không tự động cập nhật các `VIEW`, `PROCEDURE` hay `TRIGGER` đang tham chiếu đến tên cũ → Cần biên dịch lại các đối tượng phụ thuộc.
  - Không đổi tên được schema hoặc database bằng lệnh này.

---

<!-- _class: section -->

# Data Manipulation Language (DML)

---

# Data Manipulation Language (DML)

- **Định nghĩa**: Nhóm lệnh dùng để truy xuất và thao tác với dữ liệu bên trong các bảng.
- **Đặc điểm**:
  - **Không tự động `COMMIT`** → Cần dùng lệnh TCL (`COMMIT`/`ROLLBACK`) để lưu hoặc hủy thay đổi.
  - Có thể `ROLLBACK` trước khi xác nhận giao dịch.
  - Ghi nhận vào `UNDO` tablespace → Đảm bảo tính nhất quán đọc (Read Consistency).
- **Các lệnh chính**:
  - `SELECT`: Truy vấn dữ liệu.
  - `INSERT`: Thêm bản ghi mới.
  - `UPDATE`: Cập nhật giá trị.
  - `DELETE`: Xóa bản ghi.

---

# INSERT (1)

- **Cú pháp cơ bản**:
  ```sql
  INSERT INTO table_name [(column1, column2, ...)]
  VALUES (value1, value2, ...);
  ```
- **Ví dụ thêm nhân viên mới vào bảng EMP**:
  ```sql
  INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
  VALUES (7935, 'NGUYEN VAN A', 'CLERK', 7782, DATE '2024-01-15', 2500, 10);
  ```
- **Chèn mặc định (nếu đủ giá trị theo thứ tự cột)**:
  ```sql
  INSERT INTO EMP VALUES (7936, 'LE THI B', 'SALESMAN', 7698, SYSDATE, 1800, NULL, 30);
  ```
- **Hàm `INSERT ALL`** (Oracle): Chèn nhiều dòng cùng lúc từ một câu lệnh.

---

# INSERT (2)

- **Chèn theo danh sách cột cụ thể** (Khuyên dùng để tránh lỗi khi cấu trúc bảng thay đổi):
  ```sql
  INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
  VALUES (7937, 'TRAN VAN C', 'ANALYST', 3000, 20);
  ```
- **Chèn dữ liệu từ bảng khác (`INSERT INTO ... SELECT ...`)**:
  ```sql
  INSERT INTO EMP_ARCHIVE (EMPNO, ENAME, JOB, HIREDATE, SEPARATION_DATE)
  SELECT EMPNO, ENAME, JOB, HIREDATE, SYSDATE
  FROM EMP
  WHERE DEPTNO = 40;
  ```
- **Lưu ý Oracle**:
  - Ký tự ngày phải dùng `DATE 'YYYY-MM-DD'` hoặc `TO_DATE()`.
  - Khóa chính (`EMPNO`) phải là duy nhất, nếu trùng sẽ báo lỗi `ORA-00001`.

---

# UPDATE

- **Định nghĩa**: Cập nhật giá trị của một hoặc nhiều cột trong các bản ghi hiện có.
- **Cú pháp**:
  ```sql
  UPDATE table_name
  SET column1 = value1, column2 = value2
  WHERE condition;
  ```

<div class="columns">
<div>

- **Ví dụ 1**: Tăng lương 10% cho nhân viên phòng 30.
  ```sql
  UPDATE EMP SET SAL = SAL * 1.10 WHERE DEPTNO = 30;
  ```

</div>
<div>

- **Ví dụ 2**: Cập nhật nhiều cột.
  ```sql
  UPDATE EMP
  SET JOB = 'SENIOR ANALYST', SAL = 3500
  WHERE EMPNO = 7902;
  ```

</div>
</div>

- **Cảnh báo**: Nếu bỏ qua `WHERE`, **toàn bộ bảng** sẽ bị cập nhật → Luôn kiểm tra `SELECT` trước khi `UPDATE`.

---

# DELETE

- **Định nghĩa**: Xóa bản ghi khỏi bảng dựa trên điều kiện.
- **Cú pháp**:

  ```sql
  DELETE FROM table_name WHERE condition;
  ```

  <div class="columns">
  <div>

- **Ví dụ 1**: Xóa nhân viên có mã 7935.
  ```sql
  DELETE FROM EMP WHERE EMPNO = 7935;
  ```

</div>
<div>

- **Ví dụ 2**: Xóa toàn bộ nhân viên phòng 40.
  ```sql
  DELETE FROM EMP WHERE DEPTNO = 40;
  ```

</div>
</div>

- **Lưu ý quan trọng**:
  - Không có `WHERE` → Xóa sạch dữ liệu bảng (có thể `ROLLBACK`).
  - Nếu bảng có ràng buộc `FOREIGN KEY` tham chiếu, cần dùng `DELETE CASCADE` hoặc xóa dữ liệu con trước.
  - Khác với `TRUNCATE`: `DELETE` ghi log → Chậm hơn nhưng an toàn và có thể hoàn tác.

---

<!-- _class: section -->

# Data Control Language (DCL)

---

# Data Control Language (DCL)

- **Định nghĩa**: Nhóm lệnh quản lý quyền truy cập (Security & Access Control) trong CSDL Oracle.
- **Mục đích**:
  - Phân quyền (`GRANT`) cho người dùng (User) hoặc vai trò (Role).
  - Thu hồi quyền (`REVOKE`) khi không còn cần thiết.
- **Các lệnh chính**: `GRANT`, `REVOKE`.
- **Phạm vi áp dụng**:
  - System Privileges: Quyền cấp hệ thống (tạo user, kết nối, tạo bảng...).
  - Object Privileges: Quyền thao tác trên đối tượng cụ thể (`SELECT`, `INSERT` trên `SCOTT.EMP`).
- **Nguyên tắc bảo mật**: Always grant minimum required privileges (Least Privilege Principle).

---

# Privilege (quyền)

- **Định nghĩa**: Sự cho phép từ DBMS để người dùng/role thực hiện hành động cụ thể trên CSDL hoặc đối tượng dữ liệu.
- **Phân loại chính trong Oracle**:
  1. **System Privileges**: Quyền tác động ở mức hệ thống/database.
     - Ví dụ: `CREATE SESSION`, `CREATE TABLE`, `CREATE ANY VIEW`.
  2. **Object Privileges**: Quyền tác động trên đối tượng cụ thể (bảng, view, sequence, procedure...).
     - Ví dụ: `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `EXECUTE`, `ALTER`, `INDEX`.
- **Kiểm tra quyền**:
  ```sql
  SELECT * FROM USER_TAB_PRIVS WHERE TABLE_NAME = 'EMP';
  SELECT * FROM USER_SYS_PRIVS;
  ```

---

# Quyền sở hữu (Ownership Privilege)

- **Nguyên tắc sở hữu**:
  - Người tạo ra đối tượng (Creator) mặc định là **Owner**.
  - Owner có toàn quyền tuyệt đối trên đối tượng đó.
  - Owner có thể `GRANT`/`REVOKE` quyền cho user khác.
- **Đặc điểm không thể thu hồi**:
  - Quyền sở hữu không thể bị `REVOKE`.
  - Chỉ có thể chuyển quyền sở hữu bằng cách tạo lại đối tượng hoặc dùng `DBMS_REDEFINITION`/`EXPDP/IMPDP`.
- **Ví dụ**:
  - Schema `SCOTT` tạo bảng `EMP` → `SCOTT` là owner.
  - `SCOTT` có thể cấp `SELECT ON EMP TO PUBLIC` nhưng không ai có thể `REVOKE` quyền sở hữu từ `SCOTT`.

---

# System Privileges

- **Mô tả**: Quyền cho phép thực hiện các thao tác quản trị CSDL ở mức hệ thống.
- **Các quyền phổ biến trong Oracle 19c**:
  - `CREATE SESSION`: Cho phép kết nối vào CSDL.
  - `CREATE TABLE`, `CREATE VIEW`, `CREATE SEQUENCE`: Tạo đối tượng trong schema riêng.
  - `CREATE ANY TABLE`, `ALTER ANY TABLE`, `DROP ANY TABLE`: Thao tác trên mọi schema (Dành cho DBA).
  - `GRANT ANY PRIVILEGE`: Cấp quyền hệ thống cho user khác.
- **Ví dụ cấp quyền**:
  ```sql
  GRANT CREATE SESSION, CREATE TABLE TO NEW_USER;
  ```
- **Cảnh bảo bảo mật**: Chỉ cấp `ANY` privileges cho DBA hoặc tài khoản quản trị. Tránh cấp cho user ứng dụng.

---

# Object Privileges

- **Mô tả**: Quyền thao tác trực tiếp trên dữ liệu của một đối tượng cụ thể.
- **Quyền thường dùng trên bảng**:
<div class="columns">
<div class="col-2">
<ul>

- `SELECT`: Đọc dữ liệu.
- `INSERT`: Thêm hàng mới.
- `UPDATE`: Sửa giá trị.

</ul>

</div>
<div class="col-3">
<ul>

- `DELETE`: Xóa hàng.
- `REFERENCES`: Tạo khóa ngoại tham chiếu đến bảng.
- `ALL`: Gộp tất cả quyền trên.

</ul>
</div>
</div>

- **Ví dụ thực tế**:

  ```sql
  -- Cho phép user REPORT_USER chỉ được đọc dữ liệu EMP
  GRANT SELECT ON SCOTT.EMP TO REPORT_USER;

  -- Kiểm tra quyền hiện tại
  SELECT GRANTEE, PRIVILEGE FROM USER_TAB_PRIVS WHERE TABLE_NAME = 'EMP';
  ```

- **Tính kế thừa**: Quyền object không tự động kế thừa qua schema, phải cấp rõ ràng.

---

# Quyền và Vai trò (Roles)

- **Vấn đề**: Cấp quyền trực tiếp cho từng user gây phức tạp khi quản lý số lượng lớn.
- **Giải pháp RBAC (Role-Based Access Control)**:
  1. Tạo `ROLE` đại diện cho nhóm chức năng.
  2. Cấp quyền cho `ROLE`.
  3. Gán `ROLE` cho các `USER`.
- **Ví dụ Oracle**:

<div class="columns">
<div>

```sql
-- 1. Tạo role
CREATE ROLE EMP_VIEWER;
```

```sql
-- 3. Gán role cho user
GRANT EMP_VIEWER TO USER_A;
```

</div>
<div>
  
  ```sql
  -- 2. Cấp quyền cho role
  GRANT SELECT ON SCOTT.EMP TO EMP_VIEWER;
  GRANT SELECT ON SCOTT.DEPT TO EMP_VIEWER;
  ```

</div>
</div>

- **Lợi ích**: Dễ bảo trì, nhất quán chính sách bảo mật, giảm số lượng câu lệnh `GRANT`.

---

# GRANT

- **Cú pháp**:
  ```sql
  GRANT privilege_list ON object_name TO user_or_role [WITH GRANT OPTION];
  ```
- **Ví dụ 1**: Cấp quyền xem và thêm dữ liệu vào bảng `EMP` cho user `HR_USER`.
  ```sql
  GRANT SELECT, INSERT ON SCOTT.EMP TO HR_USER;
  ```
- **Ví dụ 2**: Cấp quyền cho Role `DEV_TEAM`.
  ```sql
  GRANT SELECT ON SCOTT.DEPT TO DEV_TEAM;
  ```
- **Tùy chọn `WITH GRANT OPTION`**: Cho phép người dùng được cấp quyền tiếp tục cấp quyền đó cho user khác. (Không áp dụng cho Role).
- **Lưu ý**: Phải chạy dưới quyền `SYS`, `SYSTEM` hoặc owner của đối tượng.

---

# REVOKE

- **Cú pháp**:
  ```sql
  REVOKE privilege_list ON object_name FROM user_or_role;
  ```

<div class="columns">
<div>

- **Ví dụ 1**: Thu hồi quyền `DELETE` trên `EMP` của `HR_USER`.
  ```sql
  REVOKE DELETE ON SCOTT.EMP FROM HR_USER;
  ```

</div>
<div>

- **Ví dụ 2**: Thu hồi tất cả quyền đối tượng.
  ```sql
  REVOKE ALL ON SCOTT.DEPT FROM DEV_TEAM;
  ```

</div>
</div>

- **Hành vi lan truyền**:
  - Nếu dùng `REVOKE ... CASCADE CONSTRAINTS`, các ràng buộc phụ thuộc cũng bị xóa.
  - Quyền đã cấp lại (Grant Option) sẽ tự động bị thu hồi theo chuỗi (Dependency chain).
- **Lưu ý**: Không thể `REVOKE` quyền sở hữu (Ownership).

---

<!-- _class: section -->

# Transaction Control Language (TCL)

---

# Transaction Control Language (TCL)

- **Định nghĩa**: Nhóm lệnh quản lý giao dịch (Transaction) – một đơn vị logic gồm nhiều thao tác SQL (thường là DML).
- **Mục đích**: Đảm bảo tính toàn vẹn dữ liệu khi thực hiện chuỗi thao tác liên quan.
- **Các lệnh chính**:
  - `COMMIT`: Xác nhận lưu vĩnh viễn.
  - `ROLLBACK`: Hủy bỏ thay đổi chưa lưu.
  - `SAVEPOINT`: Đặt mốc khôi phục trung gian.
  - `SET TRANSACTION`: Định nghĩa đặc tính giao dịch (Read Only/Write, Isolation Level).
- **Đặc điểm Oracle**: Tự động bắt đầu giao dịch khi thực thi lệnh DML đầu tiên. Kết thúc khi `COMMIT`, `ROLLBACK`, hoặc chạy lệnh DDL.

---

# Transaction

- **Định nghĩa**: Chuỗi lệnh SQL thực thi như một khối nguyên vẹn.
- **Thuộc tính ACID**:
  - **A – Atomicity**: Nguyên tử. Hoặc thành công toàn bộ, hoặc thất bại toàn bộ.
  - **C – Consistency**: Nhất quán. Dữ liệu luôn hợp lệ theo ràng buộc (PK, FK, Check) trước và sau giao dịch.
  - **I – Isolation**: Cô lập. Giao dịch chạy độc lập, không bị ảnh hưởng bởi giao dịch song song (đảm bảo bằng cơ chế MVCC trong Oracle).
  - **D – Durability**: Bền vững. Sau `COMMIT`, dữ liệu ghi vào redo log và datafile, không mất dù hệ thống crash.
- **Ví dụ tình huống**: Chuyển tiền → Trừ tài khoản A + Cộng tài khoản B phải nằm trong cùng 1 transaction. Nếu lệnh thứ 2 lỗi, lệnh 1 phải `ROLLBACK`.

---

# COMMIT

- **Chức năng**: Xác nhận vĩnh viễn các thay đổi DML trong giao dịch hiện tại.
- **Cú pháp**:
  ```sql
  COMMIT [WORK];
  ```
- **Ví dụ thực hành**:

  ```sql
  UPDATE EMP SET SAL = SAL + 500 WHERE DEPTNO = 10;
  INSERT INTO EMP_AUDIT VALUES (USER, SYSDATE, 'UPDATE SAL DEPT 10');
  COMMIT;
  ```

- **Kết quả sau COMMIT**:
  - Dữ liệu được ghi xuống disk.
  - Các `LOCK` trên bảng được giải phóng.
  - Không thể `ROLLBACK` lại các thay đổi đã commit.
  - Trong Oracle, `COMMIT` ngầm định xảy ra khi session kết thúc bình thường hoặc chạy lệnh DDL.

---

# ROLLBACK

- **Chức năng**: Hủy bỏ tất cả thay đổi DML chưa được `COMMIT`, đưa dữ liệu về trạng thái trước giao dịch hoặc `SAVEPOINT` gần nhất.

- **Cú pháp**:
  ```sql
  ROLLBACK [WORK];
  ```
- **Ví dụ**:

  ```sql
  UPDATE EMP SET COMM = 100 WHERE JOB = 'SALESMAN';
  -- Phát hiện lỗi logic, hủy thay đổi
  ROLLBACK;
  ```

- **Lưu ý quan trọng**:
  - `ROLLBACK` **không thể** hoàn tác lệnh DDL.
  - Chỉ hoạt động với DML chưa commit.</li>
  - Giải phóng khóa, khôi phục `UNDO` data.</li>

---

# SAVEPOINT

- **Chức năng**: Đặt điểm đánh dấu (mốc) trong giao dịch dài để cho phép `ROLLBACK` một phần thay vì hủy toàn bộ.
- **Cú pháp**:
  ```sql
  SAVEPOINT savepoint_name;
  ROLLBACK TO SAVEPOINT savepoint_name;
  ```
- **Ví dụ thực hành**:

  ```sql
  INSERT INTO EMP VALUES (9001, 'TEST1', 'CLERK', 7788, SYSDATE, 2000, NULL, 10);
  SAVEPOINT sp1;
  UPDATE EMP SET SAL = SAL * 2 WHERE DEPTNO = 20;

  -- Chỉ hủy UPDATE, giữ lại INSERT
  ROLLBACK TO SAVEPOINT sp1;
  COMMIT; -- Lưu INSERT ban đầu
  ```

---

# Quy tắc sử dụng SAVEPOINT

- Có thể đặt nhiều `SAVEPOINT`.
- `ROLLBACK TO sp` chỉ hủy thao tác **sau** điểm đó.
- Sau `COMMIT`, toàn bộ `SAVEPOINT` bị xóa.

---

<!-- _class: section -->

# Bài tập thực hành

---

# Bài 1 – Tạo bảng PROJECT và ASSIGNMENT

**Phát biểu bài toán**:
Phòng nhân sự muốn theo dõi các dự án của công ty và việc phân công nhân viên vào từng dự án. Hãy thiết kế 2 bảng:

- `PROJECT`: lưu thông tin dự án (mã dự án, tên dự án, ngày bắt đầu, ngày kết thúc dự kiến, ngân sách).
- `ASSIGNMENT`: lưu thông tin phân công nhân viên vào dự án (mã nhân viên, mã dự án, vai trò, ngày bắt đầu tham gia, số giờ làm việc mỗi tuần).
  Yêu cầu khai báo khóa chính, khóa ngoại và ràng buộc `NOT NULL` phù hợp.

---

# Lời giải Bài 1

```sql
CREATE TABLE PROJECT (
    PROJ_ID    NUMBER(4)    CONSTRAINT PK_PROJECT PRIMARY KEY,
    PROJ_NAME  VARCHAR2(50) NOT NULL,
    START_DATE DATE         NOT NULL,
    END_DATE   DATE,
    BUDGET     NUMBER(12,2) DEFAULT 0
);

CREATE TABLE ASSIGNMENT (
    EMPNO      NUMBER(4)    NOT NULL,
    PROJ_ID    NUMBER(4)    NOT NULL,
    ROLE       VARCHAR2(30),
    START_DATE DATE         DEFAULT SYSDATE,
    HOURS_WEEK NUMBER(3),
    CONSTRAINT PK_ASSIGNMENT PRIMARY KEY (EMPNO, PROJ_ID),
    CONSTRAINT FK_ASSIGN_EMP  FOREIGN KEY (EMPNO)   REFERENCES EMP(EMPNO),
    CONSTRAINT FK_ASSIGN_PROJ FOREIGN KEY (PROJ_ID) REFERENCES PROJECT(PROJ_ID)
);
```

---

# Bài 2 – ALTER, RENAME, TRUNCATE, DROP

**Phát biểu bài toán**:
Sau một thời gian vận hành, phòng nhân sự yêu cầu:

1. Thêm cột `DEPARTMENT` vào bảng `PROJECT` để lưu tên phòng ban phụ trách.
2. Đổi tên cột `BUDGET` thành `TOTAL_BUDGET`.
3. Mở rộng cột `PROJ_NAME` lên 100 ký tự.
4. Xóa toàn bộ dữ liệu trong bảng `ASSIGNMENT` (giữ nguyên cấu trúc) để nhập lại dữ liệu mới.
5. Cuối buổi thực hành, xóa hẳn bảng `ASSIGNMENT` khỏi CSDL.

---

# Lời giải Bài 2

```sql
-- 1. Thêm cột
ALTER TABLE PROJECT ADD (DEPARTMENT VARCHAR2(30));

-- 2. Đổi tên cột
ALTER TABLE PROJECT RENAME COLUMN BUDGET TO TOTAL_BUDGET;

-- 3. Mở rộng độ rộng
ALTER TABLE PROJECT MODIFY (PROJ_NAME VARCHAR2(100));

-- 4. Xóa dữ liệu (giữ cấu trúc)
TRUNCATE TABLE ASSIGNMENT;

-- 5. Xóa bảng (cần xóa bảng con trước do có FK)
DROP TABLE ASSIGNMENT CASCADE CONSTRAINTS;
```

---

# Bài 3 – INSERT dữ liệu dự án và phân công

**Phát biểu bài toán**:
Thêm vào bảng `PROJECT` 3 dự án mẫu và phân công một số nhân viên hiện có trong bảng `EMP` vào các dự án đó:

- Dự án P01: "HE THONG NHAN SU", khởi công 01/08/2026, ngân sách 500.000.000 VND, phòng IT.
- Dự án P02: "UNG Dung MOBILE BANKING", khởi công 15/09/2026, ngân sách 1.200.000.000 VND, phòng FINANCE.
- Dự án P03: "DAO TAB DU LIEU LON", khởi công 01/10/2026, ngân sách 300.000.000 VND, phòng IT.

Phân công: nhân viên 7788 (SCOTT) làm PM cho P01; 7902 (FORD) làm DEV cho P01 và P03; 7499 (ALLEN) làm Tester cho P02.

---

# Lời giải Bài 3

```sql
-- Thêm dự án
INSERT INTO PROJECT VALUES (1, 'HE THONG NHAN SU',        DATE '2026-08-01', DATE '2027-02-01', 500000000,  'IT');
INSERT INTO PROJECT VALUES (2, 'UNG DUNG MOBILE BANKING', DATE '2026-09-15', DATE '2027-06-15', 1200000000, 'FINANCE');
INSERT INTO PROJECT VALUES (3, 'DAO TAB DU LIEU LON',     DATE '2026-10-01', DATE '2027-01-31', 300000000,  'IT');

-- Phân công nhân viên
INSERT INTO ASSIGNMENT VALUES (7788, 1, 'PROJECT MANAGER', DATE '2026-08-01', 40);
INSERT INTO ASSIGNMENT VALUES (7902, 1, 'DEVELOPER',       DATE '2026-08-15', 35);
INSERT INTO ASSIGNMENT VALUES (7902, 3, 'DEVELOPER',       DATE '2026-10-05', 20);
INSERT INTO ASSIGNMENT VALUES (7499, 2, 'TESTER',          DATE '2026-09-20', 30);

COMMIT;
```

---

# Bài 4 – UPDATE và DELETE có điều kiện

**Phát biểu bài toán**:

1. Tăng ngân sách 20% cho tất cả các dự án do phòng `IT` phụ trách.
2. Cập nhật vai trò của nhân viên 7902 trong dự án P03 từ `DEVELOPER` thành `TECH LEAD` và tăng giờ làm lên 40h/tuần.
3. Hủy phân công của nhân viên 7499 ra khỏi dự án P02 (do nhân viên này đã nghỉ việc).
4. Xóa dự án P03 ra khỏi hệ thống (sau khi đã xóa các phân công liên quan).

---

# Lời giải Bài 4

```sql
-- 1. Tăng ngân sách 20% cho phòng IT
UPDATE PROJECT
SET TOTAL_BUDGET = TOTAL_BUDGET * 1.2
WHERE DEPARTMENT = 'IT';

-- 2. Cập nhật vai trò và giờ làm
UPDATE ASSIGNMENT
SET ROLE = 'TECH LEAD', HOURS_WEEK = 40
WHERE EMPNO = 7902 AND PROJ_ID = 3;

-- 3. Hủy phân công nhân viên 7499 khỏi P02
DELETE FROM ASSIGNMENT
WHERE EMPNO = 7499 AND PROJ_ID = 2;

-- 4. Xóa các phân công của P03 trước, rồi xóa dự án
DELETE FROM ASSIGNMENT WHERE PROJ_ID = 3;
DELETE FROM PROJECT    WHERE PROJ_ID = 3;

COMMIT;
```

---

# Bài 5 – Tạo User, Role và GRANT quyền

**Phát biểu bài toán**:
Công ty có 2 nhóm người dùng mới cần truy cập CSDL:

- `INTERN_GROUP`: nhóm thực tập sinh, chỉ được **đọc** dữ liệu trên `EMP` và `DEPT`.
- `PM_GROUP`: nhóm quản lý dự án, được **đọc** toàn bộ `EMP`, `DEPT`, `PROJECT`, `ASSIGNMENT` và được **cập nhật** cột `HOURS_WEEK` trên bảng `ASSIGNMENT`.

Hãy tạo 2 user (`INTERN01`, `PM01`), tạo 2 role tương ứng, cấp quyền và gán role cho user.

---

# Lời giải Bài 5

```sql
-- (Chạy bằng tài khoản DBA: SYSTEM hoặc SYS)
CREATE USER INTERN01 IDENTIFIED BY intern123;
CREATE USER PM01     IDENTIFIED BY pm123;
GRANT CREATE SESSION TO INTERN01, PM01;

-- Tạo role
CREATE ROLE R_INTERN;
CREATE ROLE R_PM;

-- Cấp quyền object cho role
GRANT SELECT ON SCOTT.EMP      TO R_INTERN;
GRANT SELECT ON SCOTT.DEPT     TO R_INTERN;

GRANT SELECT ON SCOTT.EMP        TO R_PM;
GRANT SELECT ON SCOTT.DEPT       TO R_PM;
GRANT SELECT ON SCOTT.PROJECT    TO R_PM;
GRANT SELECT ON SCOTT.ASSIGNMENT TO R_PM;
GRANT UPDATE (HOURS_WEEK) ON SCOTT.ASSIGNMENT TO R_PM;

-- Gán role cho user
GRANT R_INTERN TO INTERN01;
GRANT R_PM     TO PM01;
```

---

# Bài 6 – REVOKE và kiểm tra quyền

**Phát biểu bài toán**:

1. Thu hồi quyền `SELECT` trên bảng `DEPT` của nhóm thực tập sinh (do chính sách bảo mật mới).
2. Thu hồi toàn bộ quyền trên bảng `PROJECT` của nhóm PM.
3. Viết câu truy vấn để kiểm tra:
   - Các quyền object mà user `PM01` đang có.
   - Các role đã được gán cho user `INTERN01`.

---

# Lời giải Bài 6

```sql
-- 1. Thu hồi SELECT trên DEPT của nhóm intern
REVOKE SELECT ON SCOTT.DEPT FROM R_INTERN;

-- 2. Thu hồi toàn bộ quyền trên PROJECT của nhóm PM
REVOKE ALL ON SCOTT.PROJECT FROM R_PM;

-- 3. Kiểm tra quyền
-- Xem các quyền object hiện có của PM01 (chạy dưới quyền PM01)
SELECT OWNER, TABLE_NAME, PRIVILEGE
FROM   USER_TAB_PRIVS
ORDER BY TABLE_NAME;

-- Xem các role được gán cho INTERN01 (chạy dưới quyền DBA)
SELECT GRANTEE, GRANTED_ROLE, ADMIN_OPTION, DEFAULT_ROLE
FROM   DBA_ROLE_PRIVS
WHERE  GRANTEE = 'INTERN01';
```

---

# Bài 7 – Giao dịch chuyển phòng ban (COMMIT/ROLLBACK)

**Phát biểu bài toán**:
Phòng nhân sự thực hiện đợt điều chuyển nhân sự: chuyển toàn bộ nhân viên phòng 20 (RESEARCH) sang phòng 10 (ACCOUNTING), đồng thời tăng lương 5% cho họ. Quy trình gồm 2 bước:

1. Cập nhật `DEPTNO = 10` và `SAL = SAL * 1.05` cho các nhân viên phòng 20.
2. Ghi log điều chuyển vào bảng `EMP_TRANSFER_LOG` (tạo mới nếu chưa có).

Nếu bước 2 thất bại (ví dụ: bảng log bị lỗi), hãy hủy toàn bộ thay đổi ở bước 1 để đảm bảo tính nhất quán.

---

# Lời giải Bài 7

```sql
-- Tạo bảng log
CREATE TABLE EMP_TRANSFER_LOG (
    LOG_ID     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    EMPNO      NUMBER(4),
    FROM_DEPT  NUMBER(2),
    TO_DEPT    NUMBER(2),
    OLD_SAL    NUMBER(7,2),
    NEW_SAL    NUMBER(7,2),
    LOG_DATE   DATE DEFAULT SYSDATE
);

-- Bắt đầu giao dịch
-- Bước 1: Ghi log trước (để biết danh sách nhân viên sẽ chuyển)
INSERT INTO EMP_TRANSFER_LOG (EMPNO, FROM_DEPT, TO_DEPT, OLD_SAL, NEW_SAL)
SELECT EMPNO, DEPTNO, 10, SAL, SAL * 1.05
FROM   EMP WHERE DEPTNO = 20;

-- Bước 2: Cập nhật EMP
UPDATE EMP
SET    DEPTNO = 10, SAL = SAL * 1.05
WHERE  DEPTNO = 20;

-- Nếu mọi thứ OK → COMMIT
COMMIT;

-- Nếu phát hiện sai sót → ROLLBACK toàn bộ
-- ROLLBACK;
```

---

# Bài 8 – SAVEPOINT trong giao dịch phức tạp

**Phát biểu bài toán**:
Một giao dịch gồm 3 thao tác liên tiếp trên bảng `EMP`:

1. Tăng lương 10% cho toàn bộ nhân viên có chức vụ `CLERK`.
2. Thêm một nhân viên mới (mã 9999) vào phòng 30.
3. Xóa nhân viên mã 7934 (MILLER).

Yêu cầu:

- Sau thao tác 1, đặt `SAVEPOINT SP1`.
- Sau thao tác 2, đặt `SAVEPOINT SP2`.
- Giả sử thao tác 3 gặp lỗi nghiệp vụ (không được phép xóa MILLER), hãy rollback về `SP2` để giữ lại 2 thao tác trước, sau đó `COMMIT`.

---

# Lời giải Bài 8

```sql
-- Thao tác 1
UPDATE EMP SET SAL = SAL * 1.10 WHERE JOB = 'CLERK';
SAVEPOINT SP1;

-- Thao tác 2
INSERT INTO EMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, DEPTNO)
VALUES (9999, 'NGUYEN VAN F', 'CLERK', 7698, SYSDATE, 1500, 30);
SAVEPOINT SP2;

-- Thao tác 3 (giả sử cần hủy)
DELETE FROM EMP WHERE EMPNO = 7934;

-- Rollback về SP2 → chỉ hủy thao tác 3
ROLLBACK TO SAVEPOINT SP2;

-- COMMIT để lưu 2 thao tác đầu
COMMIT;

-- Kiểm tra kết quả
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB = 'CLERK';
```

---

# Bài 9 – Quy trình tuyển dụng nhân viên mới

**Phát biểu bài toán**:
Viết một chuỗi lệnh SQL mô phỏng **quy trình tuyển dụng** một nhân viên mới vào công ty, bao gồm:

1. Kiểm tra phòng ban `MARKETING` đã tồn tại trong `DEPT` chưa; nếu chưa thì tạo mới (DEPTNO = 50, LOC = 'HO CHI MINH').
2. Thêm nhân viên mới vào `EMP` với thông tin: mã 8000, tên 'TRAN THI G', job 'SALESMAN', lương 1800, phòng 50.
3. Phân công nhân viên này vào dự án P02 (Mobile Banking) với vai trò 'BUSINESS ANALYST', 25h/tuần.
4. Ghi nhận vào bảng `EMP_TRANSFER_LOG` một bản tin "NEW HIRE".
5. Nếu bất kỳ bước nào (2)–(4) thất bại, hủy toàn bộ; nếu thành công, xác nhận giao dịch.

---

# Lời giải Bài 9

```sql
-- Bước 1: DDL (tự động COMMIT) – tạo phòng ban nếu chưa có
BEGIN
    INSERT INTO DEPT (DEPTNO, DNAME, LOC)
    SELECT 50, 'MARKETING', 'HO CHI MINH'
    FROM   DUAL
    WHERE  NOT EXISTS (SELECT 1 FROM DEPT WHERE DEPTNO = 50);
    COMMIT;
EXCEPTION WHEN OTHERS THEN ROLLBACK; RAISE;
END;

-- Bước 2-5: DML trong một giao dịch
INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO, HIREDATE)
VALUES (8000, 'TRAN THI G', 'SALESMAN', 1800, 50, SYSDATE);

INSERT INTO ASSIGNMENT (EMPNO, PROJ_ID, ROLE, HOURS_WEEK)
VALUES (8000, 2, 'BUSINESS ANALYST', 25);

INSERT INTO EMP_TRANSFER_LOG (EMPNO, FROM_DEPT, TO_DEPT, OLD_SAL, NEW_SAL)
VALUES (8000, NULL, 50, 0, 1800);

-- Nếu tất cả thành công
COMMIT;

-- Nếu có lỗi ở bất kỳ bước nào → hủy toàn bộ
-- ROLLBACK;
```
