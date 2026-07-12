## Bài tập thực hành Chương 4

---

### PHẦN 1 – KIẾN TRÚC ORACLE DATABASE VÀ MULTITENANT

**Bài 1**. Truy vấn thông tin của instance hiện tại: tên instance, host name, phiên bản, trạng thái. Sử dụng `v$instance`.

**Bài 2**. Truy vấn thông tin database: tên database, DBID, ngày tạo, chế độ log (ARCHIVELOG/NOARCHIVELOG). Sử dụng `v$database`.

**Bài 3**. Xác định trạng thái mở của database (READ WRITE, READ ONLY, MOUNTED). Sử dụng `v$database`.

**Bài 4**. Liệt kê tất cả các PDB đang có trong CDB và trạng thái mở của chúng. Sử dụng `v$pdbs`.

**Bài 5**. Xác định container hiện tại đang kết nối (root hay PDB). Sử dụng `sys_context('USERENV','CON_NAME')`.

**Bài 6**. Chuyển đổi session sang một PDB cụ thể (ví dụ `PDB1`) và kiểm tra lại container hiện tại.

**Bài 7**. Liệt kê tất cả các common user trong CDB (tên bắt đầu bằng C##). Sử dụng `dba_users` với điều kiện `username LIKE 'C##%'`.

**Bài 8**. Tạo một common user với tên `C##DEMO` và mật khẩu, cấp quyền `CREATE SESSION` với tùy chọn `CONTAINER=ALL`.

**Bài 9**. Kết nối vào một PDB và tạo một local user (tên không bắt đầu C##) trong PDB đó. Sau đó truy vấn danh sách user trong PDB để thấy sự khác biệt.

**Bài 10**. Kiểm tra trạng thái của các background processes (ít nhất là DBWn, LGWR, CKPT) thông qua view `v$bgprocess` hoặc mô tả.

---

### PHẦN 2 – QUẢN TRỊ TABLESPACE VÀ LƯU TRỮ

**Bài 11**. Tạo một permanent tablespace tên `TS_APP` với datafile `ts_app01.dbf`, kích thước 100M, autoextend ON, next 10M, maxsize 500M, quản lý extent local.

**Bài 12**. Tạo một temporary tablespace tên `TS_TEMP` với tempfile kích thước 200M, autoextend ON, next 50M, maxsize 1G, extent management uniform size 1M.

**Bài 13**. Tạo một undo tablespace tên `TS_UNDO` với datafile `undo_ts01.dbf`, kích thước 500M, autoextend ON, next 100M, maxsize 2G.

**Bài 14**. Kích hoạt Oracle Managed Files (OMF) bằng cách thiết lập tham số `DB_CREATE_FILE_DEST` thành một thư mục hợp lệ (ví dụ `/u01/app/oracle/oradata/`). Sau đó tạo một tablespace `TS_OMF` với OMF, không chỉ định tên file.

**Bài 15**. Tạo một bigfile tablespace tên `TS_BIG`, datafile kích thước 10G, autoextend, maxsize 32T. Kiểm tra thông tin bigfile trong `dba_tablespaces`.

**Bài 16**. Thêm một datafile thứ hai vào tablespace `TS_APP` với kích thước 500M.

**Bài 17**. Thay đổi kích thước datafile của `TS_APP` từ 100M lên 800M (resize). Kiểm tra lại kích thước.

**Bài 18**. Đưa tablespace `TS_APP` sang chế độ offline, sau đó online trở lại. Kiểm tra trạng thái.

**Bài 19**. Chuyển tablespace `TS_APP` sang chế độ read-only, thử thực hiện một câu lệnh INSERT vào bảng trong tablespace đó (sẽ báo lỗi), sau đó chuyển lại read-write.

**Bài 20**. Drop tablespace `TS_OMF` bao gồm cả dữ liệu và datafile (sử dụng `INCLUDING CONTENTS AND DATAFILES`). Kiểm tra xem file có bị xóa khỏi OS không.

---

### PHẦN 3 – SCHEMA VÀ CÁC ĐỐI TƯỢNG

**Bài 21**. Tạo bảng `EMPLOYEES` với các cột `EMP_ID` (NUMBER, PK), `NAME` (VARCHAR2(100) NOT NULL), `HIRE_DATE` (DATE DEFAULT SYSDATE), `SALARY` (NUMBER(8,2)) trong tablespace `TS_APP`.

**Bài 22**. Tạo một B-tree index trên cột `NAME` của bảng `EMPLOYEES` trong một tablespace riêng (nếu có) hoặc trong `TS_APP`.

**Bài 23**. Tạo một bitmap index trên cột `STATUS` (giả sử có cột STATUS trong bảng) và kiểm tra loại index trong `dba_indexes`.

**Bài 24**. Tạo một function-based index trên `UPPER(NAME)` và kiểm tra.

**Bài 25**. Tạo một view đơn giản `EMP_VIEW` chỉ hiển thị `EMP_ID`, `NAME`, `SALARY` cho nhân viên có `DEPT_ID=10` (giả sử có cột DEPT_ID). Sau đó truy vấn view.

**Bài 26**. Tạo một complex view `DEPT_SALARY` hiển thị trung bình lương theo phòng ban (giả sử có bảng DEPARTMENTS).

**Bài 27**. Tạo một materialized view `MV_SALES` dùng để tổng hợp doanh số (nếu có bảng SALES), với refresh complete on demand. Refresh thủ công bằng `DBMS_MVIEW.REFRESH`.

**Bài 28**. Tạo một sequence `SEQ_EMP` bắt đầu từ 1000, increment 1, cache 20. Sử dụng sequence để chèn một dòng mới vào bảng `EMPLOYEES` (dùng `NEXTVAL` cho EMP_ID).

**Bài 29**. Tạo private synonym `EMP` cho bảng `EMPLOYEES` và truy vấn qua synonym đó. Sau đó tạo public synonym và kiểm tra.

**Bài 30**. Di chuyển bảng `EMPLOYEES` sang một tablespace khác (ví dụ `TS_DATA`) bằng lệnh `ALTER TABLE ... MOVE`, sau đó rebuild index. Kiểm tra lại tablespace của bảng.

---

### PHẦN 4 – DATA DICTIONARY VÀ DYNAMIC PERFORMANCE VIEWS

**Bài 31**. Liệt kê tất cả các bảng thuộc schema của user hiện tại (sử dụng `USER_TABLES`).

**Bài 32**. Liệt kê tất cả các đối tượng (bảng, view, index, v.v.) mà user hiện tại có quyền truy cập (sử dụng `ALL_OBJECTS`).

**Bài 33**. Truy vấn để biết tất cả các tablespace trong database và trạng thái của chúng (sử dụng `DBA_TABLESPACES`).

**Bài 34**. Sử dụng `DBA_DATA_FILES` để hiển thị tên file, tablespace, kích thước và khả năng autoextend của tất cả datafiles.

**Bài 35**. Tính tổng dung lượng sử dụng và tỷ lệ phần trăm đã dùng cho mỗi tablespace bằng cách kết hợp `DBA_DATA_FILES` và `DBA_FREE_SPACE`.

**Bài 36**. Truy vấn `V$SESSION` để xem danh sách các session đang kết nối, bao gồm OS user, username Oracle, chương trình.

**Bài 37**. Sử dụng `V$SQL` để lấy danh sách 10 câu SQL gần đây nhất có thời gian thực thi lâu nhất (theo `ELAPSED_TIME`).

**Bài 38**. Truy vấn `V$LOCK` để xem các lock đang tồn tại trong hệ thống.

**Bài 39**. Xem các tham số khởi tạo của database liên quan đến undo (UNDO_TABLESPACE, UNDO_RETENTION) thông qua `V$PARAMETER`.

**Bài 40**. Trong môi trường Multitenant, truy vấn `CDB_OBJECTS` để đếm số lượng bảng trong từng PDB (theo `CON_ID`).

---

### PHẦN 5 – QUẢN TRỊ NGƯỜI DÙNG VÀ BẢO MẬT

**Bài 41**. Tạo user `APP_USER` với mật khẩu, default tablespace `TS_APP`, temporary tablespace `TS_TEMP`.

**Bài 42**. Cấp quyền `CREATE SESSION` và `CREATE TABLE` cho `APP_USER`.

**Bài 43**. Tạo role `APP_ROLE` và cấp quyền `SELECT`, `INSERT` trên bảng `EMPLOYEES` cho role đó. Gán role này cho `APP_USER`.

**Bài 44**. Kiểm tra các role đã được gán cho `APP_USER` (sử dụng `DBA_ROLE_PRIVS`).

**Bài 45**. Thiết lập quota 500M trên tablespace `TS_APP` cho user `APP_USER`. Kiểm tra quota bằng `DBA_TS_QUOTAS`.

**Bài 46**. Tạo profile `APP_PROFILE` với giới hạn: số lần đăng nhập sai tối đa 5, khóa trong 1 ngày, thời gian sống của mật khẩu 90 ngày, không cho phép dùng lại mật khẩu trong 365 ngày.

**Bài 47**. Gán profile `APP_PROFILE` cho user `APP_USER`. Kiểm tra profile của user.

**Bài 48**. Thay đổi mật khẩu của user `APP_USER` và sau đó khóa tài khoản, rồi mở khóa lại.

**Bài 49**. Cấp quyền `SYSDBA` cho một user quản trị (ví dụ `DBA_USER`) và kiểm tra xem user đó có quyền trong `V$PWFILE_USERS` không.

**Bài 50**. Thu hồi quyền `CREATE TABLE` từ user `APP_USER` và kiểm tra lại quyền hiện có.

---

### PHẦN 6 – SAO LƯU VÀ PHỤC HỒI (RMAN)

**Bài 51**. Kết nối RMAN vào target database (local, không cần catalog) và hiển thị cấu hình hiện tại (`SHOW ALL`).

**Bài 52**. Cấu hình chính sách lưu giữ backup (RETENTION POLICY) là redundancy 2.

**Bài 53**. Cấu hình backup optimization và set device type là disk với parallelism 2.

**Bài 54**. Thực hiện full backup database (bao gồm archive log) với lệnh `BACKUP DATABASE PLUS ARCHIVELOG DELETE INPUT;`.

**Bài 55**. Thực hiện backup incremental level 0 cho toàn bộ database.

**Bài 56**. Backup một tablespace cụ thể (ví dụ `TS_APP`) bằng RMAN.

**Bài 57**. Liệt kê danh sách các backup đã thực hiện (sử dụng `LIST BACKUP SUMMARY`).

**Bài 58**. Báo cáo các file cần được backup (sử dụng `REPORT NEED BACKUP`).

**Bài 59**. Xóa các backup cũ (obsolete) theo chính sách lưu giữ đã cấu hình (`DELETE OBSOLETE`).

**Bài 60**. Mô phỏng phục hồi: restore database từ backup, sau đó recover database (chạy lệnh `RESTORE DATABASE; RECOVER DATABASE;`). (Có thể chỉ thực hiện ở chế độ kiểm tra nếu môi trường thật.)

---

### PHẦN 7 – BÀI TẬP TỔNG HỢP (TÍCH HỢP NHIỀU PHẦN)

**Bài 61. Tạo user, profile và tablespace**  
Tạo một tablespace mới `TS_DATA` và một user `HR_USER` với default tablespace `TS_DATA`, quota 1G trên `TS_DATA`, profile có giới hạn failed login 3 lần. Cấp quyền CREATE SESSION và CREATE TABLE.

**Bài 62. Tạo bảng và index trên tablespace riêng**  
Tạo bảng `HR_EMPLOYEES` trong `TS_DATA`, đồng thời tạo index trên cột `LAST_NAME` trong một tablespace khác (nếu có). Sau đó kiểm tra tablespace của bảng và index.

**Bài 63. Sử dụng sequence và trigger**  
Tạo sequence `HR_SEQ` và trigger tự động gán giá trị cho khóa chính khi INSERT. Chèn thử một vài dòng và kiểm tra giá trị.

**Bài 64. Tạo view và materialized view**  
Tạo view `HR_EMP_DEPT` kết hợp bảng nhân viên và phòng ban. Tạo materialized view tổng hợp số nhân viên theo phòng ban, refresh hàng ngày.

**Bài 65. Phân quyền bằng role**  
Tạo role `HR_READONLY` với quyền SELECT trên các bảng của HR_USER. Gán role đó cho một user khác (`HR_USER2`) và kiểm tra quyền truy cập.

**Bài 66. Backup tablespace bằng RMAN**  
Thực hiện backup tablespace `TS_DATA` bằng RMAN, sau đó kiểm tra xem backup đã thành công chưa (LIST).

**Bài 67. Khôi phục bảng bị xóa (Flashback)**  
Giả sử bảng `HR_EMPLOYEES` bị drop, sử dụng `FLASHBACK TABLE ... TO BEFORE DROP` để khôi phục (nếu có recyclebin). Nếu không, mô tả cách dùng RMAN để restore và recover.

**Bài 68. Di chuyển tablespace và cập nhật quota**  
Di chuyển bảng `HR_EMPLOYEES` sang tablespace `TS_APP`, sau đó cập nhật quota cho user để không bị vượt dung lượng.

**Bài 69. Quản lý archive log và chuyển đổi chế độ**  
Kiểm tra database đang ở chế độ ARCHIVELOG hay NOARCHIVELOG. Nếu ở NOARCHIVELOG, hãy liệt kê các bước để chuyển sang ARCHIVELOG (không thực hiện nếu không có quyền). Sau đó, cấu hình RMAN backup archive log.

**Bài 70. Báo cáo tổng hợp và giám sát**  
Viết một script SQL hoặc RMAN để thực hiện các công việc sau:

- Kiểm tra dung lượng tablespace đã sử dụng, cảnh báo nếu vượt quá 80%.
- Liệt kê các backup gần đây nhất.
- Hiển thị danh sách user và role của họ.
