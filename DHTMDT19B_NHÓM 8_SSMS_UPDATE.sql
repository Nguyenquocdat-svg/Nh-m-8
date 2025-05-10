CREATE DATABASE QLBV
GO

USE QLBV
GO

CREATE TABLE BENHVIEN (
	MABV VARCHAR(10) PRIMARY KEY,
	TENBN NVARCHAR(100) NOT NULL )
GO 

CREATE TABLE NHANVIEN (
    MANV VARCHAR(10) PRIMARY KEY,
    TENNV NVARCHAR(100) NOT NULL )
GO

CREATE TABLE KHUCHUATRI (
    MAKHU VARCHAR(10) PRIMARY KEY,
    TENKHU NVARCHAR(100) NOT NULL,
    MAYTATRUONG VARCHAR(10) REFERENCES NHANVIEN(MANV),
	MABV VARCHAR(10) REFERENCES BENHVIEN(MABV) )
GO

CREATE TABLE BACSI (
    MABS VARCHAR(10) PRIMARY KEY,
    TENBS NVARCHAR(100) NOT NULL,
	MABV VARCHAR(10) REFERENCES BENHVIEN(MABV) )
GO

CREATE TABLE BENHNHAN (
    MABN VARCHAR(10) PRIMARY KEY,
    TENBN NVARCHAR(100) NOT NULL,
    NGAYSINH DATE NOT NULL,
    LOAIBN NVARCHAR(20) NOT NULL CHECK (LOAIBN IN (N'Nội trú', N'Ngoại trú')),
    MABS VARCHAR(10) NULL REFERENCES BACSI(MABS) )
GO

CREATE TABLE GIUONG (
    MAGIUONG VARCHAR(10) PRIMARY KEY,
    SOPHONG INT NOT NULL,
    MAKHU VARCHAR(10) NOT NULL REFERENCES KHUCHUATRI(MAKHU),
    MABN VARCHAR(10) NULL REFERENCES BENHNHAN(MABN) )
GO

CREATE TABLE VATTU (
    MAVT VARCHAR(10) PRIMARY KEY,
    DACTA NVARCHAR(200) NOT NULL,
    DONGIA MONEY NOT NULL, 
	TONGSOLUONG INT NOT NULL,
	MABV VARCHAR(10) REFERENCES BENHVIEN(MABV) )
GO

CREATE TABLE HOSOBENHAN (
    MAHOSO VARCHAR(10) PRIMARY KEY,
    TENBENH NVARCHAR(100),
    NGAYCT DATE,
    THOIGIANCT TIME,
	PPDIEUTRI NVARCHAR(200),
	LAN INT,
    KETQUA NVARCHAR(255),
    MABN VARCHAR(10),
    MAVT VARCHAR(10),
    MABS VARCHAR(10),
    FOREIGN KEY (MABN) REFERENCES BENHNHAN(MABN),
	FOREIGN KEY (MAVT) REFERENCES VATTU(MAVT),
    FOREIGN KEY (MABS) REFERENCES BACSI(MABS) )
GO

CREATE TABLE LAMVIEC (
    MANV VARCHAR(10),
    MAKHU VARCHAR(10),
    SOGIOLV INT,
    PRIMARY KEY (MANV, MAKHU),
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
    FOREIGN KEY (MAKHU) REFERENCES KHUCHUATRI(MAKHU) )
GO

CREATE TABLE SUDUNGVATTU (
    MABN VARCHAR(10),
    MAVT VARCHAR(10),
    NGAY DATE,
    THOIGIAN TIME,
    SOLUONG INT,
    PRIMARY KEY (MABN, MAVT, NGAY, THOIGIAN),
    FOREIGN KEY (MABN) REFERENCES BENHNHAN(MABN),
    FOREIGN KEY (MAVT) REFERENCES VATTU(MAVT) )
GO

CREATE VIEW HD_VATTU AS
SELECT MABN, sdvt.MAVT, NGAY, THOIGIAN, SOLUONG, (SOLUONG * DONGIA) AS TONGTIEN
FROM SUDUNGVATTU sdvt
JOIN VATTU vt ON sdvt.MAVT = vt.MAVT
GO

INSERT INTO BENHVIEN VALUES
	('BVDK01', 'Bệnh viện đa khoa Phú Mỹ')

INSERT INTO NHANVIEN VALUES
	('NV01', N'Nguyễn Thị Lan Anh'),
	('NV02', N'Trần Văn Hùng'),
	('NV03', N'Lê Thị Hồng'),
	('NV04', N'Phạm Văn Nam'),
	('NV05', N'Hoàng Thị Mai'),
	('NV06', N'Nguyễn Văn Tùng'),
	('NV07', N'Trần Thị Ngọc'),
	('NV08', N'Lê Văn Khánh'),
	('NV09', N'Phạm Thị Thu Hiền'),
	('NV10', N'Hoàng Văn Đức'),
	('NV11', N'Nguyễn Văn Phong'),
	('NV12', N'Trần Thị Quyên'),
	('NV13', N'Lê Văn Sơn'),
	('NV14', N'Phạm Thị Thu Thảo'),
	('NV15', N'Hoàng Văn Minh')
GO

INSERT INTO KHUCHUATRI VALUES
	('K01', N'Khu Nội khoa', 'NV01', 'BVDK01'),
	('K02', N'Khu Ngoại khoa', 'NV05', 'BVDK01'),
	('K03', N'Khu Sơ sinh', 'NV03', 'BVDK01'),
	('K04', N'Khu Cấp cứu', 'NV14', 'BVDK01'),
	('K05', N'Khu Phục hồi', 'NV10', 'BVDK01'),
	('K06', N'Khu Nhiễm', 'NV07', 'BVDK01'),
	('K07', N'Khu Nhi khoa', 'NV12', 'BVDK01')
GO

INSERT INTO BACSI VALUES
	('BS01', N'Nguyễn Văn Xuyên', 'BVDK01'),
	('BS02', N'Trần Thị Yến', 'BVDK01'),
	('BS03', N'Lê Văn Dương', 'BVDK01'),
	('BS04', N'Phạm Thị Vượng', 'BVDK01'),
	('BS05', N'Hoàng Văn Vỹ', 'BVDK01'),
	('BS06', N'Nguyễn Thị Như Quỳnh', 'BVDK01'),
	('BS07', N'Trần Văn Khoa', 'BVDK01'),
	('BS08', N'Lê Minh', 'BVDK01'),
	('BS09', N'Phạm Văn Long', 'BVDK01'),
	('BS10', N'Trần Hoàng Như Ngọc', 'BVDK01')
GO

INSERT INTO BENHNHAN VALUES
	('BN01', N'Nguyễn Văn An', '1980-05-10', N'Nội trú', 'BS01'),
	('BN02', N'Trần Thị Bình', '1985-08-15', N'Ngoại trú', 'BS01'),
	('BN03', N'Trần Lê Cường', '1995-03-20', N'Nội trú', 'BS01'),
	('BN04', N'Phạm Thị Hạnh Dung', '1980-12-25', N'Nội trú', 'BS02'),
	('BN05', N'Văn Mai Linh', '1992-07-30', N'Ngoại trú', 'BS02'),
	('BN06', N'Nguyễn Thị Hoa', '2001-01-15', N'Nội trú', 'BS03'),
	('BN07', N'Trần Quang Khải', '2002-06-20', N'Ngoại trú', 'BS03'),
	('BN08', N'Trần Thị Lan', '2003-09-10', N'Nội trú', 'BS04'),
	('BN09', N'Phạm Văn Minh', '2004-11-25', N'Nội trú', 'BS04'),
	('BN10', N'Hoàng Thị Nga', '2005-03-30', N'Ngoại trú', 'BS05'),
	('BN11', N'Nguyễn Văn Phong', '1998-04-12', N'Nội trú', 'BS05'),
	('BN12', N'Trần Thị Tố Quyên', '1996-07-18', N'Ngoại trú', 'BS06'),
	('BN13', N'Lê Tuấn Vũ', '1993-02-22', N'Nội trú', 'BS07'),
	('BN14', N'Phạm Thùy Nhiên', '1988-10-05', N'Nội trú', 'BS08'),
	('BN15', N'Lê Trung Tín', '1990-12-15', N'Ngoại trú', 'BS09')
GO

INSERT INTO GIUONG VALUES
	('G01', 101, 'K01', 'BN01'),
	('G02', 102, 'K01', 'BN03'),
	('G03', 201, 'K02', 'BN04'),
	('G04', 202, 'K02', NULL),
	('G05', 301, 'K03', NULL),
	('G06', 302, 'K03', 'BN06'),
	('G07', 401, 'K04', NULL),
	('G08', 402, 'K04', 'BN08'),
	('G09', 501, 'K05', 'BN09'),
	('G10', 601, 'K06', NULL),
	('G11', 701, 'K07', 'BN11'),
	('G12', 801, 'K07', 'BN13'),
	('G13', 802, 'K07', 'BN14')
GO

INSERT INTO VATTU VALUES
    ('VT01', N'Thuốc Paracetamol', 5000, 150, 'BVDK01'),
    ('VT02', N'Băng gạc y tế', 2000, 300, 'BVDK01'),
    ('VT03', N'Kim tiêm', 1000, 500, 'BVDK01'),
    ('VT04', N'Thuốc kháng sinh Amoxicillin', 10000, 100, 'BVDK01'),
    ('VT05', N'Nước muối sinh lý', 3000, 250, 'BVDK01'),
    ('VT06', N'Thuốc giảm đau Ibuprofen', 8000, 180, 'BVDK01'),
    ('VT07', N'Ống tiêm 5ml', 1500, 400, 'BVDK01'),
    ('VT08', N'Thuốc hạ sốt Efferalgan', 6000, 160, 'BVDK01'),
    ('VT09', N'Máy đo huyết áp', 500000, 20, 'BVDK01'),
    ('VT10', N'Thuốc kháng viêm Diclofenac', 12000, 140, 'BVDK01'),
    ('VT11', N'Thuốc tiêu hóa Domperidone', 7000, 130, 'BVDK01'),
    ('VT12', N'Thuốc chống dị ứng Loratadine', 6000, 110, 'BVDK01'),
    ('VT13', N'Thuốc huyết áp Amlodipine', 15000, 90, 'BVDK01'),
    ('VT14', N'Thuốc ho Codein', 5000, 170, 'BVDK01'),
    ('VT15', N'Thuốc dạ dày Omeprazole', 10000, 125, 'BVDK01')
GO

INSERT INTO HOSOBENHAN VALUES
	('HS01', N'Huyết áp cao', '2025-04-01', '08:30', N'Theo dõi huyết áp, dùng thuốc hạ áp', 1, N'Đã xuất viện', 'BN01', 'VT01', 'BS01'),
	('HS02', N'Viêm họng', '2025-04-02', '10:00', N'Súc miệng nước muối, uống kháng sinh', 1, N'Tiến triển tốt', 'BN02', 'VT02', 'BS01'),
	('HS03', N'Huyết áp cao', '2025-04-03', '09:15', N'Duy trì thuốc hạ áp, nghỉ ngơi', 1, N'Đang theo dõi', 'BN03', 'VT01', 'BS01'),
	('HS04', N'Nhiễm khuẩn đường ruột', '2025-04-01', '07:50', N'Uống kháng sinh, bù nước', 1, N'Cần theo dõi thêm', 'BN04', 'VT04', 'BS02'),
	('HS05', N'Suy nhược cơ thể', '2025-04-04', '11:00', N'Bổ sung vitamin, chế độ ăn giàu dinh dưỡng', 1, N'Đã xuất viện', 'BN05', 'VT05', 'BS02'),
	('HS06', N'Sốt cao', '2025-04-05', '09:00', N'Uống thuốc hạ sốt, chườm mát thường xuyên', 1, N'Đã xuất viện', 'BN06', 'VT06', 'BS03'),
	('HS07', N'Viêm da dị ứng', '2025-04-06', '10:30', N'Dùng thuốc kháng histamin và thuốc bôi ngoài da', 1, N'Tiến triển tốt', 'BN07', 'VT07', 'BS03'),
	('HS08', N'Viêm phổi nhẹ', '2025-04-07', '14:00', N'Kháng sinh, nghỉ ngơi, theo dõi hô hấp', 1, N'Tiến triển tốt', 'BN08', 'VT04', 'BS04'),
	('HS09', N'Huyết áp cao', '2025-04-08', '11:15', N'Uống thuốc theo toa, theo dõi huyết áp định kỳ', 1, N'Đã xuất viện', 'BN09', 'VT10', 'BS04'),
	('HS10', N'Đau đầu do stress', '2025-04-09', '08:30', N'Thư giãn, dùng thuốc giảm đau khi cần', 2, N'Đã xuất viện', 'BN10', 'VT06', 'BS05'),
	('HS11', N'Huyết áp cao', '2025-04-10', '09:45', N'Thay đổi lối sống, dùng thuốc hạ áp', 1, N'Đã xuất viện', 'BN11', 'VT11', 'BS05'),
	('HS12', N'Đau dạ dày', '2025-04-11', '10:00', N'Uống thuốc giảm tiết acid, ăn uống điều độ', 2, N'Cần theo dõi thêm', 'BN12', 'VT13', 'BS06'),
	('HS13', N'Huyết áp cao', '2025-04-12', '08:15', N'Uống thuốc hạ áp, theo dõi thường xuyên', 1, N'Đã xuất viện', 'BN13', 'VT12', 'BS07'),
	('HS14', N'Viêm xoang', '2025-04-13', '09:30', N'Xịt mũi kháng viêm, dùng thuốc kháng sinh', 1, N'Tiến triển tốt', 'BN14', 'VT14', 'BS08'),
	('HS15', N'Đau dạ dày', '2025-04-14', '09:00', N'Chế độ ăn hợp lý, thuốc giảm đau dạ dày', 1, N'Cần theo dõi thêm', 'BN15', 'VT15', 'BS09')
GO

INSERT INTO LAMVIEC VALUES
	('NV01', 'K01', 40),
	('NV02', 'K02', 35),
	('NV03', 'K03', 42),
	('NV04', 'K04', 30),
	('NV05', 'K05', 38),
    ('NV06', 'K06', 36),
    ('NV07', 'K07', 40),
    ('NV08', 'K01', 38),
    ('NV09', 'K02', 35),
    ('NV10', 'K03', 42),
    ('NV11', 'K04', 30),
    ('NV12', 'K05', 38),
    ('NV13', 'K06', 36),
    ('NV14', 'K07', 40),
    ('NV15', 'K01', 38)
GO

INSERT INTO SUDUNGVATTU VALUES
    ('BN01', 'VT01', '2025-04-01', '08:30', 1), 
    ('BN06', 'VT06', '2025-04-05', '09:00', 2), 
    ('BN02', 'VT02', '2025-04-02', '10:00', 2), 
    ('BN04', 'VT04', '2025-04-01', '07:50', 5),
    ('BN05', 'VT05', '2025-04-04', '11:00', 2),
    ('BN07', 'VT07', '2025-04-06', '10:30', 5), 
    ('BN09', 'VT10', '2025-04-08', '11:15', 1), 
    ('BN12', 'VT13', '2025-04-11', '10:00', 1),
    ('BN15', 'VT01', '2025-04-14', '09:00', 5),
    ('BN03', 'VT08', '2025-04-01', '09:30', 2),
    ('BN08', 'VT12', '2025-04-10', '14:00', 3), 
    ('BN10', 'VT03', '2025-04-15', '10:30', 4), 
    ('BN11', 'VT14', '2025-04-12', '12:15', 3), 
    ('BN13', 'VT09', '2025-04-07', '08:30', 1), 
    ('BN14', 'VT11', '2025-04-05', '11:00', 2)
GO

---12 CÂU 
---2 CÂU TRUY VẤN NHIỀU BẢNG:
SELECT hd.MABN, bn.TENBN, vt.DACTA, sd.NGAY , SUM(hd.TONGTIEN) AS TongTien
FROM HD_VATTU hd
JOIN SUDUNGVATTU sd on sd.MABN = hd.MABN
JOIN VATTU vt ON sd.MAVT = vt.MAVT
JOIN BENHNHAN bn ON sd.MABN = bn.MABN
WHERE vt.DACTA IN (N'Thuốc Paracetamol', N'Băng gạc y tế') AND sd.NGAY >= '2025-04-01' AND sd.NGAY < '2025-07-01'
GROUP BY hd.MABN, bn.TENBN, vt.DACTA, sd.NGAY
GO

---Liệt kê tổng số giờ làm việc của các nhân viên trong từng khu chữa trị, chỉ lấy các nhân viên có tổng giờ làm việc vượt 35 giờ. 
---Thông tin gồm: MAKHU, TENKHU, SONHANVIEN, TONGGIOLAM. Kết quả sắp xếp theo TONGGIOLAM giảm dần.
SELECT nv.TENNV, nv.MANV, kct.MAKHU, kct.TENKHU,  SUM(lv.SOGIOLV) AS TongGioLam
FROM KHUCHUATRI kct
JOIN LAMVIEC lv ON kct.MAKHU = lv.MAKHU
JOIN NHANVIEN nv on nv.MANV = lv.MANV
GROUP BY kct.MAKHU, kct.TENKHU, nv.TENNV, nv.MANV
HAVING SUM(lv.SOGIOLV) > 35
ORDER BY TongGioLam DESC
GO

---2 UPDATE:
---Cập nhật kết quả chữa trị thành "Đã xuất viện" cho các ca chữa trị trước ngày 2025-04-03 nếu bệnh nhân 
---đã sử dụng vật tư liên quan.
UPDATE HOSOBENHAN
SET KETQUA = N'Đã xuất viện'
WHERE NGAYCT < '2025-04-03' AND MABN IN (	SELECT DISTINCT MABN
											FROM SUDUNGVATTU
											WHERE NGAY < '2025-04-03' )
GO

---Cập nhật mã bác sĩ thành "BS09" cho bệnh nhân nội trú có tình trạng là 'Tiến triển tốt' hoặc 'Cần theo dõi thêm', 
---nếu đang điều trị bằng VT04 hoặc VT13.
UPDATE HOSOBENHAN
SET MABS = 'BS09'
WHERE MABS != 'BS09' 
AND MABN IN (	SELECT b.MABN
				FROM BENHNHAN b
				JOIN HOSOBENHAN hs ON b.MABN = hs.MABN
				WHERE b.LOAIBN = N'Nội trú'
				AND hs.KETQUA IN (N'Tiến triển tốt', N'Cần theo dõi thêm')
				AND hs.MAVT IN ('VT04', 'VT13') )

---2 GROUP BY:
---Liệt kê tên khu điều trị, số giường đang có bệnh nhân nội trú nằm, và chỉ lấy các khu có ít nhất 2 giường đang được sử dụng.
SELECT K.TENKHU, COUNT(G.MAGIUONG) AS SO_GIUONG_DANG_SU_DUNG
FROM GIUONG G 
JOIN KHUCHUATRI K ON G.MAKHU = K.MAKHU 
JOIN BENHNHAN BN ON G.MABN = BN.MABN
WHERE BN.LOAIBN = N'Nội trú'
GROUP BY K.TENKHU
HAVING COUNT(G.MAGIUONG) >= 2
GO

---Tính tổng chi phí vật tư sử dụng cho mỗi khu điều trị trong bệnh viện?
SELECT kct.TENKHU, SUM(sdvt.SOLUONG * vt.DONGIA) AS TONGCHI
FROM SUDUNGVATTU sdvt
JOIN VATTU vt ON sdvt.MAVT = vt.MAVT
JOIN GIUONG g ON sdvt.MABN = g.MABN
JOIN KHUCHUATRI kct ON g.MAKHU = kct.MAKHU
GROUP BY kct.TENKHU
ORDER BY TONGCHI DESC
GO

---2 CÂU DELETE:
---Xóa bệnh nhân đã xuất viện và là ngoại trú
DELETE FROM SUDUNGVATTU
WHERE MABN IN (
    SELECT MABN FROM BENHNHAN
    WHERE LOAIBN = N'Ngoại trú'
    AND MABN NOT IN (SELECT MABN FROM HOSOBENHAN))
GO
DELETE FROM HOSOBENHAN
WHERE KETQUA = N'Đã xuất viện'
AND MABN IN (
    SELECT MABN FROM BENHNHAN WHERE LOAIBN = N'Ngoại trú')
GO
DELETE FROM BENHNHAN
WHERE LOAIBN = N'Ngoại trú'
AND MABN NOT IN (SELECT MABN FROM HOSOBENHAN)
GO

---Xóa các giường chưa từng được sử dụng
DELETE FROM GIUONG
WHERE MAGIUONG NOT IN (
    SELECT DISTINCT MAGIUONG FROM HOSOBENHAN)
GO

---2 SUBQUERY:
---Tìm bệnh nhân đã từng sử dụng vật tư có đơn giá cao hơn 10000:
SELECT MABN, TENBN
FROM BENHNHAN 
WHERE MABN IN (
    SELECT DISTINCT MABN 
    FROM SUDUNGVATTU 
    WHERE MAVT IN (
        SELECT MAVT FROM VATTU WHERE DONGIA > 10000))
GO

---Tìm bệnh nhân nội trú được chăm sóc bởi bác sĩ có nhiều bệnh nhân nhất:
SELECT bn.MABN, bn.TENBN, bn.LOAIBN, bs.MABS, bs.TENBS
FROM BENHNHAN bn
JOIN BACSI bs ON bn.MABS = bs.MABS
WHERE bn.LOAIBN = N'Nội trú' AND bs.MABS = (
      SELECT TOP 1 MABS
      FROM BENHNHAN
      GROUP BY MABS
      ORDER BY COUNT(*) DESC)
GO

---2 CÂU BẤT KỲ
---Liệt kê các vật tư được sử dụng vào ngày chẵn của tháng 4 năm 2025, với các thông tin: 
---MAVT, DACTA, MABN, NGAY, THOIGIAN, DONGIA, SOLUONG, TONGTIEN (SOLUONG * DONGIA)
---Kết quả sắp theo MAVT, cùng MAVT thì SOLUONG giảm dần.
SELECT sd.MAVT, vt.DACTA, sd.MABN, sd.NGAY, sd.THOIGIAN, vt.DONGIA, sd.SOLUONG, hd.TONGTIEN
FROM HD_VATTU hd
JOIN SUDUNGVATTU sd on sd.MABN = hd.MABN
JOIN VATTU vt ON sd.MAVT = vt.MAVT
WHERE YEAR(sd.NGAY) = 2025 AND MONTH(sd.NGAY) = 4 AND DAY(sd.NGAY) % 2 = 0
ORDER BY sd.MAVT, sd.SOLUONG DESC
GO

---Liệt kê tên bệnh nhân, tên bác sĩ điều trị và khu mà bệnh nhân đó đang nằm
SELECT bn.TENBN, bs.TENBS, k.TENKHU
FROM BENHNHAN bn
JOIN BACSI bs ON bn.MABS = bs.MABS
LEFT JOIN GIUONG g ON bn.MABN = g.MABN
LEFT JOIN KHUCHUATRI k ON g.MAKHU = k.MAKHU
GO

---CÁ NHÂN NGUYENQUOCDAT

---1.Truy vấn kết nối nhiều bảng: Liệt kê thông tin các bệnh nhân nội trú, giường bệnh họ đang nằm,
---khu chữa trị, và tên bác sĩ theo dõi.
SELECT bn.MABN, bn.TENBN, bn.NGAYSINH, g.MAGIUONG, g.SOPHONG, kc.MAKHU, kc.TENKHU, bs.TENBS
FROM BENHNHAN bn
JOIN GIUONG g ON bn.MABN = g.MABN
JOIN KHUCHUATRI kc ON g.MAKHU = kc.MAKHU
JOIN BACSI bs ON bn.MABS = bs.MABS
WHERE bn.LOAIBN = N'Nội trú'
ORDER BY kc.TENKHU, g.SOPHONG
GO

---2. Group By: Tổng chi phí vật tư mà mỗi bác sĩ sử dụng cho bệnh nhân của mình.
SELECT MABS, SUM(vt.DONGIA * sdvt.SOLUONG) AS TONGCHIPHIVATTU
FROM SUDUNGVATTU sdvt
JOIN VATTU vt ON sdvt.MAVT = vt.MAVT
JOIN HOSOBENHAN hs ON sdvt.MABN = hs.MABN
GROUP BY MABS
GO

---3. Update: Cập nhật số lượng vật tư trong bảng SUDUNGVATTU cho một bệnh nhân nhất định
UPDATE SUDUNGVATTU
SET SOLUONG = 10
WHERE MABN = 'BN1234' AND MAVT = 'VT001'
GO

---4. Delete: Xóa bệnh nhân ngoại trú không nằm giường nào và không có dữ liệu liên quan
DELETE FROM BENHNHAN
WHERE LOAIBN = N'Ngoại trú'
AND MABN NOT IN (SELECT MABN FROM SUDUNGVATTU)
AND MABN NOT IN (SELECT MABN FROM HOSOBENHAN)
AND MABN NOT IN (SELECT MABN FROM GIUONG)
GO

---5. Câu bất kỳ: Liệt kê thông tin bệnh nhân nội trú kèm tổng tiền vật tư đã sử dụng (nếu có).
SELECT bn.MABN, bn.TENBN, bn.LOAIBN, ISNULL(SUM(sdvt.SOLUONG * vt.DONGIA), 0) AS TONG_CHI_PHI_VATTU
FROM BENHNHAN bn
LEFT JOIN SUDUNGVATTU sdvt ON bn.MABN = sdvt.MABN
LEFT JOIN VATTU vt ON sdvt.MAVT = vt.MAVT
WHERE bn.LOAIBN = N'Nội trú'
GROUP BY bn.MABN, bn.TENBN, bn.LOAIBN
ORDER BY TONG_CHI_PHI_VATTU DESC
GO

---CÁ NHÂN HUYNHHONGYEN

---1. Liệt kê danh sách bệnh nhân nội trú đã sử dụng vật tư trong quá trình điều trị. Thông tin gồm 
---tên bệnh nhân, tên bác sĩ điều trị, tên các vật tư đã dùng, tổng số lượng vật tư, tổng tiền cho vật tư đó 
SELECT bn.MABN, TENBN, TENBS, STRING_AGG(DACTA, ', ') AS DSACHVT, SUM(hd.SOLUONG) AS TONGSOLUONGVT, SUM(hd.TONGTIEN) AS TONGTIENVT
FROM HD_VATTU hd
JOIN BENHNHAN bn ON bn.MABN = hd.MABN
JOIN BACSI BS ON bn.MABS = bs.MABS
JOIN VATTU VT ON hd.MAVT = vt.MAVT
WHERE LOAIBN = N'Nội trú'
GROUP BY bn.MABN, TENBN, TENBS
GO

---2. Update: Cập nhật kết quả 'Cần theo dõi thêm' cho các bệnh nhân huyết áp cao và đã điều trị ít nhất 1 lần, 
---nhưng kết quả hiện tại không phải là 'Đã xuất viện'.
UPDATE HOSOBENHAN
SET KETQUA = N'Cần theo dõi thêm'
WHERE TENBENH = N'Huyết áp cao'
AND LAN >= 1
AND KETQUA != N'Đã xuất viện'
GO

---3. Subquery: Liệt kê tên bác sĩ đã điều trị cho nhiều hơn 1 bệnh nhân.
SELECT TENBS 
FROM BACSI 
WHERE MABS IN (	SELECT MABS 
				FROM BENHNHAN 
				GROUP BY MABS 
				HAVING COUNT(DISTINCT MABN) > 1 )
GO

---4. Delete:  Xóa tất cả các bản ghi trong SUDUNGVATTU mà bệnh nhân đã xuất viện.
DELETE FROM SUDUNGVATTU
WHERE MABN IN (	SELECT MABN
				FROM HOSOBENHAN
				WHERE KETQUA = N'Đã xuất viện' )
GO

---5. Group by: Tính tổng số giường bệnh trong mỗi khu vực và nhóm theo mã khu. Sắp xếp theo tổng số giường giảm dần.
SELECT g.MAKHU, TENKHU, COUNT(*) AS TONGSOGIUONG
FROM GIUONG g
JOIN KHUCHUATRI kct ON g.MAKHU = kct.MAKHU
GROUP BY g.MAKHU, TENKHU
ORDER BY TONGSOGIUONG DESC
GO

---CÁ NHÂN DUONGTHAONGAN

---1. Truy vấn kết nối nhiều bảng: Liệt kê danh sách bệnh nhân nội trú, kèm tên giường, số phòng,
---tên khu và tên nhân viên y tá trưởng phụ trách khu.
SELECT BN.MABN, BN.TENBN, BN.LOAIBN, G.MAGIUONG, G.SOPHONG, K.TENKHU, NV.TENNV AS YTATRUONG
FROM BENHNHAN BN
JOIN GIUONG G ON BN.MABN = G.MABN
JOIN KHUCHUATRI K ON G.MAKHU = K.MAKHU
JOIN NHANVIEN NV ON K.MAYTATRUONG = NV.MANV
WHERE BN.LOAIBN = N'Nội trú'
GO

---2. Truy vấn nhiều bảng: Tìm các bác sĩ điều trị cho bệnh nhân nội trú trong khoảng thời gian từ ngày 01/04/2025 
---đến 10/04/2025 và bệnh nhân sử dụng vật tư trị giá tổng cộng trên 10,000.
SELECT BS.TENBS, BN.TENBN, SUM(SDT.SOLUONG * VT.DONGIA) AS TONGTIEN
FROM BACSI BS
JOIN BENHNHAN BN ON BS.MABS = BN.MABS
JOIN SUDUNGVATTU SDT ON BN.MABN = SDT.MABN
JOIN VATTU VT ON SDT.MAVT = VT.MAVT
WHERE BN.LOAIBN = N'Nội trú'
AND SDT.NGAY BETWEEN '2025-04-01' AND '2025-04-10'
GROUP BY BS.TENBS, BN.TENBN
HAVING SUM(SDT.SOLUONG * VT.DONGIA) > 10000
GO

---3. Delete: Xóa các vật tư không được sử dụng trong các ca phẫu thuật trong khoảng thời gian từ '2025-04-01' đến '2025-04-10', có đơn giá dưới 3000.
DELETE FROM VATTU
WHERE MAVT NOT IN (
    SELECT DISTINCT MAVT
    FROM SUDUNGVATTU
    WHERE NGAY BETWEEN '2025-04-01' AND '2025-04-10')
AND MAVT IN (
    SELECT MAVT
    FROM VATTU
    WHERE DONGIA < 3000)
GO

---4. Group by: Tính tổng chi phí vật tư y tế mà mỗi bệnh nhân đã sử dụng (dựa vào số lượng và đơn giá), 
---và chỉ lấy các bệnh nhân có tổng chi phí lớn hơn 20.000.
SELECT BENHNHAN.MABN, BENHNHAN.TENBN, SUM(SUDUNGVATTU.SOLUONG * VATTU.DONGIA) AS TONGCHI
FROM BENHNHAN
JOIN SUDUNGVATTU ON BENHNHAN.MABN = SUDUNGVATTU.MABN
JOIN VATTU ON SUDUNGVATTU.MAVT = VATTU.MAVT
GROUP BY BENHNHAN.MABN, BENHNHAN.TENBN
HAVING SUM(SUDUNGVATTU.SOLUONG * VATTU.DONGIA) > 20000
GO

---5. Update: cập nhật lại giá trị DONGIA của vật tư có mã 'VT01' trong bảng VATTU 
--dựa trên số lượng sử dụng của vật tư đó trong bảng SUDUNGVATTU. Chỉ cập nhật khi 
--tổng số lượng vật tư 'VT01' đã được sử dụng từ các bệnh nhân 'Nội trú' vượt quá 10 đơn vị.
UPDATE VATTU
SET DONGIA = DONGIA * 1.1  -- Tăng giá lên 10%
WHERE MAVT = 'VT01' 
AND EXISTS (
    SELECT 1
    FROM SUDUNGVATTU sv
    JOIN BENHNHAN bn ON sv.MABN = bn.MABN
    WHERE sv.MAVT = 'VT01' 
    AND bn.LOAIBN = N'Nội trú'
    GROUP BY sv.MAVT
    HAVING SUM(sv.SOLUONG) > 10)
GO

---CÁ NHÂN NGUYENVIYENTRANG

---Liệt kê số lần điều trị (số hồ sơ bệnh án) mà mỗi bác sĩ đã thực hiện trong tháng 4/2025. Thông tin bao gồm:
---bs.MABS, bs.TENBS, SO_LAN_DIEU_TRI. Kết quả sắp xếp theo số lần điều trị giảm dần
SELECT bs.MABS, bs.TENBS, COUNT(hs.MAHOSO) AS SO_LAN_DIEU_TRI
FROM BACSI AS bs
LEFT JOIN HOSOBENHAN hs ON bs.MABS = hs.MABS 
where hs.NGAYCT BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY bs.MABS, bs.TENBS
ORDER BY  SO_LAN_DIEU_TRI DESC


---2. GROUP BY: Hãy tính tổng số lượng và tổng tiền đã sử dụng của mỗi vật tư trong tháng 4/2025. Thông tin bao gồm 
---MAVT, DACTA, TONG_SO_LUONG, TONG_TIEN
SELECT sd.MAVT, vt.DACTA, SUM(sd.SOLUONG) AS TONG_SO_LUONG, SUM(hd.TONGTIEN) AS TONG_TIEN
FROM HD_VATTU hd
JOIN SUDUNGVATTU sd on sd.MABN = hd.MABN
JOIN VATTU AS vt ON sd.MAVT = vt.MAVT
WHERE sd.NGAY BETWEEN '2025-04-01' AND '2025-04-30'
GROUP BY sd.MAVT, vt.DACTA
ORDER BY TONG_TIEN DESC

---3. UPDATE: Đánh dấu là “Đã hoàn thành” cho tất cả các ca chữa trị có kết quả "Đã xuất viện" và do bác sĩ có mã BS01 hoặc BS03 thực hiện.
UPDATE HOSOBENHAN
SET KETQUA = N'Đã hoàn thành'
WHERE KETQUA like N'Đã xuất viện' AND (MABS = 'BS01' OR MABS = 'BS03')
GO
SELECT * FROM HOSOBENHAN

---4. Subquery:Tìm tên bệnh nhân có chi phí điều trị cao nhất. Thông tin bao gồm TENBN, MABN, NGAYSINH, LOAIBN, TONGTIEN
SELECT TENBN, BN.MABN, NGAYSINH, LOAIBN, SD.SOLUONG * VT.DONGIA AS TONGTIEN
FROM BENHNHAN BN 
JOIN SUDUNGVATTU SD ON SD.MABN = BN.MABN
JOIN VATTU VT ON VT.MAVT = SD.MAVT
WHERE BN. MABN = (
    SELECT TOP 1 MABN
    FROM SUDUNGVATTU SDV
    JOIN VATTU VT ON SDV.MAVT = VT.MAVT
    GROUP BY MABN
    ORDER BY SUM(SDV.SOLUONG * VT.DONGIA) DESC)
GO

---5. Cho biết các phương pháp điều trị đã thực hiện từ ngày 5 tháng 4 năm 2025 trở đi 
--và chỉ tính những ca bắt đầu từ 09:00 sáng trở đi. 
--Thông tin bao gồm MASCT, TENSCT, NGAYCT, THOIGIANCT, TENBN, TENBS
SELECT hs.TENBENH,hs.PPDIEUTRI,hs.NGAYCT,hs.THOIGIANCT, bn.TENBN, bs.TENBS      
FROM HOSOBENHAN hs
JOIN BENHNHAN bn ON hs.MABN = bn.MABN
JOIN BACSI bs ON hs.MABS = bs.MABS
WHERE hs.NGAYCT  >= '2025-04-05'AND hs.THOIGIANCT >= '09:00:00'
ORDER BY hs.NGAYCT, hs.THOIGIANCT
GO

---Cá nhân NGUYENTHIQUYNHTRAM

---1.Tổng số lượng vật tư đã sử dụng theo từng loại vật tư
SELECT MAVT, SUM(SOLUONG) AS TONGSUDUNG
FROM SUDUNGVATTU
GROUP BY MAVT
go
---2.Lấy danh sách bệnh nhân có dùng cùng loại vật tư với bệnh nhân BN01
SELECT DISTINCT MABN
FROM SUDUNGVATTU
WHERE MAVT IN (
    SELECT MAVT FROM SUDUNGVATTU
    WHERE MABN = 'BN01')
AND MABN <> 'BN01'
go
---3.Update: Cập nhật giá vật tư có đơn giá dưới 5000 thêm 10%
UPDATE VATTU
SET DONGIA = DONGIA * 1.1
WHERE DONGIA < 5000
go
---4.Danh sách chi tiết mỗi lần sử dụng vật tư trong ngày 01-04-2025
SELECT s.MABN, bn.TENBN, s.MAVT, vt.DACTA, s.SOLUONG, s.NGAY, s.THOIGIAN
FROM SUDUNGVATTU s
JOIN BENHNHAN bn ON s.MABN = bn.MABN
JOIN VATTU vt ON s.MAVT = vt.MAVT
WHERE s.NGAY = '2025-04-01'
go
