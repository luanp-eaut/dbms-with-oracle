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