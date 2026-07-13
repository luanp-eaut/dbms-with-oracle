## Bài tập thực hành chương 3

---

### PHẦN 1 – KHỐI PL/SQL, BIẾN, HẰNG, KIỂU DỮ LIỆU

**Bài 1**. Viết một khối PL/SQL ẩn danh in ra dòng chữ: _"Chào mừng đến với PL/SQL"_. Sử dụng `DBMS_OUTPUT`.

**Bài 2**. Khai báo một biến `v_empno` kiểu `NUMBER(4)` và gán giá trị 7369. Dùng `SELECT INTO` để lấy tên nhân viên (`ENAME`) và lương (`SAL`) vào hai biến, sau đó in ra.

**Bài 3**. Khai báo hằng số `C_TAX_RATE` = 0.1. Tính thuế thu nhập (lương \* thuế suất) cho nhân viên có mã 7788 và in ra kết quả.

**Bài 4**. Sử dụng `%TYPE` để khai báo biến `v_name` cùng kiểu với cột `ENAME` của bảng EMP. Gán giá trị 'KING' và in ra.

**Bài 5**. Sử dụng `%ROWTYPE` để khai báo biến record `v_emp` lưu toàn bộ dòng của bảng EMP cho nhân viên 7900. In ra `EMPNO`, `ENAME`, `SAL`.

**Bài 6**. Tự định nghĩa kiểu record `t_emp_summary` gồm các trường: `emp_id`, `full_name`, `monthly_income`. Tạo biến kiểu đó, gán giá trị từ bảng EMP cho nhân viên 7698 và in ra.

**Bài 7**. Khai báo một Associative Array (chỉ mục số) để lưu danh sách tên nhân viên. Thêm 3 tên bất kỳ và duyệt qua mảng để in ra.

**Bài 8**. Khai báo một Associative Array với chỉ mục là `VARCHAR2` (tên nhân viên) và giá trị là lương. Điền vào 3 cặp tên-lương, sau đó in lương của một nhân viên cụ thể.

**Bài 9**. Khai báo một Nested Table chứa các số `NUMBER`. Thêm 5 số, xóa phần tử thứ 3, in ra số lượng và các phần tử còn lại.

**Bài 10**. Khai báo một VARRAY tối đa 5 phần tử lưu trữ tên phòng ban. Khởi tạo với 3 phòng, thêm một phòng nữa và in toàn bộ.

---

### PHẦN 2 – CẤU TRÚC ĐIỀU KHIỂN VÀ VÒNG LẶP

**Bài 11**. Viết khối PL/SQL dùng `IF-THEN-ELSE` để kiểm tra lương của nhân viên 7654. Nếu lương > 1500 thì in _"Lương cao"_, ngược lại in _"Lương thấp"_.

**Bài 12**. Dùng `IF-THEN-ELSIF` phân loại lương:

- ≥ 3000: "Cao"
- 2000 – 2999: "Trung bình"
- < 2000: "Thấp"  
  Áp dụng cho nhân viên 7782.

**Bài 13**. Dùng `CASE` đơn giản để chuyển đổi mã phòng ban (10,20,30,40) thành tên phòng ban tương ứng (ACCOUNTING, RESEARCH, SALES, OPERATIONS) và in ra cho nhân viên 7900.

**Bài 14**. Dùng `CASE` tìm kiếm để xếp loại lương tương tự Bài 12, nhưng sử dụng `CASE` trong biểu thức gán.

**Bài 15**. Viết vòng lặp `LOOP` cơ bản để tính tổng các số từ 1 đến 100 và in ra kết quả.

**Bài 16**. Viết vòng lặp `WHILE` để tính giai thừa của 6 (6!).

**Bài 17**. Viết vòng lặp `FOR` để in ra bảng cửu chương của số 7 (từ 1 đến 10).

**Bài 18**. Dùng vòng lặp `FOR` với `REVERSE` để in các số từ 10 đến 1.

**Bài 19**. Sử dụng `EXIT WHEN` trong vòng lặp `LOOP` để tính tổng các số chẵn từ 1 đến 50, dừng khi tổng vượt quá 500.

**Bài 20**. Sử dụng `CONTINUE WHEN` trong vòng lặp `FOR` để in ra các số lẻ từ 1 đến 20 (bỏ qua số chẵn).

---

### PHẦN 3 – TRUY VẤN DỮ LIỆU VÀ DML TRONG PL/SQL

**Bài 21**. Viết khối PL/SQL dùng `SELECT INTO` lấy `ENAME`, `SAL`, `DEPTNO` của nhân viên 7844. In ra thông tin. Xử lý ngoại lệ `NO_DATA_FOUND`.

**Bài 22**. Sử dụng `%ROWTYPE` để lấy toàn bộ dòng của nhân viên 7521 và in ra tất cả các cột.

**Bài 23**. Viết khối PL/SQL chèn một nhân viên mới vào bảng EMP với thông tin: EMPNO=9001, ENAME='NGUYEN VAN X', JOB='CLERK', SAL=1500, DEPTNO=20. Sử dụng `COMMIT`.

**Bài 24**. Viết khối cập nhật lương tăng 10% cho nhân viên có mã 9001 (đã tạo ở bài trước). Kiểm tra số dòng bị ảnh hưởng bằng `SQL%ROWCOUNT`.

**Bài 25**. Xóa nhân viên 9001 và thông báo xóa thành công hay không dùng `SQL%FOUND`.

**Bài 26**. Sử dụng biến PL/SQL trong câu lệnh INSERT: khai báo biến cho EMPNO, ENAME, SAL, DEPTNO và thêm nhân viên mới.

**Bài 27**. Cập nhật lương cho nhân viên bằng biến: khai báo `v_empno` và `v_new_sal`, thực hiện UPDATE và commit.

**Bài 28**. Thực hiện DELETE tất cả nhân viên thuộc phòng 99 (không có), dùng `SQL%NOTFOUND` để thông báo không có dòng nào bị xóa.

**Bài 29**. Viết khối PL/SQL chèn một nhân viên, sau đó cập nhật lương của nhân viên đó, rồi xóa nhân viên đó, tất cả trong một transaction. Sau đó rollback để hủy toàn bộ.

**Bài 30**. Sử dụng `SELECT INTO` lấy tổng số nhân viên (hàm `COUNT`) vào biến và in ra.

---

### PHẦN 4 – CURSOR

**Bài 31**. Khai báo một cursor tường minh để lấy `EMPNO`, `ENAME`, `SAL` của tất cả nhân viên. Dùng vòng lặp `LOOP` với `FETCH` và `EXIT WHEN` để in ra từng dòng.

**Bài 32**. Sử dụng `%ROWTYPE` của cursor để lấy toàn bộ dòng trong cursor (truy vấn `SELECT *`). In ra các cột.

**Bài 33**. Sử dụng `CURSOR FOR LOOP` để duyệt qua tất cả nhân viên và in `ENAME`, `JOB`.

**Bài 34**. Viết cursor có tham số `p_deptno` để lấy nhân viên theo phòng. Gọi cursor cho phòng 20 và 30.

**Bài 35**. Viết cursor có tham số `p_min_sal` để lấy nhân viên có lương lớn hơn mức đó. Gọi với `p_min_sal = 2000`.

**Bài 36**. Sử dụng thuộc tính `%ROWCOUNT` sau khi duyệt cursor để in ra tổng số nhân viên đã fetch.

**Bài 37**. Khai báo cursor với `FOR UPDATE OF sal` để khóa cột lương. Duyệt cursor và tăng lương 10% cho từng nhân viên, sử dụng `WHERE CURRENT OF`.

**Bài 38**. Sử dụng cursor `FOR UPDATE` (không chỉ định cột) và `DELETE WHERE CURRENT OF` để xóa nhân viên có lương < 1000 (nếu có).

**Bài 39**. Viết cursor tham số với giá trị mặc định (DEFAULT) và gọi mà không truyền tham số.

**Bài 40**. Sử dụng cursor để cập nhật cột `COMM` = 500 cho các nhân viên có `JOB = 'SALESMAN'` (dùng `FOR UPDATE` và `WHERE CURRENT OF`).

---

### PHẦN 5 – EXCEPTION HANDLING

**Bài 41**. Viết khối `SELECT INTO` lấy tên nhân viên với mã không tồn tại (9999). Bắt ngoại lệ `NO_DATA_FOUND` và in thông báo.

**Bài 42**. Viết khối thực hiện phép chia 100/0. Bắt `ZERO_DIVIDE` và in thông báo lỗi.

**Bài 43**. Thử chèn một nhân viên có `EMPNO` trùng với khóa chính (ví dụ 7369). Bắt `DUP_VAL_ON_INDEX` và xử lý.

**Bài 44**. Khai báo ngoại lệ tự tạo `e_high_salary`. Trong khối, lấy lương của 7788, nếu > 5000 thì `RAISE e_high_salary` và bắt ngoại lệ đó.

**Bài 45**. Sử dụng `RAISE_APPLICATION_ERROR` với mã -20001 và thông báo _"Lương không được âm"_ khi phát hiện lương < 0 (giả sử lấy từ bảng).

**Bài 46**. Kết hợp `RAISE` và `RAISE_APPLICATION_ERROR`: bắt ngoại lệ tự tạo, sau đó ném lại bằng `RAISE_APPLICATION_ERROR` với mã tùy chỉnh.

**Bài 47**. Viết khối có ngoại lệ `WHEN OTHERS` để bắt tất cả lỗi và in ra `SQLERRM`.

**Bài 48**. Sử dụng `PRAGMA EXCEPTION_INIT` để gán tên cho một lỗi Oracle cụ thể (ví dụ ORA-01403) và bắt nó.

**Bài 49**. Viết khối lồng nhau (khối cha và khối con). Trong khối con, ném ngoại lệ `NO_DATA_FOUND` và không xử lý, để nó lan truyền lên khối cha và bắt ở đó.

**Bài 50**. Trong khối PL/SQL, cập nhật lương của nhân viên 7788. Nếu có lỗi, rollback; nếu thành công, commit. Sử dụng `EXCEPTION` để rollback khi có lỗi.

---

### PHẦN 6 – PROCEDURE, FUNCTION, PACKAGE, TRIGGER

**Bài 51**. Tạo một stored procedure đơn giản `proc_hello` in ra "Hello from Procedure". Gọi procedure đó.

**Bài 52**. Tạo procedure `increase_salary` nhận `p_empno` và `p_percent`, tăng lương theo tỷ lệ và commit. Xử lý ngoại lệ nếu không tìm thấy nhân viên.

**Bài 53**. Tạo procedure `get_emp_info` có tham số `IN` là `p_empno` và ba tham số `OUT` là `p_ename`, `p_sal`, `p_deptno`. Gọi và in ra kết quả.

**Bài 54**. Tạo procedure `swap_numbers` có hai tham số `IN OUT` để hoán đổi giá trị của hai số. Gọi và kiểm tra.

**Bài 55**. Tạo function `calc_annual_salary` nhận `p_empno`, trả về lương năm (lương \*12 + hoa hồng). Sử dụng function trong câu lệnh SELECT.

**Bài 56**. Tạo function `get_dept_name` nhận `p_deptno` trả về tên phòng. Nếu không có thì trả về NULL. Gọi trong SELECT.

**Bài 57**. Tạo package `emp_pkg` với spec có: biến public `g_default_dept` (NUMBER), procedure `add_emp`, function `get_annual`. Cài đặt package body.

**Bài 58**. Sử dụng package ở bài 57, gọi procedure thêm nhân viên và function tính lương năm.

**Bài 59**. Tạo trigger `trg_before_insert_emp` tự động chuyển `ENAME` thành chữ hoa, gán `HIREDATE` = SYSDATE nếu NULL khi INSERT. Kiểm tra.

**Bài 60**. Tạo trigger `trg_after_delete_emp` ghi log vào bảng `emp_audit` (tạo sẵn) với thông tin nhân viên bị xóa. Xóa một nhân viên và kiểm tra log.

---

### PHẦN 7 – BÀI TẬP TỔNG HỢP (TÍCH HỢP DDL, DML, PL/SQL, CURSOR, EXCEPTION, PROCEDURE, FUNCTION, TRIGGER)

**Bài 61. Cập nhật lương hàng loạt với cursor**  
Viết procedure `bulk_salary_update` sử dụng cursor để tăng lương 5% cho tất cả nhân viên phòng 30, đồng thời cập nhật cột `COMM` = 200 cho các nhân viên đó. Xử lý ngoại lệ và commit.

**Bài 62. Kiểm tra ràng buộc bằng trigger**  
Tạo trigger `trg_check_sal` trước khi UPDATE hoặc INSERT trên EMP, ngăn chặn việc đặt `SAL` < 500. Dùng `RAISE_APPLICATION_ERROR`.

**Bài 63. Hàm tính lương thực nhận**  
Tạo function `net_salary` nhận `p_empno`, tính lương sau thuế (giả sử thuế 10% trên lương, nếu lương > 3000). Sử dụng trong SELECT.

**Bài 64. Package quản lý nhân viên**  
Xây dựng package `hr_admin` với:

- Procedure `fire_emp(p_empno)` xóa nhân viên và ghi log vào bảng `emp_audit`.
- Function `count_emp(p_deptno)` trả về số nhân viên thuộc phòng.
- Trigger tự động cập nhật số lượng khi thêm/xóa.

**Bài 65. Giao dịch chuyển phòng ban**  
Viết procedure `transfer_dept` nhận `p_empno`, `p_new_deptno`, thực hiện:

- Kiểm tra nhân viên tồn tại.
- Kiểm tra phòng mới tồn tại.
- Cập nhật DEPTNO.
- Ghi log vào bảng `emp_transfer_log` (tạo sẵn).
- Nếu có lỗi, rollback.

**Bài 66. Sử dụng cursor tham số và exception**  
Viết procedure `print_emp_by_dept(p_deptno)` dùng cursor có tham số để in danh sách nhân viên. Nếu phòng không có nhân viên, thông báo "Phòng trống".

**Bài 67. Trigger ngăn chặn giảm lương**  
Tạo trigger `trg_no_sal_decrease` trên EMP, chỉ cho phép UPDATE SAL nếu giá trị mới >= giá trị cũ. Nếu vi phạm, báo lỗi.

**Bài 68. Tự động sinh mã nhân viên**  
Tạo sequence `seq_empno` bắt đầu 9000. Tạo trigger BEFORE INSERT trên EMP để tự động gán `EMPNO` từ sequence nếu `:NEW.EMPNO` là NULL. Kiểm tra bằng cách INSERT không có EMPNO.

**Bài 69. Procedure thêm dự án và phân công**  
Viết procedure `add_project_assignment` nhận thông tin dự án (PROJ_ID, PROJ_NAME, ...) và phân công nhân viên (EMPNO, ROLE, HOURS_WEEK) vào dự án đó. Nếu dự án đã tồn tại thì chỉ thêm phân công. Sử dụng transaction và rollback nếu lỗi.

**Bài 70. Báo cáo tổng hợp bằng PL/SQL**  
Viết một khối PL/SQL sử dụng cursor để lấy danh sách các phòng ban, và với mỗi phòng, lấy danh sách nhân viên. In ra báo cáo dạng:

```
Phòng ACCOUNTING (10)
- KING: 5000
- CLARK: 2450
Tổng lương phòng: ...
```

Xử lý ngoại lệ khi không có dữ liệu.
