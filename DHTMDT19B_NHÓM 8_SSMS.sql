CREATE DATABASE QLBV
GO

USE QLBV
GO

CREATE TABLE NHANVIEN (
    MANV VARCHAR(10) PRIMARY KEY,
    TENNV NVARCHAR(100) NOT NULL )
GO

CREATE TABLE KHUCHUATRI (
    MAKHU VARCHAR(10) PRIMARY KEY,
    TENKHU NVARCHAR(100) NOT NULL,
    MAYTATRUONG VARCHAR(10) NOT NULL REFERENCES NHANVIEN(MANV) )
GO

CREATE TABLE BACSI (
    MABS VARCHAR(10) PRIMARY KEY,
    TENBS NVARCHAR(100) NOT NULL )
GO

CREATE TABLE BENHNHAN (
    MABN VARCHAR(10) PRIMARY KEY,
    TENBN NVARCHAR(100) NOT NULL,
    NGAYSINH DATETIME NOT NULL,
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
    DONGIA MONEY NOT NULL )
GO

CREATE TABLE SUCHUATRI (
    MASCT CHAR(10) PRIMARY KEY,
    TENSCT NVARCHAR(100),
    NGAYCT DATE,
    THOIGIANCT TIME,
	LAN INT,
    KETQUA NVARCHAR(255),
    MABN VARCHAR(10),
    MABS VARCHAR(10),
    FOREIGN KEY (MABN) REFERENCES BENHNHAN(MABN),
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
	('K01', N'Khu Nội khoa', 'NV01'),
	('K02', N'Khu Ngoại khoa', 'NV05'),
	('K03', N'Khu Sơ sinh', 'NV03'),
	('K04', N'Khu Cấp cứu', 'NV14'),
	('K05', N'Khu Phục hồi', 'NV10'),
	('K06', N'Khu Nhiễm', 'NV07'),
	('K07', N'Khu Nhi khoa', 'NV12')
GO

INSERT INTO BACSI VALUES
	('BS01', N'Nguyễn Văn Xuyên'),
	('BS02', N'Trần Thị Yến'),
	('BS03', N'Lê Văn Dương'),
	('BS04', N'Phạm Thị Vượng'),
	('BS05', N'Hoàng Văn Vỹ'),
	('BS06', N'Nguyễn Thị Như Quỳnh'),
	('BS07', N'Trần Văn Khoa'),
	('BS08', N'Lê Minh'),
	('BS09', N'Phạm Văn Long'),
	('BS10', N'Trần Hoàng Như Ngọc')
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
	('G12', 801, 'K07', 'BN13')
GO

INSERT INTO VATTU VALUES
	('VT01', N'Thuốc Paracetamol', 5000),
	('VT02', N'Băng gạc y tế', 2000),
	('VT03', N'Kim tiêm', 1000),
	('VT04', N'Thuốc kháng sinh Amoxicillin', 10000),
	('VT05', N'Nước muối sinh lý', 3000),
	('VT06', N'Thuốc giảm đau Ibuprofen', 8000),
	('VT07', N'Ống tiêm 5ml', 1500),
	('VT08', N'Thuốc hạ sốt Efferalgan', 6000),
	('VT09', N'Máy đo huyết áp', 500000),
	('VT10', N'Thuốc kháng viêm Diclofenac', 12000),
	('VT11', N'Thuốc tiêu hóa Domperidone', 7000),
	('VT12', N'Thuốc chống dị ứng Loratadine', 6000),
	('VT13', N'Thuốc huyết áp Amlodipine', 15000),
	('VT14', N'Thuốc ho Codein', 5000),
	('VT15', N'Thuốc dạ dày Omeprazole', 10000)
GO

INSERT INTO SUCHUATRI VALUES
	('SCT01', N'Xét nghiệm máu', '2025-04-01', '08:00', 1, N'Bình thường', 'BN01', 'BS01'),
	('SCT02', N'Chụp X-quang', '2025-04-02', '09:30', 1, N'Không phát hiện bất thường', 'BN02', 'BS02'),
	('SCT03', N'Nội soi dạ dày', '2025-04-03', '10:15', 1, N'Viêm nhẹ', 'BN03', 'BS03'),
	('SCT04', N'Điện tim', '2025-04-04', '11:00', 1, N'Nhịp tim ổn định', 'BN04', 'BS04'),
	('SCT05', N'Đo huyết áp', '2025-04-05', '08:30', 1, N'120/80 mmHg', 'BN05', 'BS05'),
	('SCT06', N'Xét nghiệm máu', '2025-04-06', '07:45', 2, N'Hơi thiếu máu', 'BN06', 'BS06'),
	('SCT07', N'Chụp X-quang', '2025-04-07', '14:00', 1, N'Gãy xương nhẹ', 'BN07', 'BS07'),
	('SCT08', N'Nội soi dạ dày', '2025-04-08', '09:00', 1, N'Loét dạ dày', 'BN08', 'BS08'),
	('SCT09', N'Điện tim', '2025-04-09', '10:30', 1, N'Nhịp tim bình thường', 'BN09', 'BS09'),
	('SCT10', N'Đo huyết áp', '2025-04-10', '08:15', 1, N'130/85 mmHg', 'BN10', 'BS10')
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
    ('BN15', 'VT01', '2025-04-14', '09:00', 5)
GO

---12 CÂU 
---2 CÂU TRUY VẤN NHIỀU BẢNG:
---Liệt kê các bệnh nhân đã sử dụng vật tư y tế trong quý 2 năm 2025, loại vật tư là ‘Thuốc Paracetamol’ 
---hoặc ‘Băng gạc y tế’, thông tin gồm MABN,TENBN, TongTien(Soluong*Dongia).
SELECT sd.MABN, bn.TENBN,vt.DACTA, SUM(sd.SOLUONG * vt.DONGIA) AS TongTien
FROM SUDUNGVATTU sd
JOIN VATTU vt ON sd.MAVT = vt.MAVT
JOIN BENHNHAN bn ON sd.MABN = bn.MABN
WHERE vt.MAVT IN ('VT01', 'VT02') AND sd.NGAY >= '2025-04-01' AND sd.NGAY < '2025-07-01'
GROUP BY sd.MABN, bn.TENBN, vt.DACTA
GO

---Liệt kê tổng số giờ làm việc của các nhân viên trong từng khu chữa trị, chỉ lấy các nhân viên có tổng giờ làm việc vượt 35 giờ. 
---Thông tin gồm: MAKHU, TENKHU, SoNhanVien, TongGioLam. Kết quả sắp xếp theo TongGioLam giảm dần.
SELECT nv.TENNV, nv.MANV, kct.MAKHU, kct.TENKHU,  SUM(lv.SOGIOLV) AS TongGioLam
FROM KHUCHUATRI kct
JOIN LAMVIEC lv ON kct.MAKHU = lv.MAKHU
JOIN NHANVIEN nv on nv.MANV = lv.MANV
GROUP BY kct.MAKHU, kct.TENKHU, nv.TENNV, nv.MANV
HAVING SUM(lv.SOGIOLV) > 35
ORDER BY TongGioLam DESC
GO

---2 UPDATE:
---Cập nhật đơn giá của tất cả vật tư có chứa từ “thuốc” và đã từng được sử dụng với số lượng > 2, tăng đơn giá thêm 10% 
UPDATE VATTU
SET DONGIA = DONGIA * 1.1
WHERE MAVT IN (	SELECT DISTINCT SDVT.MAVT
				FROM SUDUNGVATTU SDVT
				JOIN VATTU VT ON SDVT.MAVT = VT.MAVT
				WHERE DACTA LIKE N'%thuốc%' AND SOLUONG > 2 )
GO

---Cập nhật số giờ làm việc cho các nhân viên làm việc tại khu vực có ít nhất 2 giường bệnh, tăng số giờ làm việc thêm 5 giờ. 
UPDATE LAMVIEC
SET SOGIOLV = SOGIOLV + 5
WHERE MAKHU IN (SELECT MAKHU
				FROM GIUONG
				GROUP BY MAKHU
				HAVING COUNT(*) >= 2 )
GO

---2 GROUP BY:
---Liệt kê tên khu điều trị, số giường đang có bệnh nhân nội trú nằm (có thông tin bệnh nhân và loại bệnh nhân là "Nội trú"), 
---và chỉ lấy các khu có ít nhất 2 giường đang được sử dụng.
SELECT K.TENKHU, COUNT(G.MAGIUONG) AS SO_GIUONG_DANG_SU_DUNG
FROM GIUONG G 
JOIN KHUCHUATRI K ON G.MAKHU = K.MAKHU 
JOIN BENHNHAN BN ON G.MABN = BN.MABN
WHERE BN.LOAIBN = N'Nội trú'
GROUP BY K.TENKHU
HAVING COUNT(G.MAGIUONG) >= 2
GO

---Với mỗi bác sĩ, hãy liệt kê tên bác sĩ, số bệnh nhân điều trị, và chỉ lấy các bác sĩ đang điều trị cho từ 2 bệnh nhân trở lên.
SELECT BS.TENBS, COUNT(BN.MABN) AS SO_BENH_NHAN
FROM BACSI BS
JOIN BENHNHAN BN ON BS.MABS = BN.MABS
GROUP BY BS.TENBS
HAVING COUNT(BN.MABN) >= 2
GO

---2 CÂU DELETE:
---Xóa các bác sĩ chưa từng thực hiện chữa trị bệnh nhân nào
DELETE FROM BACSI
WHERE NOT EXISTS 
    (SELECT 1 
    FROM SUCHUATRI 
    WHERE SUCHUATRI.MABS = BACSI.MABS)
AND NOT EXISTS 
    (SELECT 1 
    FROM BENHNHAN 
    WHERE BENHNHAN.MABS = BACSI.MABS)
GO

 ---Xóa tất cả vật tư (VATTU) chưa từng được sử dụng .
DELETE v
FROM VATTU AS v
LEFT JOIN SUDUNGVATTU AS sd 
  ON v.MAVT = sd.MAVT
WHERE sd.MAVT IS NULL
GO

---2 SUBQUERY:
---Tìm khu chữa trị có số lượng giường trống nhiều nhất và thông tin về y tá trưởng của khu đó
SELECT kc.MAKHU, kc.TENKHU, nv.MANV AS MAYTATRUONG, nv.TENNV
FROM KHUCHUATRI kc
JOIN NHANVIEN nv ON kc.MAYTATRUONG = nv.MANV
WHERE kc.MAKHU IN (
    SELECT TOP 1 MAKHU
    FROM GIUONG
    WHERE MABN IS NULL
    GROUP BY MAKHU
    ORDER BY COUNT(*) DESC)
GO

---Tìm bệnh nhân nội trú được chăm sóc bởi bác sĩ có nhiều bệnh nhân nhất
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
---Liệt kê các vật tư được sử dụng vào thứ Ba và thứ Năm của tháng 4 năm 2025, với các thông tin: 
---MAVT, DACTA, MABN, NGAY, THOIGIAN, DONGIA, SOLUONG, TONGTIEN (SOLUONG * DONGIA)
---Kết quả sắp theo MAVT, cùng MAVT thì SOLUONG giảm dần.
SELECT sd.MAVT, vt.DACTA, sd.MABN, sd.NGAY, sd.THOIGIAN, vt.DONGIA, sd.SOLUONG, sd.SOLUONG * vt.DONGIA AS TONGTIEN
FROM SUDUNGVATTU sd
JOIN VATTU vt ON sd.MAVT = vt.MAVT
WHERE MONTH(sd.NGAY) = 4 AND YEAR(sd.NGAY) = 2025 AND DATENAME(WEEKDAY, sd.NGAY) IN ('Tuesday','Thursday')
ORDER BY sd.MAVT, sd.SOLUONG DESC
GO

---Liệt kê tên bệnh nhân, tên bác sĩ điều trị và khu chứa giường mà bệnh nhân đó đang nằm
SELECT BN.TENBN, BS.TENBS, K.TENKHU
FROM BENHNHAN BN
JOIN BACSI BS ON BN.MABS = BS.MABS
LEFT JOIN GIUONG G ON BN.MABN = G.MABN
LEFT JOIN KHUCHUATRI K ON G.MAKHU = K.MAKHU
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

---2. Group By: Tổng chi phí vật tư theo từng bệnh nhân
SELECT s.MABN, bn.TENBN, SUM(s.SOLUONG * vt.DONGIA) AS TONGCHI
FROM SUDUNGVATTU s
JOIN VATTU vt ON s.MAVT = vt.MAVT
JOIN BENHNHAN bn ON s.MABN = bn.MABN
GROUP BY s.MABN, bn.TENBN
ORDER BY TONGCHI DESC
GO

---3. Update: Tăng số giờ làm việc của nhân viên "NV03" lên 5 giờ nếu hiện tại họ làm dưới 40 giờ.
UPDATE LAMVIEC
SET SOGIOLV = SOGIOLV + 5
WHERE MANV = 'NV03' AND SOGIOLV < 40
GO

---4. Delete: Xóa bệnh nhân ngoại trú không nằm giường nào và không có dữ liệu liên quan
DELETE FROM BENHNHAN
WHERE LOAIBN = N'Ngoại trú'
AND MABN NOT IN (SELECT MABN FROM SUDUNGVATTU)
AND MABN NOT IN (SELECT MABN FROM SUCHUATRI)
AND MABN NOT IN (SELECT MABN FROM GIUONG)
GO

---5. Câu bất kỳ: Liệt kê thông tin bệnh nhân nội trú kèm tổng tiền vật tư đã sử dụng (nếu có). 
---Nếu chưa dùng vật tư, vẫn hiển thị với tổng tiền là 0
SELECT bn.MABN, bn.TENBN, bn.LOAIBN, ISNULL(SUM(sdvt.SOLUONG * vt.DONGIA), 0) AS TONG_CHI_PHI_VATTU
FROM BENHNHAN bn
LEFT JOIN SUDUNGVATTU sdvt ON bn.MABN = sdvt.MABN
LEFT JOIN VATTU vt ON sdvt.MAVT = vt.MAVT
WHERE bn.LOAIBN = N'Nội trú'
GROUP BY bn.MABN, bn.TENBN, bn.LOAIBN
ORDER BY TONG_CHI_PHI_VATTU DESC
GO

---CÁ NHÂN NGUYENTHIQUYNHTRAM

---1. GROUP BY:  Tính số lần điều trị của mỗi bệnh nhân
SELECT
  bn.MABN,
  bn.TENBN,
  COUNT(s.MASCT) AS SoLanDieuTri
FROM BENHNHAN AS bn
LEFT JOIN SUCHUATRI AS s ON bn.MABN = s.MABN
GROUP BY bn.MABN, bn.TENBN
GO

---2. Truy vấn kết nối nhiều bảng : Lập danh sách tên bệnh nhân, tên vật tư đã sử dụng, số lượng và tổng tiền.
SELECT BN.TENBN, VT.DACTA, SDVT.SOLUONG, (SDVT.SOLUONG * VT.DONGIA) AS TONGTIEN
FROM SUDUNGVATTU SDVT
JOIN BENHNHAN BN ON SDVT.MABN = BN.MABN
JOIN VATTU VT ON SDVT.MAVT = VT.MAVT
GO

---3. UPDATE:Cập nhật số giờ làm việc của nhân viên tại khu "Khu001", nếu số giờ làm việc trong tháng 5 năm 2025 ít hơn 100, tăng thêm 20 giờ.
UPDATE LAMVIEC
SET SOGIOLV = SOGIOLV + 20
WHERE MAKHU = 'Khu001'
  AND SOGIOLV < 100
GO

---4. SUBQERY:Lấy tên bác sĩ và số lần điều trị của bác sĩ đó cho bệnh nhân có mã "BN001", chỉ lấy bác sĩ điều trị cho bệnh nhân này hơn 3 lần.
SELECT BACSI.TenBS, COUNT(*) AS SoLanDieuTri
FROM BACSI
JOIN SUCHUATRI sct ON BACSI.MABS = sct.MaBS
WHERE sct.MaBN = 'BN01'
GROUP BY BACSI.MaBS, BACSI.TenBS
HAVING COUNT(*) > 3
GO

---5. DELETE: Xóa các dòng trong SUDUNGVATTU mà bệnh nhân đã dùng vật tư từ ngày 2025-04-05 đến ngày hiện tại, trong khung giờ từ 08:00 đến 12:00, và có số lượng > 1.
DELETE FROM SUDUNGVATTU
WHERE NGAY >= '2025-04-05'
  AND THOIGIAN BETWEEN '08:00' AND '12:00'
  AND SOLUONG > 1
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

---3. Delete: Xoá tất cả bệnh nhân nội trú đã nhập viện hơn 5 năm và chưa từng có bất kỳ một cuộc điều trị (SUCHUATRI) nào.
DELETE FROM BENHNHAN
WHERE LOAIBN = N'Nội trú'
  AND DATEDIFF(YEAR, NGAYSINH, GETDATE()) > 30
  AND NOT EXISTS (
      SELECT 1 FROM SUCHUATRI WHERE SUCHUATRI.MABN = BENHNHAN.MABN)
  AND NOT EXISTS (
      SELECT 1 FROM GIUONG WHERE GIUONG.MABN = BENHNHAN.MABN)
  AND NOT EXISTS (
      SELECT 1 FROM SUDUNGVATTU WHERE SUDUNGVATTU.MABN = BENHNHAN.MABN)
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

---5. Update: cập nhật lại giá trị DONGIA của vật tư có mã 'VT01' trong bảng VATTU dựa trên số lượng sử dụng của vật tư đó trong bảng SUDUNGVATTU. Chỉ cập nhật khi tổng số lượng vật tư 'VT01' đã được sử dụng từ các bệnh nhân 'Nội trú' vượt quá 10 đơn vị.
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

---2. Update: Cập nhật bác sĩ điều trị cho các bệnh nhân ngoại trú thành bác sĩ "BS05" nếu 
---bệnh nhân này đã điều trị trên 3 lần. 
UPDATE BENHNHAN
SET MABS = 'BS05'
WHERE LOAIBN = N'Ngoại trú' 
AND MABS != 'BS05' AND MABN IN (SELECT MABN
								FROM SUCHUATRI
								GROUP BY MABN
								HAVING COUNT(*) > 3 )
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
WHERE MABN NOT IN (	SELECT MABN 
					FROM GIUONG 
					WHERE MABN IS NOT NULL )
GO

---5. Group by: Tính tổng số giường bệnh trong mỗi khu vực và nhóm theo mã khu. Sắp xếp theo tổng số giường giảm dần.
SELECT g.MAKHU, TENKHU, COUNT(*) AS TONGSOGIUONG
FROM GIUONG g
JOIN KHUCHUATRI kct ON g.MAKHU = kct.MAKHU
GROUP BY g.MAKHU, TENKHU
ORDER BY TONGSOGIUONG DESC
GO

---CÁ NHÂN NGUYENVIYENTRANG

---1. DELETE: Xóa những bệnh nhân ngoại trú chưa từng có lần chữa trị nào
DELETE BN
FROM BENHNHAN BN
JOIN SUCHUATRI SCT ON BN.MABN = SCT.MABN
WHERE BN.LOAIBN = 'Ngoại trú' AND SCT.MABN IS NULL
GO

---2. GROUP BY: Cho biết các bác sĩ đã thực hiện chụp X‑quang trong 10 ngày đầu tháng 4/2025” Thông tin bao gồm:
---MASCT, TENSCT, KETQUA, MABS, TENBS, NGAYCT
SELECT sct.MASCT, sct.TENSCT, sct.KETQUA ,sct. MABS, bs.TENBS, sct.NGAYCT, COUNT(sct.LAN) AS SoLanChup
FROM SUCHUATRI sct 
JOIN BACSI bs ON sct.MABS = bs.MABS
WHERE sct.TENSCT = N'Chụp X-quang'
AND sct.NGAYCT BETWEEN '2025-04-01' AND '2025-04-10'
GROUP BY sct.MASCT, sct.TENSCT, sct.KETQUA ,sct.MABS, bs.TENBS, sct.NGAYCT
GO

---3. UPDATE: Đánh dấu là “Đã hoàn thành” cho tất cả các ca chữa trị được thực hiện trước ngày 2025‑04‑05 và do bác sĩ có mã BS01 thực hiện.
UPDATE SUCHUATRI
SET KETQUA = N'Đã hoàn thành'
WHERE NGAYCT < '2025-04-05' AND MABS = 'BS01'
GO

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

---5. Cho biết các thủ thuật đã thực hiện từ ngày 5 tháng 4 năm 2025 trở đi 
--và chỉ tính những ca bắt đầu từ 09:00 sáng trở đi. 
--Thông tin bao gồm MASCT, TENSCT, NGAYCT, THOIGIANCT, TENBN, TENBS
SELECT s.MASCT,s.TENSCT,s.NGAYCT,s.THOIGIANCT, bn.TENBN, bs.TENBS      
FROM SUCHUATRI s
JOIN BENHNHAN bn ON s.MABN = bn.MABN
JOIN BACSI bs ON s.MABS = bs.MABS
WHERE s.NGAYCT  >= '2025-04-05'AND s.THOIGIANCT >= '09:00:00'
ORDER BY s.NGAYCT, s.THOIGIANCT
GO



