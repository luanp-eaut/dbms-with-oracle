## Bài tập thực hành chương 3

---

### PHẦN 1 – KHỐI PL/SQL, BIẾN, HẰNG, KIỂU DỮ LIỆU

**Bài 1**. Viết một khối PL/SQL ẩn danh in ra dòng chữ: _"Chào mừng đến với PL/SQL"_. Sử dụng `DBMS_OUTPUT`.

<div style="display: block;">

```sql
BEGIN
    DBMS_OUTPUT.PUT_LINE('Chào mừng đến với PL/SQL');
END;
```

</div>

**Bài 2**. Khai báo một biến `v_empno` kiểu `NUMBER(4)` và gán giá trị 7369. Dùng `SELECT INTO` để lấy tên nhân viên (`ENAME`) và lương (`SAL`) vào hai biến, sau đó in ra.

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

```sql
DECLARE
    v_name EMP.ENAME%TYPE := 'KING';
BEGIN
    DBMS_OUTPUT.PUT_LINE('Tên nhân viên: ' || v_name);
END;
```

</div>

**Bài 5**. Sử dụng `%ROWTYPE` để khai báo biến record `v_emp` lưu toàn bộ dòng của bảng EMP cho nhân viên 7900. In ra `EMPNO`, `ENAME`, `SAL`.

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

```sql
BEGIN
    FOR i IN REVERSE 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
```

</div>

**Bài 19**. Sử dụng `EXIT WHEN` trong vòng lặp `LOOP` để tính tổng các số chẵn từ 1 đến 50, dừng khi tổng vượt quá 500.

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

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

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_emp IS SELECT empno, ename, sal FROM emp;
    v_empno emp.empno%TYPE;
    v_ename emp.ename%TYPE;
    v_sal   emp.sal%TYPE;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_empno, v_ename, v_sal;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('MSNV: ' || v_empno || ' - Ten: ' || v_ename || ' - Luong: ' || v_sal);
    END LOOP;
    CLOSE c_emp;
END;
/
```

</div>

**Bài 32**. Sử dụng `%ROWTYPE` của cursor để lấy toàn bộ dòng trong cursor (truy vấn `SELECT *`). In ra các cột.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_emp IS SELECT * FROM emp;
    v_emp_rec c_emp%ROWTYPE;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_emp_rec;
        EXIT WHEN c_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('NV: ' || v_emp_rec.ename || ', Job: ' || v_emp_rec.job || ', Sal: ' || v_emp_rec.sal);
    END LOOP;
    CLOSE c_emp;
END;
/
```

</div>

**Bài 33**. Sử dụng `CURSOR FOR LOOP` để duyệt qua tất cả nhân viên và in `ENAME`, `JOB`.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
BEGIN
    FOR r_emp IN (SELECT ename, job FROM emp) LOOP
        DBMS_OUTPUT.PUT_LINE(r_emp.ename || ' - ' || r_emp.job);
    END LOOP;
END;
/
```

</div>

**Bài 34**. Viết cursor có tham số `p_deptno` để lấy nhân viên theo phòng. Gọi cursor cho phòng 20 và 30.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_emp(p_dept NUMBER) IS 
        SELECT ename, sal FROM emp WHERE deptno = p_dept;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Phong 20 ---');
    FOR r IN c_emp(20) LOOP
        DBMS_OUTPUT.PUT_LINE(r.ename || ': ' || r.sal);
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('--- Phong 30 ---');
    FOR r IN c_emp(30) LOOP
        DBMS_OUTPUT.PUT_LINE(r.ename || ': ' || r.sal);
    END LOOP;
END;
/
```

</div>

**Bài 35**. Viết cursor có tham số `p_min_sal` để lấy nhân viên có lương lớn hơn mức đó. Gọi với `p_min_sal = 2000`.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_emp(p_min NUMBER) IS 
        SELECT ename, sal FROM emp WHERE sal > p_min;
BEGIN
    FOR r IN c_emp(2000) LOOP
        DBMS_OUTPUT.PUT_LINE(r.ename || ' - Luong: ' || r.sal);
    END LOOP;
END;
/
```

</div>

**Bài 36**. Sử dụng thuộc tính `%ROWCOUNT` sau khi duyệt cursor để in ra tổng số nhân viên đã fetch.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_emp IS SELECT ename FROM emp;
    v_dummy emp.ename%TYPE;
BEGIN
    OPEN c_emp;
    LOOP
        FETCH c_emp INTO v_dummy;
        EXIT WHEN c_emp%NOTFOUND;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Tong so nhan vien da fetch: ' || c_emp%ROWCOUNT);
    CLOSE c_emp;
END;
/
```

</div>

**Bài 37**. Khai báo cursor với `FOR UPDATE OF sal` để khóa cột lương. Duyệt cursor và tăng lương 10% cho từng nhân viên, sử dụng `WHERE CURRENT OF`.

<div style="display: block;">

```sql
DECLARE
    CURSOR c_emp IS SELECT empno, sal FROM emp FOR UPDATE OF sal;
BEGIN
    FOR r IN c_emp LOOP
        UPDATE emp SET sal = sal * 1.1 WHERE CURRENT OF c_emp;
    END LOOP;
    COMMIT; -- Commit để lưu thay đổi (hoặc ROLLBACK nếu chỉ test)
    ROLLBACK; -- Lệnh này để hoàn tác lại dữ liệu mẫu sau khi chạy thử
END;
/
```

</div>

**Bài 38**. Sử dụng cursor `FOR UPDATE` (không chỉ định cột) và `DELETE WHERE CURRENT OF` để xóa nhân viên có lương < 1000 (nếu có).

<div style="display: block;">

```sql
DECLARE
    CURSOR c_emp IS SELECT * FROM emp WHERE sal < 1000 FOR UPDATE;
BEGIN
    FOR r IN c_emp LOOP
        DELETE FROM emp WHERE CURRENT OF c_emp;
        DBMS_OUTPUT.PUT_LINE('Da xoa: ' || r.ename);
    END LOOP;
    COMMIT; 
    ROLLBACK; -- Hoàn tác
END;
/
```

</div>

**Bài 39**. Viết cursor tham số với giá trị mặc định (DEFAULT) và gọi mà không truyền tham số.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_emp(p_sal NUMBER DEFAULT 3000) IS 
        SELECT ename FROM emp WHERE sal > p_sal;
BEGIN
    -- Gọi không truyền tham số, sẽ lấy mặc định 3000
    FOR r IN c_emp LOOP 
        DBMS_OUTPUT.PUT_LINE(r.ename);
    END LOOP;
END;
/
```

</div>

**Bài 40**. Sử dụng cursor để cập nhật cột `COMM` = 500 cho các nhân viên có `JOB = 'SALESMAN'` (dùng `FOR UPDATE` và `WHERE CURRENT OF`).

<div style="display: block;">

```sql
DECLARE
    CURSOR c_sales IS SELECT * FROM emp WHERE job = 'SALESMAN' FOR UPDATE OF comm;
BEGIN
    FOR r IN c_sales LOOP
        UPDATE emp SET comm = 500 WHERE CURRENT OF c_sales;
    END LOOP;
    COMMIT;
    ROLLBACK;
END;
/
```

</div>

---

### PHẦN 5 – EXCEPTION HANDLING

**Bài 41**. Viết khối `SELECT INTO` lấy tên nhân viên với mã không tồn tại (9999). Bắt ngoại lệ `NO_DATA_FOUND` và in thông báo.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_name emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_name FROM emp WHERE empno = 9999;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Khong tim thay nhan vien voi ma 9999.');
END;
/
```

</div>

**Bài 42**. Viết khối thực hiện phép chia 100/0. Bắt `ZERO_DIVIDE` và in thông báo lỗi.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_res NUMBER;
BEGIN
    v_res := 100 / 0;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Khong the chia cho 0!');
END;
/
```

</div>

**Bài 43**. Thử chèn một nhân viên có `EMPNO` trùng với khóa chính (ví dụ 7369). Bắt `DUP_VAL_ON_INDEX` và xử lý.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
BEGIN
    INSERT INTO emp (empno, ename, job) VALUES (7369, 'TEST', 'CLERK');
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Ma nhan vien 7369 da ton tai (Trung khoa chinh).');
END;
/
```

</div>

**Bài 44**. Khai báo ngoại lệ tự tạo `e_high_salary`. Trong khối, lấy lương của 7788, nếu > 5000 thì `RAISE e_high_salary` và bắt ngoại lệ đó.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_sal emp.sal%TYPE;
    e_high_salary EXCEPTION;
BEGIN
    SELECT sal INTO v_sal FROM emp WHERE empno = 7788;
    IF v_sal > 5000 THEN
        RAISE e_high_salary;
    END IF;
    DBMS_OUTPUT.PUT_LINE('Luong hop le: ' || v_sal);
EXCEPTION
    WHEN e_high_salary THEN
        DBMS_OUTPUT.PUT_LINE('Loi: Luong qua cao (> 5000)!');
END;
/
```

</div>

**Bài 45**. Sử dụng `RAISE_APPLICATION_ERROR` với mã -20001 và thông báo _"Lương không được âm"_ khi phát hiện lương < 0 (giả sử lấy từ bảng).

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_sal emp.sal%TYPE;
BEGIN
    SELECT sal INTO v_sal FROM emp WHERE empno = 7369;
    IF v_sal < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Lương không được âm');
    END IF;
    DBMS_OUTPUT.PUT_LINE('Luong: ' || v_sal);
END;
/
```

</div>

**Bài 46**. Kết hợp `RAISE` và `RAISE_APPLICATION_ERROR`: bắt ngoại lệ tự tạo, sau đó ném lại bằng `RAISE_APPLICATION_ERROR` với mã tùy chỉnh.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    e_custom EXCEPTION;
BEGIN
    IF 1 = 1 THEN -- Giả sử điều kiện lỗi
        RAISE e_custom;
    END IF;
EXCEPTION
    WHEN e_custom THEN
        RAISE_APPLICATION_ERROR(-20002, 'Phat hien loi nghiem trong: ' || SQLERRM);
END;
/
```

</div>

**Bài 47**. Viết khối có ngoại lệ `WHEN OTHERS` để bắt tất cả lỗi và in ra `SQLERRM`.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    v_res NUMBER;
BEGIN
    v_res := 10 / 0;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ma loi: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('Chi tiet: ' || SQLERRM);
END;
/
```

</div>

**Bài 48**. Sử dụng `PRAGMA EXCEPTION_INIT` để gán tên cho một lỗi Oracle cụ thể (ví dụ ORA-01403) và bắt nó.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    e_no_data EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_no_data, -1403); -- ORA-01403: no data found
    v_name emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_name FROM emp WHERE empno = 9999;
EXCEPTION
    WHEN e_no_data THEN
        DBMS_OUTPUT.PUT_LINE('Bat loi ORA-01403 bang PRAGMA EXCEPTION_INIT!');
END;
/
```

</div>

**Bài 49**. Viết khối lồng nhau (khối cha và khối con). Trong khối con, ném ngoại lệ `NO_DATA_FOUND` và không xử lý, để nó lan truyền lên khối cha và bắt ở đó.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
BEGIN -- Khối cha
    DBMS_OUTPUT.PUT_LINE('Bat dau khoi cha...');
    BEGIN -- Khối con
        DECLARE
            v_name emp.ename%TYPE;
        BEGIN
            SELECT ename INTO v_name FROM emp WHERE empno = 9999;
        END;
    END;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Khoi cha bat duoc NO_DATA_FOUND tu khoi con!');
END;
/
```

</div>

**Bài 50**. Trong khối PL/SQL, cập nhật lương của nhân viên 7788. Nếu có lỗi, rollback; nếu thành công, commit. Sử dụng `EXCEPTION` để rollback khi có lỗi.

<div style="display: block;">

```sql
BEGIN
    UPDATE emp SET sal = sal + 10 WHERE empno = 7788;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cap nhat thanh cong!');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Co loi, da rollback: ' || SQLERRM);
END;
/
```

</div>

---

### PHẦN 6 – PROCEDURE, FUNCTION, PACKAGE, TRIGGER

**Bài 51**. Tạo một stored procedure đơn giản `proc_hello` in ra "Hello from Procedure". Gọi procedure đó.

<div style="display: block;">

```sql
CREATE OR REPLACE PROCEDURE proc_hello IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello from Procedure');
END;
/
-- Goi procedure
EXEC proc_hello;
```

</div>

**Bài 52**. Tạo procedure `increase_salary` nhận `p_empno` và `p_percent`, tăng lương theo tỷ lệ và commit. Xử lý ngoại lệ nếu không tìm thấy nhân viên.

<div style="display: block;">

```sql
CREATE OR REPLACE PROCEDURE increase_salary(p_empno NUMBER, p_percent NUMBER) IS
    e_not_found EXCEPTION;
BEGIN
    UPDATE emp SET sal = sal * (1 + p_percent/100) WHERE empno = p_empno;
    IF SQL%NOTFOUND THEN
        RAISE e_not_found;
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Da tang luong cho NV ' || p_empno);
EXCEPTION
    WHEN e_not_found THEN
        DBMS_OUTPUT.PUT_LINE('Khong tim thay nhan vien ' || p_empno);
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM);
END;
/
EXEC increase_salary(7788, 10);
```

</div>

**Bài 53**. Tạo procedure `get_emp_info` có tham số `IN` là `p_empno` và ba tham số `OUT` là `p_ename`, `p_sal`, `p_deptno`. Gọi và in ra kết quả.

<div style="display: block;">

```sql
CREATE OR REPLACE PROCEDURE get_emp_info(
    p_empno IN NUMBER, 
    p_ename OUT VARCHAR2, 
    p_sal OUT NUMBER, 
    p_deptno OUT NUMBER
) IS
BEGIN
    SELECT ename, sal, deptno INTO p_ename, p_sal, p_deptno 
    FROM emp WHERE empno = p_empno;
END;
/

-- Goi va in ket qua
SET SERVEROUTPUT ON;
DECLARE
    v_name VARCHAR2(50); v_sal NUMBER; v_dept NUMBER;
BEGIN
    get_emp_info(7788, v_name, v_sal, v_dept);
    DBMS_OUTPUT.PUT_LINE('Ten: ' || v_name || ', Luong: ' || v_sal || ', Phong: ' || v_dept);
END;
/
```

</div>

**Bài 54**. Tạo procedure `swap_numbers` có hai tham số `IN OUT` để hoán đổi giá trị của hai số. Gọi và kiểm tra.

<div style="display: block;">

```sql
CREATE OR REPLACE PROCEDURE swap_numbers(p1 IN OUT NUMBER, p2 IN OUT NUMBER) IS
    v_temp NUMBER;
BEGIN
    v_temp := p1;
    p1 := p2;
    p2 := v_temp;
END;
/

SET SERVEROUTPUT ON;
DECLARE
    a NUMBER := 10; b NUMBER := 20;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Truoc: a=' || a || ', b=' || b);
    swap_numbers(a, b);
    DBMS_OUTPUT.PUT_LINE('Sau: a=' || a || ', b=' || b);
END;
/
```

</div>

**Bài 55**. Tạo function `calc_annual_salary` nhận `p_empno`, trả về lương năm (lương \*12 + hoa hồng). Sử dụng function trong câu lệnh SELECT.

<div style="display: block;">

```sql
CREATE OR REPLACE FUNCTION calc_annual_salary(p_empno NUMBER) RETURN NUMBER IS
    v_annual NUMBER;
BEGIN
    SELECT (sal * 12) + NVL(comm, 0) INTO v_annual FROM emp WHERE empno = p_empno;
    RETURN v_annual;
END;
/
-- Su dung trong SELECT
SELECT empno, ename, calc_annual_salary(empno) AS annual_sal FROM emp WHERE empno = 7788;
```

</div>

**Bài 56**. Tạo function `get_dept_name` nhận `p_deptno` trả về tên phòng. Nếu không có thì trả về NULL. Gọi trong SELECT.

<div style="display: block;">

```sql
CREATE OR REPLACE FUNCTION get_dept_name(p_deptno NUMBER) RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname FROM dept WHERE deptno = p_deptno;
    RETURN v_dname;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RETURN NULL;
END;
/
SELECT empno, ename, get_dept_name(deptno) AS dept_name FROM emp;
```

</div>

**Bài 57**. Tạo package `emp_pkg` với spec có: biến public `g_default_dept` (NUMBER), procedure `add_emp`, function `get_annual`. Cài đặt package body.

<div style="display: block;">

```sql
-- Spec
CREATE OR REPLACE PACKAGE emp_pkg IS
    g_default_dept NUMBER := 10;
    PROCEDURE add_emp(p_empno NUMBER, p_ename VARCHAR2, p_sal NUMBER);
    FUNCTION get_annual(p_empno NUMBER) RETURN NUMBER;
END emp_pkg;
/

-- Body
CREATE OR REPLACE PACKAGE BODY emp_pkg IS
    PROCEDURE add_emp(p_empno NUMBER, p_ename VARCHAR2, p_sal NUMBER) IS
    BEGIN
        INSERT INTO emp(empno, ename, sal, deptno) VALUES(p_empno, p_ename, p_sal, g_default_dept);
        COMMIT;
    END;
    
    FUNCTION get_annual(p_empno NUMBER) RETURN NUMBER IS
        v_annual NUMBER;
    BEGIN
        SELECT (sal*12) + NVL(comm,0) INTO v_annual FROM emp WHERE empno = p_empno;
        RETURN v_annual;
    END;
END emp_pkg;
/

```

</div>

**Bài 58**. Sử dụng package ở bài 57, gọi procedure thêm nhân viên và function tính lương năm.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
BEGIN
    emp_pkg.add_emp(9999, 'NEWGUY', 2000);
    DBMS_OUTPUT.PUT_LINE('Luong nam: ' || emp_pkg.get_annual(9999));
    ROLLBACK; -- Huy insert de gi nguyen du lieu mau
END;
/
```

</div>

**Bài 59**. Tạo trigger `trg_before_insert_emp` tự động chuyển `ENAME` thành chữ hoa, gán `HIREDATE` = SYSDATE nếu NULL khi INSERT. Kiểm tra.

<div style="display: block;">

```sql
CREATE OR REPLACE TRIGGER trg_before_insert_emp
BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
    :NEW.ename := UPPER(:NEW.ename);
    IF :NEW.hiredate IS NULL THEN
        :NEW.hiredate := SYSDATE;
    END IF;
END;
/
-- Kiem tra: INSERT INTO emp(empno, ename, job) VALUES (8888, 'test user', 'CLERK');
```

</div>

**Bài 60**. Tạo trigger `trg_after_delete_emp` ghi log vào bảng `emp_audit` (tạo sẵn) với thông tin nhân viên bị xóa. Xóa một nhân viên và kiểm tra log.

<div style="display: block;">

```sql
-- Bảng lưu log khi xóa nhân viên
CREATE TABLE emp_audit (
    audit_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    empno NUMBER,
    ename VARCHAR2(50),
    action VARCHAR2(50),
    action_date DATE DEFAULT SYSDATE
);

CREATE OR REPLACE TRIGGER trg_after_delete_emp
AFTER DELETE ON emp
FOR EACH ROW
BEGIN
    INSERT INTO emp_audit(empno, ename, action) 
    VALUES (:OLD.empno, :OLD.ename, 'DELETED');
END;
/
-- Xoa thu va kiem tra: DELETE FROM emp WHERE empno = 9999; SELECT * FROM emp_audit;
```

</div>

---

### PHẦN 7 – BÀI TẬP TỔNG HỢP (TÍCH HỢP DDL, DML, PL/SQL, CURSOR, EXCEPTION, PROCEDURE, FUNCTION, TRIGGER)

**Bài 61. Cập nhật lương hàng loạt với cursor**  
Viết procedure `bulk_salary_update` sử dụng cursor để tăng lương 5% cho tất cả nhân viên phòng 30, đồng thời cập nhật cột `COMM` = 200 cho các nhân viên đó. Xử lý ngoại lệ và commit.

<div style="display: block;">

```sql
CREATE OR REPLACE PROCEDURE bulk_salary_update IS
    CURSOR c_emp IS SELECT empno FROM emp WHERE deptno = 30 FOR UPDATE;
BEGIN
    FOR r IN c_emp LOOP
        UPDATE emp SET sal = sal * 1.05, comm = 200 WHERE CURRENT OF c_emp;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Da cap nhat luong cho phong 30');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM);
END;
/
```

</div>

**Bài 62. Kiểm tra ràng buộc bằng trigger**  
Tạo trigger `trg_check_sal` trước khi UPDATE hoặc INSERT trên EMP, ngăn chặn việc đặt `SAL` < 500. Dùng `RAISE_APPLICATION_ERROR`.

<div style="display: block;">

```sql
CREATE OR REPLACE TRIGGER trg_check_sal
BEFORE INSERT OR UPDATE OF sal ON emp
FOR EACH ROW
BEGIN
    IF :NEW.sal < 500 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Muc luong toi thieu phai la 500');
    END IF;
END;
/
```

</div>

**Bài 63. Hàm tính lương thực nhận**  
Tạo function `net_salary` nhận `p_empno`, tính lương sau thuế (giả sử thuế 10% trên lương, nếu lương > 3000). Sử dụng trong SELECT.

<div style="display: block;">

```sql
CREATE OR REPLACE FUNCTION net_salary(p_empno NUMBER) RETURN NUMBER IS
    v_sal emp.sal%TYPE;
BEGIN
    SELECT sal INTO v_sal FROM emp WHERE empno = p_empno;
    IF v_sal > 3000 THEN
        RETURN v_sal * 0.9; -- Giam 10% thue
    ELSE
        RETURN v_sal;
    END IF;
END;
/
SELECT ename, sal, net_salary(empno) AS net_sal FROM emp;
```

</div>

**Bài 64. Package quản lý nhân viên**  
Xây dựng package `hr_admin` với:

- Procedure `fire_emp(p_empno)` xóa nhân viên và ghi log vào bảng `emp_audit`.
- Function `count_emp(p_deptno)` trả về số nhân viên thuộc phòng.
- Trigger tự động cập nhật số lượng khi thêm/xóa.

<div style="display: block;">

```sql
-- Bảng lưu log khi xóa nhân viên
CREATE TABLE emp_audit (
    audit_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    empno NUMBER,
    ename VARCHAR2(50),
    action VARCHAR2(50),
    action_date DATE DEFAULT SYSDATE
);

ALTER TABLE dept ADD emp_count NUMBER DEFAULT 0;
UPDATE dept d SET emp_count = (SELECT COUNT(*) FROM emp e WHERE e.deptno = d.deptno);

CREATE OR REPLACE PACKAGE hr_admin IS
    PROCEDURE fire_emp(p_empno NUMBER);
    FUNCTION count_emp(p_deptno NUMBER) RETURN NUMBER;
END hr_admin;
/
CREATE OR REPLACE PACKAGE BODY hr_admin IS
    PROCEDURE fire_emp(p_empno NUMBER) IS
        v_ename emp.ename%TYPE;
    BEGIN
        SELECT ename INTO v_ename FROM emp WHERE empno = p_empno;
        INSERT INTO emp_audit(empno, ename, action) VALUES(p_empno, v_ename, 'FIRED');
        DELETE FROM emp WHERE empno = p_empno;
        COMMIT;
    END;
    
    FUNCTION count_emp(p_deptno NUMBER) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM emp WHERE deptno = p_deptno;
        RETURN v_count;
    END;
END hr_admin;
/

-- Trigger tu dong cap nhat so luong
CREATE OR REPLACE TRIGGER trg_update_emp_count
AFTER INSERT OR DELETE ON emp
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE dept SET emp_count = NVL(emp_count, 0) + 1 WHERE deptno = :NEW.deptno;
    ELSIF DELETING THEN
        UPDATE dept SET emp_count = NVL(emp_count, 1) - 1 WHERE deptno = :OLD.deptno;
    END IF;
END;
/
```

</div>

**Bài 65. Giao dịch chuyển phòng ban**  
Viết procedure `transfer_dept` nhận `p_empno`, `p_new_deptno`, thực hiện:

- Kiểm tra nhân viên tồn tại.
- Kiểm tra phòng mới tồn tại.
- Cập nhật DEPTNO.
- Ghi log vào bảng `emp_transfer_log` (tạo sẵn).
- Nếu có lỗi, rollback.

<div style="display: block;">

```sql
-- Bảng lưu log chuyển phòng ban
CREATE TABLE emp_transfer_log (
    log_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    empno NUMBER,
    old_deptno NUMBER,
    new_deptno NUMBER,
    transfer_date DATE DEFAULT SYSDATE
);

CREATE OR REPLACE PROCEDURE transfer_dept(p_empno NUMBER, p_new_deptno NUMBER) IS
    v_old_dept emp.deptno%TYPE;
    e_emp_not_found EXCEPTION;
    e_dept_not_found EXCEPTION;
BEGIN
    -- Kiem tra NV
    SELECT deptno INTO v_old_dept FROM emp WHERE empno = p_empno;
    -- Kiem tra Phong
    DECLARE v_dummy NUMBER;
    BEGIN
        SELECT 1 INTO v_dummy FROM dept WHERE deptno = p_new_deptno;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN RAISE e_dept_not_found;
    END;
    
    UPDATE emp SET deptno = p_new_deptno WHERE empno = p_empno;
    INSERT INTO emp_transfer_log(empno, old_deptno, new_deptno) 
    VALUES (p_empno, v_old_dept, p_new_deptno);
    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN RAISE e_emp_not_found;
    WHEN e_emp_not_found THEN
        ROLLBACK; DBMS_OUTPUT.PUT_LINE('Khong tim thay NV');
    WHEN e_dept_not_found THEN
        ROLLBACK; DBMS_OUTPUT.PUT_LINE('Khong tim thay Phong moi');
    WHEN OTHERS THEN
        ROLLBACK; DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM);
END;
/
```

</div>

**Bài 66. Sử dụng cursor tham số và exception**  
Viết procedure `print_emp_by_dept(p_deptno)` dùng cursor có tham số để in danh sách nhân viên. Nếu phòng không có nhân viên, thông báo "Phòng trống".

<div style="display: block;">

```sql
CREATE OR REPLACE PROCEDURE print_emp_by_dept(p_deptno NUMBER) IS
    CURSOR c_emp IS SELECT ename FROM emp WHERE deptno = p_deptno;
    v_count NUMBER := 0;
BEGIN
    FOR r IN c_emp LOOP
        DBMS_OUTPUT.PUT_LINE(' - ' || r.ename);
        v_count := v_count + 1;
    END LOOP;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Phong trong');
    END IF;
END;
/
EXEC print_emp_by_dept(99); -- Phong khong ton tai / trong
```

</div>

**Bài 67. Trigger ngăn chặn giảm lương**  
Tạo trigger `trg_no_sal_decrease` trên EMP, chỉ cho phép UPDATE SAL nếu giá trị mới >= giá trị cũ. Nếu vi phạm, báo lỗi.

<div style="display: block;">

```sql
CREATE OR REPLACE TRIGGER trg_no_sal_decrease
BEFORE UPDATE OF sal ON emp
FOR EACH ROW
BEGIN
    IF :NEW.sal < :OLD.sal THEN
        RAISE_APPLICATION_ERROR(-20004, 'Khong duoc phep giam luong nhan vien');
    END IF;
END;
/
```

</div>

**Bài 68. Tự động sinh mã nhân viên**  
Tạo sequence `seq_empno` bắt đầu 9000. Tạo trigger BEFORE INSERT trên EMP để tự động gán `EMPNO` từ sequence nếu `:NEW.EMPNO` là NULL. Kiểm tra bằng cách INSERT không có EMPNO.

<div style="display: block;">

```sql
CREATE SEQUENCE seq_empno START WITH 9000 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_auto_empno
BEFORE INSERT ON emp
FOR EACH ROW
BEGIN
    IF :NEW.empno IS NULL THEN
        :NEW.empno := seq_empno.NEXTVAL;
    END IF;
END;
/
-- Kiem tra: INSERT INTO emp(ename, job, sal, deptno) VALUES ('AUTOUSER', 'CLERK', 1500, 10);
```

</div>

**Bài 69. Procedure thêm dự án và phân công**  
Viết procedure `add_project_assignment` nhận thông tin dự án (PROJ_ID, PROJ_NAME, ...) và phân công nhân viên (EMPNO, ROLE, HOURS_WEEK) vào dự án đó. Nếu dự án đã tồn tại thì chỉ thêm phân công. Sử dụng transaction và rollback nếu lỗi.

<div style="display: block;">

```sql

-- Bảng Dự án và Phân công
CREATE TABLE project (
    proj_id NUMBER PRIMARY KEY,
    proj_name VARCHAR2(100)
);
CREATE TABLE project_assignment (
    assign_id NUMBER GENERATED BY DEFAULT AS IDENTITY,
    proj_id NUMBER REFERENCES project(proj_id),
    empno NUMBER,
    role VARCHAR2(50),
    hours_week NUMBER
);

CREATE OR REPLACE PROCEDURE add_project_assignment(
    p_proj_id NUMBER, p_proj_name VARCHAR2,
    p_empno NUMBER, p_role VARCHAR2, p_hours NUMBER
) IS
    v_proj_exists NUMBER;
BEGIN
    -- Kiem tra du an, neu chua co thi them
    SELECT COUNT(*) INTO v_proj_exists FROM project WHERE proj_id = p_proj_id;
    IF v_proj_exists = 0 THEN
        INSERT INTO project(proj_id, proj_name) VALUES (p_proj_id, p_proj_name);
    END IF;
    
    -- Phan cong
    INSERT INTO project_assignment(proj_id, empno, role, hours_week)
    VALUES (p_proj_id, p_empno, p_role, p_hours);
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM);
END;
/
```

</div>

**Bài 70. Báo cáo tổng hợp bằng PL/SQL**  
Viết một khối PL/SQL sử dụng cursor để lấy danh sách các phòng ban, và với mỗi phòng, lấy danh sách nhân viên. In ra báo cáo dạng:

```
Phòng ACCOUNTING (10)
- KING: 5000
- CLARK: 2450
Tổng lương phòng: ...
```

Xử lý ngoại lệ khi không có dữ liệu.

<div style="display: block;">

```sql
SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_dept IS SELECT deptno, dname FROM dept ORDER BY deptno;
    CURSOR c_emp(p_deptno NUMBER) IS 
        SELECT ename, sal FROM emp WHERE deptno = p_deptno ORDER BY ename;
    
    v_total_sal NUMBER;
    v_has_emp BOOLEAN;
BEGIN
    FOR r_dept IN c_dept LOOP
        DBMS_OUTPUT.PUT_LINE('Phong ' || r_dept.dname || ' (' || r_dept.deptno || ')');
        v_total_sal := 0;
        v_has_emp := FALSE;
        
        FOR r_emp IN c_emp(r_dept.deptno) LOOP
            DBMS_OUTPUT.PUT_LINE('- ' || r_emp.ename || ': ' || r_emp.sal);
            v_total_sal := v_total_sal + r_emp.sal;
            v_has_emp := TRUE;
        END LOOP;
        
        IF v_has_emp THEN
            DBMS_OUTPUT.PUT_LINE('Tong luong phong: ' || v_total_sal);
        ELSE
            DBMS_OUTPUT.PUT_LINE('(Khong co nhan vien)');
        END IF;
        DBMS_OUTPUT.PUT_LINE('------------------------');
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Khong co du lieu phong ban.');
END;
/
```

</div>
