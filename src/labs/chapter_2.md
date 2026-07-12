## Bài tập thực hành Chương 2

---

### PHẦN 1 – DATA DEFINITION LANGUAGE (DDL)

**Bài 1**. Tạo bảng **DEPARTMENT** gồm các cột:

- `DEPT_ID` (số, khóa chính)
- `DEPT_NAME` (chuỗi không quá 50, NOT NULL)
- `LOCATION` (chuỗi 30, có thể NULL)
- `BUDGET` (số với 2 chữ số thập phân, mặc định 0)

**Bài 2**. Tạo bảng **EMPLOYEE_AUDIT** dùng để lưu vết thay đổi của bảng EMP, gồm:

- `AUDIT_ID` (số tự tăng – dùng `GENERATED ALWAYS AS IDENTITY`)
- `EMPNO` (số 4, NOT NULL)
- `ACTION` (chuỗi 10, NOT NULL, kiểm tra giá trị trong ('INSERT','UPDATE','DELETE'))
- `CHANGE_DATE` (ngày giờ, mặc định SYSDATE)
- `USER_NAME` (chuỗi 30, mặc định USER)

**Bài 3**. Thêm ràng buộc khóa ngoại cho bảng **EMPLOYEE_AUDIT** tham chiếu đến cột `EMPNO` của bảng EMP.

**Bài 4**. Thêm cột `EMAIL` (VARCHAR2(100)) vào bảng EMP.

**Bài 5**. Sửa đổi cột `ENAME` trong bảng EMP thành `VARCHAR2(30)` và thêm ràng buộc NOT NULL cho cột này.

**Bài 6**. Đổi tên bảng **EMPLOYEE_AUDIT** thành **EMP_CHANGE_LOG**.

**Bài 7**. Xóa cột `EMAIL` khỏi bảng EMP.

**Bài 8**. Xóa ràng buộc khóa ngoại vừa tạo ở Bài 3 (giả sử tên ràng buộc là `FK_AUDIT_EMP`).

**Bài 9**. Sử dụng lệnh `TRUNCATE` để xóa toàn bộ dữ liệu trong bảng **EMP_CHANGE_LOG** nhưng giữ nguyên cấu trúc.

**Bài 10**. Xóa hoàn toàn bảng **EMP_CHANGE_LOG** khỏi cơ sở dữ liệu (kể cả các ràng buộc tham chiếu).

---

### PHẦN 2 – DATA MANIPULATION LANGUAGE (DML)

**Bài 11**. Chèn một phòng ban mới vào bảng DEPT với mã 60, tên 'HR', vị trí 'Hanoi'.

**Bài 12**. Chèn nhân viên mới vào bảng EMP với các thông tin:

- EMPNO = 8001
- ENAME = 'LE VAN A'
- JOB = 'MANAGER'
- MGR = 7839
- HIREDATE = '01-01-2026' (dùng TO_DATE hoặc DATE literal)
- SAL = 5000
- DEPTNO = 60

**Bài 13**. Chèn đồng thời 2 nhân viên vào bảng EMP bằng câu lệnh `INSERT ALL`:

- (8002, 'NGUYEN THI B', 'CLERK', 8001, SYSDATE, 2000, NULL, 60)
- (8003, 'TRAN VAN C', 'ANALYST', 8001, SYSDATE, 4000, NULL, 60)

**Bài 14**. Chèn dữ liệu từ bảng EMP vào bảng **EMP_HISTORY** (đã tạo sẵn) với điều kiện nhân viên có DEPTNO = 10.

**Bài 15**. Cập nhật lương (SAL) tăng 15% cho tất cả nhân viên thuộc phòng 20.

**Bài 16**. Cập nhật đồng thời JOB thành 'SENIOR CLERK' và SAL thành 3000 cho nhân viên có EMPNO = 8002.

**Bài 17**. Xóa nhân viên có EMPNO = 8003 khỏi bảng EMP.

**Bài 18**. Xóa tất cả nhân viên thuộc phòng 30.

**Bài 19**. Viết câu lệnh `SELECT` để hiển thị danh sách nhân viên (EMPNO, ENAME, SAL) với mức lương lớn hơn 2500, sắp xếp theo SAL giảm dần.

**Bài 20**. Viết câu lệnh `SELECT` kết hợp bảng EMP và DEPT để hiển thị EMPNO, ENAME, DNAME, LOC cho nhân viên có JOB = 'MANAGER'.

---

### PHẦN 3 – DATA CONTROL LANGUAGE (DCL)

**Bài 21**. Tạo một user tên **USER1** với mật khẩu `pass123` (cần quyền DBA).

**Bài 22**. Cấp quyền `CREATE SESSION` cho user **USER1** để có thể đăng nhập.

**Bài 23**. Tạo một role tên **ROLE_READ** với mục đích chỉ đọc dữ liệu.

**Bài 24**. Cấp quyền `SELECT` trên bảng EMP và DEPT cho role **ROLE_READ**.

**Bài 25**. Gán role **ROLE_READ** cho user **USER1**.

**Bài 26**. Tạo user **USER2** và gán trực tiếp quyền `INSERT`, `UPDATE` trên bảng EMP cho user này (không qua role).

**Bài 27**. Cấp quyền `DELETE` trên bảng EMP cho user **USER1** với tùy chọn `WITH GRANT OPTION`.

**Bài 28**. Thu hồi quyền `DELETE` trên bảng EMP của user **USER1**.

**Bài 29**. Thu hồi toàn bộ quyền trên bảng DEPT từ role **ROLE_READ**.

**Bài 30**. Viết câu truy vấn kiểm tra tất cả các quyền hệ thống (system privileges) mà user **USER1** đang có.

---

### PHẦN 4 – TRANSACTION CONTROL LANGUAGE (TCL)

**Bài 31**. Thực hiện một giao dịch: tăng lương 10% cho tất cả nhân viên phòng 10, sau đó xác nhận (`COMMIT`).

**Bài 32**. Giả sử bạn vừa xóa nhầm một nhân viên (EMPNO = 8002), hãy viết lệnh `ROLLBACK` để khôi phục lại (trước khi COMMIT).

**Bài 33**. Tạo một `SAVEPOINT` tên `SP_BEFORE_UPDATE` trước khi cập nhật lương, sau đó cập nhật lương tăng 20% cho phòng 30. Nếu phát hiện sai sót, rollback về `SP_BEFORE_UPDATE` và commit giao dịch rỗng.

**Bài 34**. Mở một giao dịch, thực hiện 3 thao tác:

- Chèn một nhân viên mới (EMPNO = 9001)
- Cập nhật lương nhân viên 9001 thành 3000
- Xóa nhân viên 9001  
  Sau đó rollback toàn bộ.

**Bài 35**. Sử dụng `SAVEPOINT` để chỉ rollback một phần: sau khi chèn nhân viên 9002, đặt savepoint A; sau khi cập nhật lương, đặt savepoint B; sau đó rollback về savepoint A để giữ lại chèn nhưng hủy cập nhật.

**Bài 36**. Viết một giao dịch chuyển nhân viên từ phòng 10 sang phòng 20, đồng thời giảm lương 5% cho họ. Nếu bất kỳ lệnh nào thất bại, rollback. Sử dụng cấu trúc xử lý ngoại lệ (PL/SQL) hoặc giả định.

**Bài 37**. Thực hiện một giao dịch với 2 lệnh UPDATE và 1 lệnh INSERT, sau đó COMMIT. Kiểm tra kết quả bằng SELECT.

**Bài 38**. Tạo một giao dịch chỉ đọc (`SET TRANSACTION READ ONLY`) và thử thực hiện UPDATE – giải thích lỗi.

**Bài 39**. Sử dụng `ROLLBACK TO SAVEPOINT` để khôi phục trạng thái trước khi thực hiện một DELETE có điều kiện (giả sử xóa nhân viên có SAL < 1000, nhưng sau đó phát hiện có lỗi).

**Bài 40**. Tạo bảng **TEST** và thực hiện một giao dịch gồm INSERT, UPDATE, DELETE. Sau đó thực hiện lệnh DDL (ví dụ: ALTER TABLE) và quan sát tác động của COMMIT ngầm định. Giải thích tại sao không thể ROLLBACK sau DDL.
