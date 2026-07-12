## Bài tập thực hành – Chương 2. Ngôn ngữ SQL

### Truy vấn cơ bản (SELECT)

1. Hiển thị tất cả thông tin nhân viên
2. Hiển thị tên và lượng của tất cả nhân viên
3. Hiển thị tên, chức vụ và ngày vào làm của nhân viên
4. Hiển thị mã nhân viên, tên và lượng sắp xếp theo lượng giảm dần
5. Hiển thị tên và lượng của nhân viên có lượng > 2000
6. Hiển thị tên và chức vụ của nhân viên có chức vụ là 'MANAGER'
7. Hiển thị tên và ngày vào làm của nhân viên gia nhập năm 1981

### Hàm thống kê (Aggregate Functions)

8. Tính tổng lượng của toàn công ty
9. Tính lượng trung bình của nhân viên
10. Tìm lượng cao nhất và thấp nhất
11. Đếm tổng số nhân viên
12. Đếm số nhân viên có hoa hồng (COMM không NULL)
13. Tính tổng lượng theo từng phòng ban
14. Tính lượng trung bình theo chức vụ

### Truy vấn có điều kiện (WHERE)

15. Hiển thị nhân viên có lượng từ 1500 đến 3000
16. Hiển thị nhân viên thuộc phòng 10 hoặc 20
17. Hiển thị nhân viên không có người quản lý (MGR IS NULL)
18. Hiển thị nhân viên có tên bắt đầu bằng chữ ‘S’
19. Hiển thị nhân viên có tên chứa chữ ‘A’ ở vị trí thứ 2
20. Hiển thị nhân viên vào làm trong tháng 12

### JOIN và Subquery

21. Hiển thị tên nhân viên và tên phòng ban tương ứng
22. Hiển thị tên nhân viên, tên người quản lý của họ
23. Hiển thị nhân viên có lương cao hơn lương trung bình
24. Hiển thị nhân viên có lương cao nhất trong phòng
25. Hiển thị nhân viên có lương cao hơn lương của nhân viên ‘SMITH’
26. Hiển thị phòng ban không có nhân viên
27. Hiển thị nhân viên và tên phòng của họ, sắp xếp theo tên phòng
28. Hiển thị tên nhân viên, tên phòng và địa điểm làm việc

### Nhóm dữ liệu (GROUP BY)

29. Đếm số nhân viên theo từng phòng ban
30. Tính tổng lượng và lượng trung bình theo phòng ban
31. Hiển thị phòng ban có nhiều hơn 3 nhân viên
32. Tính tổng lượng theo chức vụ
33. Hiển thị chức vụ có lượng trung bình > 2000
34. Đếm số nhân viên theo từng năm gia nhập

### Xử lý NULL và Hàm điều kiện

35. Hiển thị tên, lượng và hoa hồng (nếu NULL thì hiển thị 0)
36. Tính tổng thu nhập (SAL + COMM) của mỗi nhân viên
37. Phân loại nhân viên: ‘Cao’ nếu SAL > 2500, ‘Trung bình’ nếu 1500-2500, ‘Thấp’ nếu < 1500
38. Hiển thị tên và thâm niên (số năm làm việc)
39. Hiển thị tên và số tháng làm việc
40. Tăng lượng 10% cho tất cả nhân viên (chỉ hiển thị, không UPDATE)

### Truy vấn nâng cao

41. Hiển thị top 3 nhân viên có lương cao nhất
42. Hiển thị nhân viên có lương cao thứ 2
43. Hiển thị nhân viên có cùng chức vụ với ‘SMITH’
44. Hiển thị nhân viên vào làm cùng năm với ‘KING’
45. Tìm nhân viên không có ai dưới quyền (không quản lý ai)
46. Hiển thị cấp bậc quản lý: nhân viên → quản lý → quản lý cấp cao
47. Hiển thị danh sách nhân viên và cấp bậc của họ trong công ty

### DML (INSERT, UPDATE, DELETE)

48. Thêm một phòng ban mới: DEPTNO=50, DNAME=‘MARKETING’, LOC=‘BOSTON’
49. Thêm một nhân viên mới với thông tin tùy chọn
50. Tăng lượng 15% cho nhân viên phòng 20
51. Giảm lượng 5% cho nhân viên có lượng > 3000
52. Xóa nhân viên có mã 9999 (nếu có)
53. Cập nhật địa điểm của phòng 30 thành ‘SAN FRANCISCO’
54. Cập nhật người quản lý cho nhân viên không có quản lý

### VIEW và INDEX

55. Tạo view hiển thị thông tin nhân viên và phòng ban
56. Tạo view thống kê lượng theo phòng
57. Tạo index trên cột ENAME để tăng tốc tìm kiếm
58. Tạo index composite trên DEPTNO và JOB
59. Tạo view hiển thị nhân viên có lượng cao hơn trung bình

### Bài tập tổng hợp

60. Tạo báo cáo tổng hợp: Phòng ban, Số nhân viên, Tổng lượng, Lượng TB, Lượng cao nhất
61. Hiển thị nhân viên và tổng số người dưới quyền (nếu là quản lý)
62. Tìm người quản lý có nhiều nhân viên nhất
63. Phân tích cơ cấu nhân viên theo chức vụ và phòng ban
64. Tính phần trăm lượng của mỗi nhân viên so với tổng lượng phòng
65. Tìm nhân viên có lượng cao hơn lượng trung bình của phòng họ
66. Hiển thị lịch sử thay đổi lượng (giả sử có bảng SALARY_HISTORY)
67. Tìm nhân viên vào làm trong 5 ngày liên tiếp (nếu có dữ liệu)
68. Phân tích xu hướng tuyển dụng theo quý
69. Tìm nhân viên có thâm niên > 10 năm nhưng lượng < trung bình
70. Đề xuất tăng lượng: +20% cho người có thâm niên > 15 năm, +10% cho > 10 năm
