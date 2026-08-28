-- Tăng lương cho nhân viên theo mã và tỷ lệ phần trăm

create or replace procedure increase_salary (
   p_empno   in emp.empno%type,
   p_percent in number
) is
   v_old_sal emp.sal%type;
   v_new_sal emp.sal%type;
begin
   -- Lấy lương hiện tại
   select sal
     into v_old_sal
     from emp
    where empno = p_empno
   for update; -- Khóa dòng

   -- Tính lương mới
   v_new_sal := v_old_sal * ( 1 + p_percent / 100 );

   -- Cập nhật
   update emp
      set
      sal = v_new_sal
    where empno = p_empno;

   commit;
   dbms_output.put_line('Cập nhật lương cho '
                        || p_empno
                        || ' từ '
                        || v_old_sal
                        || ' lên ' || v_new_sal);
exception
   when no_data_found then
      dbms_output.put_line('Không tìm thấy nhân viên có mã ' || p_empno);
   when others then
      rollback;
      dbms_output.put_line('Lỗi: ' || sqlerrm);
end increase_salary;
/

select *
  from emp
 where empno = 7369;

exec increase_salary(7369, 10);

commit;

-- Quản lý nhân viên
create or replace package emp_manager is
   -- Biến public (có thể sử dụng từ bên ngoài)
   g_dept_id number := 10;

   -- Hằng số
   c_max_salary constant number := 100000;

   -- Exception public
   e_sal_too_high exception;

   -- Procedure public
   procedure add_employee (
      p_empno  in emp.empno%type,
      p_ename  in emp.ename%type,
      p_sal    in emp.sal%type default 1000,
      p_deptno in emp.deptno%type default 10
   );
   procedure update_salary (
      p_empno   in emp.empno%type,
      p_new_sal in emp.sal%type
   );

-- Function public
   function get_annual_income (
      p_empno in emp.empno%type
   ) return number;

end emp_manager;
/

create or replace package body emp_manager is
   -- Biến private (chỉ dùng trong package)
   v_last_updated date;

   -- Hàm private
   function is_valid_empno (
      p_empno in emp.empno%type
   ) return boolean is
      v_count number;
   begin
      select count(*)
        into v_count
        from emp
       where empno = p_empno;
      return v_count > 0;
   end is_valid_empno;

   -- Cài đặt procedure add_employee
   procedure add_employee (
      p_empno  in emp.empno%type,
      p_ename  in emp.ename%type,
      p_sal    in emp.sal%type default 1000,
      p_deptno in emp.deptno%type default 10
   ) is
   begin
      if p_sal > c_max_salary then
         raise e_sal_too_high;
      end if;
      insert into emp (
         empno,
         ename,
         sal,
         deptno
      ) values
         ( p_empno,
           p_ename,
           p_sal,
           p_deptno );
      v_last_updated := sysdate;
      commit;
      dbms_output.put_line('Đã thêm nhân viên: ' || p_ename);
   end add_employee;

   -- Cài đặt update_salary
   procedure update_salary (
      p_empno   in emp.empno%type,
      p_new_sal in emp.sal%type
   ) is
   begin
      update emp
         set
         sal = p_new_sal
       where empno = p_empno;
      if sql%notfound then
         dbms_output.put_line('Không tìm thấy nhân viên ' || p_empno);
      else
         v_last_updated := sysdate;
         commit;
      end if;
   end update_salary;

-- Cài đặt get_annual_income
   function get_annual_income (
      p_empno in emp.empno%type
   ) return number is
      v_sal  emp.sal%type;
      v_comm emp.comm%type;
   begin
      select sal,
             nvl(
                comm,
                0
             )
        into
         v_sal,
         v_comm
        from emp
       where empno = p_empno;
      return ( v_sal + v_comm ) * 12;
   exception
      when no_data_found then
         return null;
   end get_annual_income;

begin
-- Phần khởi tạo (initialization) - chạy khi package được nạp lần đầu
   v_last_updated := sysdate;
   dbms_output.put_line('Package EMP_MANAGER được khởi tạo lúc: ' || v_last_updated);
end emp_manager;
/