## Bài tập thực hành – Chương 3. Lập trình PL/SQL

### Khối lệnh cơ bản & Biến

1. Viết một khối PL/SQL ấn danh in ra _"Xin chào PL/SQL!"_.
2. Viết khối PL/SQL khai báo một biến kiểu VARCHAR2 và gán giá trị _"Oracle"_, sau đó in ra.
3. Khai báo 2 biến NUMBER, gán giá trị và tính tổng, hiệu, tích, thương của chúng.
4. Sử dụng biến thay thế để nhập mã nhân viên từ người dùng, in ra tên và lượng của nhân viên đó.
5. Viết khối PL/SQL khai báo hằng số PI = 3.14, tính diện tích hình tròn với bán kính nhập từ người dùng.
6. Sử dụng %TYPE để khai báo biến lưu tên nhân viên từ bảng EMP.
7. Sử dụng %ROWTYPE để lưu toàn bộ thông tin một nhân viên.
8. Viết khối PL/SQL tính lượng trung bình của toàn bộ nhân viên.
9. In ra số lượng nhân viên trong phòng số 10.
10. Kiểm tra nếu lượng nhân viên > 3000 thì in _"Lượng cao"_, ngược lại in _"Lượng thấp"_.

### Cấu trúc điều khiển (IF, CASE, LOOP)

11. Viết khối PL/SQL kiểm tra nếu nhân viên có lượng > 5000 thì thưởng 1000, ngược lại thưởng 500.
12. Sử dụng IF ELSIF ELSE để phân loại nhân viên theo lượng:
13. Sử dụng CASE để in ra tên chức vụ (JOB) dựa trên mã chức vụ trong bảng EMP.
14. Sử dụng CASE tìm kiếm để phân loại nhân viên theo thâm niên (HIREDATE).
15. Sử dụng vòng lặp LOOP và EXIT WHEN để in ra các số từ 1 đến 10.
16. Sử dụng WHILE LOOP để in ra các số chẵn từ 2 đến 20.
17. Sử dụng FOR LOOP để in ra tên các nhân viên trong bảng EMP.
18. Dùng FOR LOOP REVERSE để in số từ 10 về 1.
19. Sử dụng GOTO để nhảy đến một nhãn khi điều kiện đúng.
20. Sử dụng NULL trong khối EXCEPTION để bỏ qua lỗi.

### Sử dụng SQL trong PL/SQL

21. Viết khối PL/SQL chèn một nhân viên mới vào bảng EMP.
22. Cập nhật lượng của nhân viên có mã 7369 tăng 10%.
23. Xóa một nhân viên có mã nhập từ bàn phím.
24. Sử dụng SELECT INTO để lấy thông tin nhân viên có mã 7499.
25. Sử dụng SQL%ROWCOUNT để in ra số dòng bị ảnh hưởng sau khi UPDATE.
26. Sử dụng SQL%FOUND và SQL%NOTFOUND để kiểm tra xem UPDATE có thành công không.
27. Viết khối PL/SQL sử dụng subquery để tìm nhân viên có lượng cao nhất.
28. Sử dụng correlated subquery để tìm nhân viên có lượng cao nhất trong từng phòng.
29. Sử dụng EXISTS để kiểm tra phòng ban có nhân viên hay không.
30. Sử dụng BETWEEN để tìm nhân viên có lượng từ 2000 đến 4000.

### Con trỏ (Cursor)

31. Viết con trỏ tường minh để duyệt và in ra danh sách nhân viên.
32. Sử dụng con trỏ với vòng lặp LOOP và FETCH.
33. Sử dụng CURSOR FOR LOOP để in ra danh sách phòng ban.
34. Viết con trỏ có tham số để tìm nhân viên theo mã phòng.
35. Sử dụng con trỏ để cập nhật lượng nhân viên theo điều kiện.
36. Viết con trỏ để tính tổng lượng của từng phòng.
37. Sử dụng %ROWTYPE với con trỏ để lưu thông tin một dòng.
38. Xử lý ngoại lệ NO_DATA_FOUND khi dùng con trỏ.
39. Đóng con trỏ sau khi sử dụng xong.
40. Kiểm tra %ISOPEN trước khi đóng con trỏ.

### Hàm (Function)

41. Viết hàm tính thuế thu nhập (10% lương nếu lương > 3000).
42. Viết hàm tính thưởng cuối năm (2 tháng lương nếu thâm niên > 5 năm).
43. Viết hàm trả về tên phòng ban dựa trên mã phòng.
44. Viết hàm kiểm tra nhân viên có tồn tại không (trả về TRUE/FALSE).
45. Sử dụng hàm trong câu lệnh SELECT để tính lương sau thuế.
46. Viết hàm tính tổng lương của một phòng.
47. Viết hàm trả về số lượng nhân viên theo chức vụ.
48. Viết hàm trả về ngày gia nhập gần nhất của một phòng.
49. Sử dụng hàm trong mệnh đề WHERE.
50. Xử lý ngoại lệ trong hàm (VD: chia cho 0).

### Thủ tục (Procedure)

51. Viết thủ tục in ra danh sách nhân viên của một phòng.
52. Viết thủ tục tăng lương cho toàn bộ nhân viên theo % nhập vào.
53. Viết thủ tục thêm mới một phòng ban.
54. Viết thủ tục xóa nhân viên theo mã và in ra số dòng bị xóa.
55. Thủ tục có tham số OUT để trả về tổng lương của một phòng.
56. Thủ tục có tham số IN OUT để cập nhật lương nhân viên.
57. Sử dụng CREATE OR REPLACE để sửa thủ tục.
58. Gọi thủ tục từ một khối PL/SQL khác.
59. Thủ tục sử dụng con trỏ để trả về danh sách nhân viên.
60. Thủ tục ghi log khi thêm/xóa nhân viên.

### Package & Quản lý lỗi

61. Tạo package chứa các hàm/thủ tục quản lý nhân viên.
62. Package chứa con trỏ và hàm tính toán liên quan đến phòng ban.
63. Sử dụng RAISE_APPLICATION_ERROR để báo lỗi tùy chỉnh.
64. Xử lý ngoại lệ TOO_MANY_ROWS trong SELECT INTO.
65. Sử dụng WHEN OTHERS để ghi log lỗi vào bảng.
66. Tạo bảng log lỗi và trigger ghi log khi có lỗi.
67. Sử dụng PRAGMA EXCEPTION_INIT để gán mã lỗi ngoại lệ do người dùng định nghĩa.
68. Viết hàm kiểm tra ràng buộc (VD: lương không âm).
69. Tạo procedure để backup dữ liệu EMP trước khi xóa.
70. Tạo job định kỳ (DBMS_SCHEDULER) để ghi log hàng ngày.

### Trigger

71. Viết trigger BEFORE INSERT để tự động sinh mã nhân viên.
72. Trigger AFTER UPDATE để ghi log thay đổi lương.
73. Trigger BEFORE DELETE để ngăn xóa nhân viên có thâm niên > 10 năm.
74. Trigger cấp dòng (ROW LEVEL) để tính lại tổng lương phòng khi có thay đổi.
75. Trigger cấp câu lệnh (STATEMENT LEVEL) để đếm số lần UPDATE bảng EMP.
76. Sử dụng :OLD và :NEW để kiểm tra lương không giảm.
77. Trigger INSTEAD OF để cho phép INSERT qua view.
78. Trigger DDL để ghi log khi có thay đổi cấu trúc bảng.
79. Trigger DATABASE (LOGON) để ghi lại thời gian đăng nhập.
80. Vô hiệu hóa/kích hoạt trigger.
