## Bài tập thực hành chương 3

---

### PHẦN 1 – KHỐI PL/SQL, BIẾN, HẰNG, KIỂU DỮ LIỆU

**Bài 1**. Viết một khối PL/SQL ẩn danh in ra dòng chữ: _"Chào mừng đến với PL/SQL"_. Sử dụng `DBMS_OUTPUT`.

<div style="display: none;">

```sql
BEGIN
    DBMS_OUTPUT.PUT_LINE('Chào mừng đến với PL/SQL');
END;
```

</div>

**Bài 2**. Khai báo một biến `v_empno` kiểu `NUMBER(4)` và gán giá trị 7369. Dùng `SELECT INTO` để lấy tên nhân viên (`ENAME`) và lương (`SAL`) vào hai biến, sau đó in ra.

<div style="display: none;">

```sql
DECLARE
    v_empno EMP.EMPNO%TYPE := 7369;
    v_ename EMP.ENAME%TYPE;
    v_sal   EMP.SAL%TYPE;
BEGIN
    SELECT ENAME, SAL INTO v_ename, v_sal
    FROM EMP
    WHERE EMPNO = v_empno;
    
    DBMS_OUTPUT.PUT_LINE('Nhân viên: ' || v_ename || ', Lương: ' || v_sal);
END;
```

</div>

**Bài 3**. Khai báo hằng số `C_TAX_RATE` = 0.1. Tính thuế thu nhập (lương \* thuế suất) cho nhân viên có mã 7788 và in ra kết quả.

<div style="display: none;">

```sql
DECLARE
    C_TAX_RATE CONSTANT NUMBER := 0.1;
    v_sal      EMP.SAL%TYPE;
    v_tax      NUMBER;
BEGIN
    SELECT SAL INTO v_sal
    FROM EMP
    WHERE EMPNO = 7788;
    
    v_tax := v_sal * C_TAX_RATE;
    DBMS_OUTPUT.PUT_LINE('Thuế của nhân viên 7788: ' || v_tax);
END;
```

</div>

**Bài 4**. Sử dụng `%TYPE` để khai báo biến `v_name` cùng kiểu với cột `ENAME` của bảng EMP. Gán giá trị 'KING' và in ra.

<div style="display: none;">

```sql
DECLARE
    v_name EMP.ENAME%TYPE := 'KING';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Tên nhân viên: ' || v_name);
END;
```

</div>

**Bài 5**. Sử dụng `%ROWTYPE` để khai báo biến record `v_emp` lưu toàn bộ dòng của bảng EMP cho nhân viên 7900. In ra `EMPNO`, `ENAME`, `SAL`.

<div style="display: none;">

```sql
DECLARE
    v_emp EMP%ROWTYPE;
BEGIN
    SELECT * INTO v_emp
    FROM EMP
    WHERE EMPNO = 7900;
    
    DBMS_OUTPUT.PUT_LINE('EMPNO: ' || v_emp.EMPNO || 
                         ', ENAME: ' || v_emp.ENAME || 
                         ', SAL: ' || v_emp.SAL);
END;
```

</div>

**Bài 6**. Tự định nghĩa kiểu record `t_emp_summary` gồm các trường: `emp_id`, `full_name`, `monthly_income`. Tạo biến kiểu đó, gán giá trị từ bảng EMP cho nhân viên 7698 và in ra.

<div style="display: none;">

```sql
DECLARE
    TYPE t_emp_summary IS RECORD (
        emp_id         EMP.EMPNO%TYPE,
        full_name      EMP.ENAME%TYPE,
        monthly_income EMP.SAL%TYPE
    );
    v_summary t_emp_summary;
BEGIN
    SELECT EMPNO, ENAME, SAL
    INTO v_summary
    FROM EMP
    WHERE EMPNO = 7698;
    
    DBMS_OUTPUT.PUT_LINE('Mã: ' || v_summary.emp_id || 
                         ', Tên: ' || v_summary.full_name || 
                         ', Lương: ' || v_summary.monthly_income);
END;
```

</div>

**Bài 7**. Khai báo một Associative Array (chỉ mục số) để lưu danh sách tên nhân viên. Thêm 3 tên bất kỳ và duyệt qua mảng để in ra.

<div style="display: none;">

```sql
DECLARE
    TYPE t_name_array IS TABLE OF VARCHAR2(30) INDEX BY PLS_INTEGER;
    v_names t_name_array;
    v_idx   PLS_INTEGER;
BEGIN
    v_names(1) := 'Nguyễn Văn A';
    v_names(2) := 'Trần Thị B';
    v_names(3) := 'Lê Văn C';
    
    v_idx := v_names.FIRST;
    WHILE v_idx IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE(v_idx || ': ' || v_names(v_idx));
        v_idx := v_names.NEXT(v_idx);
    END LOOP;
END;
```

</div>

**Bài 8**. Khai báo một Associative Array với chỉ mục là `VARCHAR2` (tên nhân viên) và giá trị là lương. Điền vào 3 cặp tên-lương, sau đó in lương của một nhân viên cụ thể.

<div style="display: none;">

```sql
DECLARE
    TYPE t_sal_array IS TABLE OF NUMBER INDEX BY VARCHAR2(30);
    v_salaries t_sal_array;
    v_ename    VARCHAR2(30) := 'Nguyễn Văn A';
BEGIN
    v_salaries('Nguyễn Văn A') := 1000;
    v_salaries('Trần Thị B')  := 1500;
    v_salaries('Lê Văn C')    := 2000;
    
    DBMS_OUTPUT.PUT_LINE('Lương của ' || v_ename || ': ' || v_salaries(v_ename));
END;
```

</div>

**Bài 9**. Khai báo một Nested Table chứa các số `NUMBER`. Thêm 5 số, xóa phần tử thứ 3, in ra số lượng và các phần tử còn lại.

<div style="display: none;">

```sql
DECLARE
    TYPE t_num_table IS TABLE OF NUMBER;
    v_nums t_num_table := t_num_table();  -- Khởi tạo rỗng
    v_idx  PLS_INTEGER;
BEGIN
    -- Thêm 5 số (1,2,3,4,5)
    v_nums.EXTEND(5);
    FOR i IN 1..5 LOOP
        v_nums(i) := i;
    END LOOP;
    
    -- Xóa phần tử thứ 3
    v_nums.DELETE(3);
    
    -- In số lượng phần tử còn lại (sau khi xóa, COUNT vẫn trả về số phần tử hiện có)
    DBMS_OUTPUT.PUT_LINE('Số lượng phần tử: ' || v_nums.COUNT);
    
    -- Duyệt các phần tử còn lại
    v_idx := v_nums.FIRST;
    WHILE v_idx IS NOT NULL LOOP
        DBMS_OUTPUT.PUT_LINE('v_nums(' || v_idx || ') = ' || v_nums(v_idx));
        v_idx := v_nums.NEXT(v_idx);
    END LOOP;
END;
```

</div>

**Bài 10**. Khai báo một VARRAY tối đa 5 phần tử lưu trữ tên phòng ban. Khởi tạo với 3 phòng, thêm một phòng nữa và in toàn bộ.

<div style="display: none;">

```sql
DECLARE
    TYPE t_dept_varray IS VARRAY(5) OF VARCHAR2(30);
    v_depts t_dept_varray := t_dept_varray('Kế toán', 'Nghiên cứu', 'Bán hàng');
BEGIN
    -- Thêm một phòng nữa (mở rộng và gán giá trị)
    v_depts.EXTEND;
    v_depts(4) := 'Nhân sự';
    
    -- In toàn bộ
    FOR i IN 1..v_depts.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(i || ': ' || v_depts(i));
    END LOOP;
END;
```

</div>

---

### PHẦN 2 – CẤU TRÚC ĐIỀU KHIỂN VÀ VÒNG LẶP

**Bài 11**. Viết khối PL/SQL dùng `IF-THEN-ELSE` để kiểm tra lương của nhân viên 7654. Nếu lương > 1500 thì in _"Lương cao"_, ngược lại in _"Lương thấp"_.

<div style="display: none;">

```sql
DECLARE
    v_sal EMP.SAL%TYPE;
BEGIN
    SELECT SAL INTO v_sal
    FROM EMP
    WHERE EMPNO = 7654;
    
    IF v_sal > 1500 THEN
        DBMS_OUTPUT.PUT_LINE('Lương cao');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Lương thấp');
    END IF;
END;
```

</div>

**Bài 12**. Dùng `IF-THEN-ELSIF` phân loại lương:

- ≥ 3000: "Cao"
- 2000 – 2999: "Trung bình"
- < 2000: "Thấp"  
  Áp dụng cho nhân viên 7782.

<div style="display: none;">

```sql
DECLARE
    v_sal EMP.SAL%TYPE;
    v_grade VARCHAR2(20);
BEGIN
    SELECT SAL INTO v_sal
    FROM EMP
    WHERE EMPNO = 7782;
    
    IF v_sal >= 3000 THEN
        v_grade := 'Cao';
    ELSIF v_sal BETWEEN 2000 AND 2999 THEN
        v_grade := 'Trung bình';
    ELSE
        v_grade := 'Thấp';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Phân loại lương: ' || v_grade);
END;
```

</div>

**Bài 13**. Dùng `CASE` đơn giản để chuyển đổi mã phòng ban (10,20,30,40) thành tên phòng ban tương ứng (ACCOUNTING, RESEARCH, SALES, OPERATIONS) và in ra cho nhân viên 7900.

<div style="display: none;">

```sql
DECLARE
    v_deptno EMP.DEPTNO%TYPE;
    v_dname  VARCHAR2(20);
BEGIN
    SELECT DEPTNO INTO v_deptno
    FROM EMP
    WHERE EMPNO = 7900;
    
    v_dname := CASE v_deptno
                   WHEN 10 THEN 'ACCOUNTING'
                   WHEN 20 THEN 'RESEARCH'
                   WHEN 30 THEN 'SALES'
                   WHEN 40 THEN 'OPERATIONS'
                   ELSE 'UNKNOWN'
               END;
    
    DBMS_OUTPUT.PUT_LINE('Phòng ban: ' || v_dname);
END;
```

</div>

**Bài 14**. Dùng `CASE` tìm kiếm để xếp loại lương tương tự Bài 12, nhưng sử dụng `CASE` trong biểu thức gán.

<div style="display: none;">

```sql
DECLARE
    v_sal   EMP.SAL%TYPE;
    v_grade VARCHAR2(20);
BEGIN
    SELECT SAL INTO v_sal
    FROM EMP
    WHERE EMPNO = 7782;
    
    v_grade := CASE 
                   WHEN v_sal >= 3000 THEN 'Cao'
                   WHEN v_sal BETWEEN 2000 AND 2999 THEN 'Trung bình'
                   ELSE 'Thấp'
               END;
    
    DBMS_OUTPUT.PUT_LINE('Phân loại lương: ' || v_grade);
END;
```

</div>

**Bài 15**. Viết vòng lặp `LOOP` cơ bản để tính tổng các số từ 1 đến 100 và in ra kết quả.

<div style="display: none;">

```sql
DECLARE
    v_sum   NUMBER := 0;
    v_i     NUMBER := 1;
BEGIN
    LOOP
        v_sum := v_sum + v_i;
        v_i := v_i + 1;
        EXIT WHEN v_i > 100;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Tổng từ 1 đến 100: ' || v_sum);
END;
```

</div>

**Bài 16**. Viết vòng lặp `WHILE` để tính giai thừa của 6 (6!).

<div style="display: none;">

```sql
DECLARE
    v_fact NUMBER := 1;
    v_i    NUMBER := 1;
BEGIN
    WHILE v_i <= 6 LOOP
        v_fact := v_fact * v_i;
        v_i := v_i + 1;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('6! = ' || v_fact);
END;
```

</div>

**Bài 17**. Viết vòng lặp `FOR` để in ra bảng cửu chương của số 7 (từ 1 đến 10).

<div style="display: none;">

```sql
DECLARE
    v_num CONSTANT NUMBER := 7;
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num || ' x ' || i || ' = ' || (v_num * i));
    END LOOP;
END;
```

</div>

**Bài 18**. Dùng vòng lặp `FOR` với `REVERSE` để in các số từ 10 đến 1.

<div style="display: none;">

```sql
BEGIN
    FOR i IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
```

</div>

**Bài 19**. Sử dụng `EXIT WHEN` trong vòng lặp `LOOP` để tính tổng các số chẵn từ 1 đến 50, dừng khi tổng vượt quá 500.

<div style="display: none;">

```sql
DECLARE
    v_sum NUMBER := 0;
    v_i   NUMBER := 2; -- bắt đầu từ số chẵn đầu tiên
BEGIN
    LOOP
        EXIT WHEN v_i > 50 OR v_sum > 500;
        v_sum := v_sum + v_i;
        v_i := v_i + 2; -- nhảy đến số chẵn tiếp theo
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('Tổng các số chẵn (dừng khi >500): ' || v_sum);
END;
```

</div>

**Bài 20**. Sử dụng `CONTINUE WHEN` trong vòng lặp `FOR` để in ra các số lẻ từ 1 đến 20 (bỏ qua số chẵn).

<div style="display: none;">

```sql
BEGIN
    FOR i IN 1..20 LOOP
        CONTINUE WHEN MOD(i, 2) = 0;
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
```

</div>

---

### PHẦN 3 – TRUY VẤN DỮ LIỆU VÀ DML TRONG PL/SQL

**Bài 21**. Viết khối PL/SQL dùng `SELECT INTO` lấy `ENAME`, `SAL`, `DEPTNO` của nhân viên 7844. In ra thông tin. Xử lý ngoại lệ `NO_DATA_FOUND`.

<div style="display: none;">

```sql
DECLARE
    v_ename  EMP.ENAME%TYPE;
    v_sal    EMP.SAL%TYPE;
    v_deptno EMP.DEPTNO%TYPE;
    v_empno  EMP.EMPNO%TYPE := 7844;
BEGIN
    SELECT ENAME, SAL, DEPTNO
    INTO v_ename, v_sal, v_deptno
    FROM EMP
    WHERE EMPNO = v_empno;
    
    DBMS_OUTPUT.PUT_LINE('Nhân viên: ' || v_ename || 
                         ', Lương: ' || v_sal || 
                         ', Phòng: ' || v_deptno);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy nhân viên có mã ' || v_empno);
END;
```

</div>

**Bài 22**. Sử dụng `%ROWTYPE` để lấy toàn bộ dòng của nhân viên 7521 và in ra tất cả các cột.

<div style="display: none;">

```sql
DECLARE
    v_emp   EMP%ROWTYPE;
    v_empno EMP.EMPNO%TYPE := 7521;
BEGIN
    SELECT * INTO v_emp
    FROM EMP
    WHERE EMPNO = v_empno;
    
    DBMS_OUTPUT.PUT_LINE('EMPNO: ' || v_emp.EMPNO);
    DBMS_OUTPUT.PUT_LINE('ENAME: ' || v_emp.ENAME);
    DBMS_OUTPUT.PUT_LINE('JOB: ' || v_emp.JOB);
    DBMS_OUTPUT.PUT_LINE('MGR: ' || v_emp.MGR);
    DBMS_OUTPUT.PUT_LINE('HIREDATE: ' || v_emp.HIREDATE);
    DBMS_OUTPUT.PUT_LINE('SAL: ' || v_emp.SAL);
    DBMS_OUTPUT.PUT_LINE('COMM: ' || v_emp.COMM);
    DBMS_OUTPUT.PUT_LINE('DEPTNO: ' || v_emp.DEPTNO);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy nhân viên ' || v_empno);
END;
```

</div>

**Bài 23**. Viết khối PL/SQL chèn một nhân viên mới vào bảng EMP với thông tin: EMPNO=9001, ENAME='NGUYEN VAN X', JOB='CLERK', SAL=1500, DEPTNO=20. Sử dụng `COMMIT`.

<div style="display: none;">

```sql
BEGIN
    INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
    VALUES (9001, 'NGUYEN VAN X', 'CLERK', 1500, 20);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Đã chèn nhân viên 9001 thành công.');
END;
```

</div>

**Bài 24**. Viết khối cập nhật lương tăng 10% cho nhân viên có mã 9001 (đã tạo ở bài trước). Kiểm tra số dòng bị ảnh hưởng bằng `SQL%ROWCOUNT`.

<div style="display: none;">

```sql
DECLARE
    v_empno EMP.EMPNO%TYPE := 9001;
BEGIN
    UPDATE EMP
    SET SAL = SAL * 1.1
    WHERE EMPNO = v_empno;
    
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Đã cập nhật ' || SQL%ROWCOUNT || ' dòng.');
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy nhân viên ' || v_empno);
    END IF;
END;
```

</div>

**Bài 25**. Xóa nhân viên 9001 và thông báo xóa thành công hay không dùng `SQL%FOUND`.

<div style="display: none;">

```sql
DECLARE
    v_empno EMP.EMPNO%TYPE := 9001;
BEGIN
    DELETE FROM EMP
    WHERE EMPNO = v_empno;
    
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Đã xóa nhân viên ' || v_empno || ' thành công.');
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy nhân viên ' || v_empno || ' để xóa.');
    END IF;
END;
```

</div>

**Bài 26**. Sử dụng biến PL/SQL trong câu lệnh INSERT: khai báo biến cho EMPNO, ENAME, SAL, DEPTNO và thêm nhân viên mới.

<div style="display: none;">

```sql
DECLARE
    v_empno  EMP.EMPNO%TYPE := 9002;
    v_ename  EMP.ENAME%TYPE := 'NGUYEN VAN Y';
    v_job    EMP.JOB%TYPE   := 'MANAGER';
    v_sal    EMP.SAL%TYPE   := 2000;
    v_deptno EMP.DEPTNO%TYPE := 30;
BEGIN
    INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
    VALUES (v_empno, v_ename, v_job, v_sal, v_deptno);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Đã chèn nhân viên ' || v_empno || ' - ' || v_ename);
END;
```

</div>

**Bài 27**. Cập nhật lương cho nhân viên bằng biến: khai báo `v_empno` và `v_new_sal`, thực hiện UPDATE và commit.

<div style="display: none;">

```sql
DECLARE
    v_empno   EMP.EMPNO%TYPE := 9002;
    v_new_sal EMP.SAL%TYPE   := 2500;
BEGIN
    UPDATE EMP
    SET SAL = v_new_sal
    WHERE EMPNO = v_empno;
    
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Đã cập nhật lương cho nhân viên ' || v_empno || ' thành ' || v_new_sal);
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Không tìm thấy nhân viên ' || v_empno);
    END IF;
END;
```

</div>

**Bài 28**. Thực hiện DELETE tất cả nhân viên thuộc phòng 99 (không có), dùng `SQL%NOTFOUND` để thông báo không có dòng nào bị xóa.

<div style="display: none;">

```sql
DECLARE
    v_deptno EMP.DEPTNO%TYPE := 99;
BEGIN
    DELETE FROM EMP
    WHERE DEPTNO = v_deptno;
    
    IF SQL%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('Không có nhân viên nào thuộc phòng ' || v_deptno);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Đã xóa ' || SQL%ROWCOUNT || ' nhân viên thuộc phòng ' || v_deptno);
        COMMIT;
    END IF;
END;
```

</div>

**Bài 29**. Viết khối PL/SQL chèn một nhân viên, sau đó cập nhật lương của nhân viên đó, rồi xóa nhân viên đó, tất cả trong một transaction. Sau đó rollback để hủy toàn bộ.

<div style="display: none;">

```sql
DECLARE
    v_empno  EMP.EMPNO%TYPE := 9003;
    v_ename  EMP.ENAME%TYPE := 'TEMP USER';
    v_job    EMP.JOB%TYPE   := 'CLERK';
    v_sal    EMP.SAL%TYPE   := 1000;
    v_deptno EMP.DEPTNO%TYPE := 10;
BEGIN
    -- Chèn
    INSERT INTO EMP (EMPNO, ENAME, JOB, SAL, DEPTNO)
    VALUES (v_empno, v_ename, v_job, v_sal, v_deptno);
    
    -- Cập nhật tăng 20%
    UPDATE EMP
    SET SAL = SAL * 1.2
    WHERE EMPNO = v_empno;
    
    -- Xóa
    DELETE FROM EMP
    WHERE EMPNO = v_empno;
    
    DBMS_OUTPUT.PUT_LINE('Đã thực hiện các thao tác trên nhân viên ' || v_empno);
    DBMS_OUTPUT.PUT_LINE('Rollback để hủy tất cả.');
    
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Đã rollback, các thay đổi bị hủy.');
END;
```

</div>

**Bài 30**. Sử dụng `SELECT INTO` lấy tổng số nhân viên (hàm `COUNT`) vào biến và in ra.

<div style="display: none;">

```sql
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM EMP;
    
    DBMS_OUTPUT.PUT_LINE('Tổng số nhân viên: ' || v_count);
END;
```

</div>

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
