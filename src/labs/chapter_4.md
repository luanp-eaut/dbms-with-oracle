## Bài tập thực hành – Chương 4. Kiến trúc, quản trị Oracle DBMS

### Kiến trúc & Cấu hình Instance

1. Viết lệnh khởi động instance ở trạng thái NOMOUNT, sau đó chuyển sang MOUNT, rồi OPEN.
2. Viết lệnh tạo spfile từ pfile hiện có, rồi khởi động lại instance dùng spfile mới.
3. Truy vấn V$SGA, V$SGASTAT và V$PGASTAT để lấy tổng kích thước SGA, PGA, và kích thước Shared Pool.
4. Thay đổi giá trị PGA_AGGREGATE_TARGET thành 512M bằng lệnh ALTER SYSTEM, rồi kiểm tra lại qua view V$PARAMETER.
5. Bật tính năng In-Memory Column Store: đặt INMEMORY_SIZE = 256M, rồi khởi động lại CDB.
6. Tạo một common user tên C##ADMIN với quyền CREATE SESSION và CREATE PLUGGABLE DATABASE.
7. Tạo một PDB mới tên PDB_APP từ PDB$SEED, sau đó mở PDB này.
8. Liệt kê tất cả PDB trong CDB, kèm trạng thái, bằng một truy vấn trên V$PDBS.
9. Kết nối vào PDB_APP, sau đó tạo một local user tên APP_USER với mật khẩu app123.
10. Kiểm tra danh sách các tiến trình nền bắt buộc đang chạy bằng truy vấn: SELECT name FROM v$bgprocess WHERE paddr != '00'.
11. Truy vấn V$DIAG_INFO để lấy đường dẫn tới file alert log, rồi dùng SQL\*Plus host command đọc 20 dòng cuối của file này.
12. Kiểm tra xem shared server có đang bật không: truy vấn V$DISPATCHER và V$SHARED_SERVER. Nếu chưa, bật 2 dispatcher và 3 shared server.
13. Cấp quyền SYSDBA cho user C##ADMIN bằng lệnh GRANT.
14. Viết lệnh SHUTDOWN IMMEDIATE, sau đó STARTUP RESTRICT để đưa CDB vào chế độ giới hạn.
15. Truy vấn V$VERSION và V$INSTANCE để lấy phiên bản Oracle và trạng thái instance.

### Quản lý Tablespace & File

16. Tạo tablespace APP_DATA với một data file app_data01.dbf, kích thước 200M, AUTOEXTEND ON NEXT 50M MAXSIZE 1G.
17. Thêm một data file thứ hai app_data02.dbf (kích thước 300M) vào tablespace APP_DATA.
18. Tăng kích thước data file app_data01.dbf lên 500M.
19. Bật OMF: đặt DB_CREATE_FILE_DEST = '/u01/oradata', rồi tạo tablespace OMF_TS.
20. Tạo bigfile tablespace BIG_TS với block size 8K, kích thước 5G.
21. Kiểm tra tất cả tablespace trong CDB qua DBA_TABLESPACES, lọc chỉ hiện tên và loại (BIGFILE/SMALLFILE).
22. Đặt tablespace APP_DATA ở chế độ offline, rồi đưa trở lại online.
23. Chuyển tablespace APP_DATA sang chế độ READ ONLY, sau đó lại chuyển về READ WRITE.
24. Tạo tablespace IDX_TS để chứa index, với extent quản lý cục bộ, uniform size 128K.
25. Tạo UNDO tablespace UNDOTBS2, rồi đặt làm undo tablespace mặc định cho CDB.
26. Tạo TEMP tablespace TEMP_APP, rồi gán làm tablespace tạm cho user APP_USER.
27. Gán quota 100M cho APP_USER trên APP_DATA, sau đó gán UNLIMITED TABLESPACE.
28. Viết truy vấn tổng hợp: với mỗi tablespace, hiển thị tổng dung lượng, dung lượng đã dùng, % sử dụng — từ DBA_DATA_FILES, DBA_FREE_SPACE.
29. Tạo bảng APP_USER.T1 (id NUMBER) trong tablespace APP_DATA.
30. Di chuyển bảng APP_USER.T1 sang tablespace USERS.
31. Xóa tablespace APP_DATA kèm toàn bộ nội dung và data file vật lý.
32. Kiểm tra metadata của bảng APP_USER.T1: tablespace chứa, số extent, số block — qua DBA_TABLES, DBA_SEGMENTS, DBA_EXTENTS.
33. Tạo bảng APP_USER.LOG_TBL (ts DATE, msg VARCHAR2(200)) với PCTFREE 20.
34. Thay đổi PCTFREE của LOG_TBL thành 10 bằng lệnh ALTER TABLE ... MOVE.
35. Viết lệnh ALTER SYSTEM CHECKPOINT rồi kiểm tra V$LOG để xem trạng thái các redo log group.
36. Truy vấn V$CONTROLFILE để lấy danh sách đường dẫn control file.
37. Truy vấn V$LOGFILE để liệt kê các redo log member.
38. Tạo private temporary table (nếu hỗ trợ) tên ORA$PTT_TMP_TBL, với ON COMMIT PRESERVE DEFINITION.
39. Tạo global temporary table TMP_SESSION_LOG (sess_id NUMBER, act_time DATE) với ON COMMIT PRESERVE ROWS.
40. Chèn 3 dòng vào TMP_SESSION_LOG, COMMIT, rồi kiểm tra dữ liệu còn tồn tại không.

### Tạo & Quản lý Schema Objects

41. Tạo index IDX_T1_ID trên cột id của bảng APP_USER.T1.
42. Tạo function-based index IDX_LOG_UPPER_MSG trên UPPER(msg) của LOG_TBL.
43. Tạo bitmap index IDX_LOG_HOUR trên TO_CHAR(ts, 'HH24') của LOG_TBL.
44. Rebuild index IDX_T1_ID online.
45. Xóa index IDX_T1_ID.
46. Tạo view V_T1 cho phép xem id từ T1, với điều kiện id > 0.
47. Thay đổi view V_T1 để bổ sung cột ROWNUM bằng CREATE OR REPLACE VIEW.
48. Xóa view V_T1.
49. Tạo public synonym TBL1 cho APP_USER.T1.
50. Xóa synonym TBL1.
51. Tạo sequence SEQ_T1 với START WITH 1, INCREMENT BY 1, CACHE 20, NOCYCLE.
52. Lấy NEXTVAL từ SEQ_T1 hai lần, sau đó lấy CURRVAL.
53. Thay đổi sequence SEQ_T1 để INCREMENT BY 5.
54. Xóa sequence SEQ_T1.
55. Tạo materialized view MV_T1_COUNT refresh complete on demand, chứa SELECT COUNT(\*) cnt FROM T1.
56. Làm mới materialized view MV_T1_COUNT bằng gói DBMS_MVIEW.REFRESH.
57. Tạo procedure PRC_LOG chèn một dòng vào LOG_TBL, có tham số p_msg IN VARCHAR2.
58. Thực thi procedure PRC_LOG('Test from PRC_LOG') bằng lệnh EXEC.
59. Tạo function F_GET_COUNT trả về COUNT(\*) từ T1.
60. Gọi function F_GET_COUNT() trong một SELECT.
61. Tạo package PKG_LOG gồm spec và body, chứa procedure LOG_MSG(p_msg VARCHAR2).
62. Gọi PKG_LOG.LOG_MSG('Package test').
63. Tạo trigger TRG_T1_BI trước khi INSERT vào T1, tự động gán :NEW.id := SEQ_T1.NEXTVAL.
64. Chèn một dòng vào T1 (không chỉ định id) và kiểm tra giá trị id được sinh.
65. Tạo database link tên REMOTE_DB kết nối tới remote_user/remote_pass@remote_tns.
66. Dùng database link để SELECT COUNT(\*) FROM DUAL@REMOTE_DB.
67. Tạo type ADDR_TYP như object gồm street VARCHAR2(50), city VARCHAR2(30).
68. Tạo bảng PEOPLE (name VARCHAR2(30), addr ADDR_TYP).
69. Chèn một dòng vào PEOPLE với addr = ADDR_TYP('123 Main', 'HCM').
70. Tạo bảng có partition range theo cột ts (kiểu DATE), với 2 partition: p2024, p2025.
71. Chèn dòng vào LOG_TBL với ts = DATE '2024-12-01', sau đó kiểm tra qua USER_TAB_PARTITIONS.
72. Tạo bảng COMP_TBL với COMPRESS BASIC, chèn 10.000 dòng từ ALL_OBJECTS, rồi so sánh BYTES trong USER_SEGMENTS.
73. Tạo directory EXT_DIR trỏ tới /tmp, rồi tạo external table EXT_LOG đọc file CSV /tmp/log.csv.
74. Truy vấn SELECT COUNT(\*) FROM EXT_LOG.
75. Viết script PL/SQL anonymous block: loop từ 1 đến 1000, chèn vào T1 dùng SEQ_T1.NEXTVAL.

### Quản trị Người dùng & Bảo mật

76. Tạo user DEV_USER với mật khẩu dev123, tablespace mặc định USERS, tạm TEMP.
77. Cấp quyền CREATE SESSION, CREATE TABLE cho DEV_USER.
78. Cấp quyền SELECT, INSERT trên APP_USER.T1 cho DEV_USER.
79. Cấp quyền SELECT ON APP_USER.T1 cho DEV_USER kèm WITH GRANT OPTION.
80. Tạo role APP_ROLE, cấp CREATE SESSION, CREATE VIEW, rồi gán role này cho DEV_USER.
81. Đặt APP_ROLE là default role cho DEV_USER.
82. Tạo profile SEC_PROF với PASSWORD_LIFE_TIME = 90, FAILED_LOGIN_ATTEMPTS = 3, PASSWORD_LOCK_TIME = 1.
83. Gán profile SEC_PROF cho DEV_USER.
84. Khóa tài khoản DEV_USER, sau đó mở lại.
85. Cho DEV_USER quyền UNLIMITED TABLESPACE.
86. Thu hồi quyền CREATE TABLE từ DEV_USER.
87. Thu hồi toàn bộ role từ DEV_USER.
88. Xóa role APP_ROLE.
89. Xóa user DEV_USER kèm toàn bộ đối tượng sở hữu.
90. Tạo user OPS$ORACLE xác thực qua OS (IDENTIFIED EXTERNALLY).
91. Tạo user LDAP_USER xác thực toàn cầu (IDENTIFIED GLOBALLY AS 'cn=ldap,dc=example').
92. Cấp role DBA cho C##ADMIN.
93. Cấp role SELECT_CATALOG_ROLE cho APP_USER.
94. Cho APP_USER quota 50M trên APP_DATA, 0 trên USERS.
95. Kiểm tra toàn bộ quyền hệ thống của APP_USER qua DBA_SYS_PRIVS.
96. Kiểm tra toàn bộ quyền đối tượng của APP_USER qua DBA_TAB_PRIVS.
97. Kiểm tra toàn bộ role được gán cho APP_USER qua DBA_ROLE_PRIVS.
98. Kiểm tra trạng thái tài khoản APP_USER (LOCKED, EXPIRED) qua DBA_USERS.
99. Thiết lập proxy: cho phép DEV_USER kết nối thay mặt APP_USER bằng ALTER USER APP_USER GRANT CONNECT THROUGH DEV_USER.
100.  Bật audit cho các lần đăng nhập thất bại: AUDIT CREATE SESSION WHENEVER NOT SUCCESSFUL.
