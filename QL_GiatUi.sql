﻿
USE QLGiatUi
GO
IF OBJECT_ID('NhanVien') IS NOT NULL DROP TABLE NhanVien
GO
CREATE TABLE NhanVien
(
	MaNV NVARCHAR(10) NOT NULL,
	TenNV NVARCHAR(30) NOT NULL,
	GioiTinh BIT NOT NULL,
	MatKhau NVARCHAR(8) NOT NULL,
	SDT INT NOT NULL,
	Email NVARCHAR(50) NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	VaiTro BIT NOT NULL,
	PRIMARY KEY(MaNV)
)
GO
IF OBJECT_ID('DichVu') IS NOT NULL DROP TABLE DichVu
GO
CREATE TABLE DichVu
(
	MaDV NVARCHAR(10) NOT NULL,
	LoaiDV NVARCHAR(50) NOT NULL,
	DonVi FLOAT NOT NULL,
	DonGia FLOAT NOT NULL,
	MoTa NVARCHAR(MAX) NULL,
	PRIMARY KEY(MaDV) 
)
IF OBJECT_ID('KhachHang') IS NOT NULL DROP TABLE KhachHang
GO
CREATE TABLE KhachHang
(
	MaKH NVARCHAR(10) NOT NULL,
	TenKH NVARCHAR(30) NOT NULL,
	GioiTinh BIT NOT NULL,
	DiaChi NVARCHAR(50) NOT NULL,
	SDT INT NOT NULL,
	GhiChu NVARCHAR(MAX) NULL,
	MaNV NVARCHAR(10) NOT NULL,	
	PRIMARY KEY(MaKH),
	FOREIGN KEY(MaNV) REFERENCES dbo.NhanVien(MaNV) ON DELETE NO ACTION ON UPDATE CASCADE
)
GO
IF OBJECT_ID('MatHang') IS NOT NULL DROP TABLE MatHang
GO
CREATE TABLE MatHang
(
	MaMH INT IDENTITY(1,1) NOT NULL,
	TenMH NVARCHAR(50) NOT NULL,
	SoLuong INT NOT NULL,
	TrangThai BIT NOT NULL,
	MaNV NVARCHAR(10) NOT NULL,
	MaDV NVARCHAR(10) NOT NULL,	
	CONSTRAINT PK_MatHang PRIMARY KEY(MaMH),
	FOREIGN KEY(MaNV) REFERENCES dbo.NhanVien(MaNV) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY(MaDV) REFERENCES dbo.DichVu(MaDV) ON DELETE NO ACTION ON UPDATE CASCADE
)
GO
IF OBJECT_ID('HoaDon') IS NOT NULL DROP TABLE HoaDon
GO
CREATE TABLE HoaDon
(
	MaHD NVARCHAR(10) NOT NULL,
	NgayNhan DATETIME NOT NULL,
	NgayTra DATETIME NOT NULL,
	TrangThai BIT NOT NULL,
	ThanhTien FLOAT NOT NULL,
	MaNV NVARCHAR(10) NOT NULL,
	MaKH NVARCHAR(10) NOT NULL,	
	PRIMARY KEY(MaHD),
	FOREIGN KEY(MaNV) REFERENCES dbo.NhanVien(MaNV) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY(MaKH) REFERENCES dbo.KhachHang(MaKH) ON DELETE CASCADE  ON UPDATE NO ACTION
)
GO
IF OBJECT_ID('HoaDonCT') IS NOT NULL DROP TABLE HoaDonCT
GO
CREATE TABLE HoaDonCT
(
	MaHDCT INT IDENTITY(1,1) NOT NULL,
	MaHD NVARCHAR(10) NOT NULL,
	MaMH INT NOT NULL,
	SoLuong INT NOT NULL,
	PRIMARY KEY(MaHDCT),
	FOREIGN KEY(MaHD) REFERENCES dbo.HoaDon(MaHD) ON DELETE NO ACTION ON UPDATE CASCADE,
	FOREIGN KEY(MaMH) REFERENCES dbo.MatHang(MaMH) ON DELETE CASCADE  ON UPDATE NO ACTION
	
)

DELETE FROM dbo.NhanVien
INSERT INTO dbo.NhanVien VALUES  ( N'NV001' ,N'Nguyễn Văn A' ,1 ,N'001' ,0969753187 ,N'vana0969@gmail.com' ,N'66 phố Mai Dịch, Cầu Giấy, Hà Nội' ,0)
INSERT INTO dbo.NhanVien VALUES  ( N'NV002' ,N'Nguyễn Văn B' ,1 ,N'002' ,0366245674 ,N'vanb0366@gmail.com' ,N'70 Trần Vĩ, Cầu Giấy, Hà Nội' ,0)
INSERT INTO dbo.NhanVien VALUES  ( N'NV003' ,N'Trần Thị D' ,0 ,N'003' ,0966223424 ,N'thid0966@gmail.com' ,N'90 Trần Hưng, Hoàng Mai, Hà Nội' ,1)
INSERT INTO dbo.NhanVien VALUES  ( N'NV004' ,N'Trần Thị C' ,0 ,N'004' ,0345666454 ,N'thic0345@gmail.com' ,N'50 Trần Vĩ, Cầu Giấy, Hà Nội' ,0)

DELETE FROM dbo.DichVu
INSERT INTO dbo.DichVu VALUES  ( N'DV01',N'Giặt nước ấm',2.5,20000,N'Tự phơi')
INSERT INTO dbo.DichVu VALUES  ( N'DV02',N'Giặt ướt',4.5,30000,N'Tự phơi')
INSERT INTO dbo.DichVu VALUES  ( N'DV03',N'Giặt khô',6.5,40000,N'Tự phơi')
INSERT INTO dbo.DichVu VALUES  ( N'DV04',N'Là hơi',8.5,50000,N'Tự phơi')
INSERT INTO dbo.DichVu VALUES  ( N'DV05',N'Sấy khô',10,60000,N'Tự phơi')

DELETE FROM dbo.KhachHang
INSERT INTO dbo.KhachHang VALUES  ( N'KH0001' ,N'Trần Đình Thiện' ,1 ,N'An Nội - Bình Lục - Hà Nam' ,0969753187 ,N'....' ,N'NV001')
INSERT INTO dbo.KhachHang VALUES  ( N'KH0002' ,N'Trần Văn Nam' ,1 ,N'Hoàng Hoa Thám - Tây Hồ - Hà Nội' ,0969753187 ,N'....' ,N'NV001')
INSERT INTO dbo.KhachHang VALUES  ( N'KH0004' ,N'Nguyễn Thị Ngọc' ,0 ,N'Ngọc Lũ - Phủ Lý - Vĩnh Phúc' ,0969753187 ,N'....' ,N'NV002')
INSERT INTO dbo.KhachHang VALUES  ( N'KH0005' ,N'Lê Thị Hương' ,0 ,N'Dịch Vọng - Cầu giấy - Hà nội' ,0969753187 ,N'....' ,N'NV003')
INSERT INTO dbo.KhachHang VALUES  ( N'KH0006' ,N'Nguyễn Văn Đức' ,1 ,N'Bồ Đề - Duy Tiên - Hà Nam' ,0969753187 ,N'....' ,N'NV002')

DELETE FROM dbo.MatHang
INSERT INTO dbo.MatHang VALUES  (N'Áo phông' ,2, 1 ,N'NV002' ,N'DV03')
INSERT INTO dbo.MatHang VALUES  (N'Áo khoác' ,2, 1 ,N'NV002' ,N'DV03')
INSERT INTO dbo.MatHang VALUES  (N'Quần jean' ,2, 1 ,N'NV001' ,N'DV04')
INSERT INTO dbo.MatHang VALUES  (N'Chăn bông' ,2, 1 ,N'NV001' ,N'DV04')
INSERT INTO dbo.MatHang VALUES  (N'Màn, Gối' ,2, 0 ,N'NV003' ,N'DV02')
INSERT INTO dbo.MatHang VALUES  (N'Những đồ màu trắng' ,2, 0 ,N'NV003' ,N'DV01')
INSERT INTO dbo.MatHang VALUES  (N'Những đồ màu đen' ,2, 0 ,N'NV004' ,N'DV05')

DELETE FROM dbo.HoaDon
INSERT INTO dbo.HoaDon VALUES  ( N'HD01' ,GETDATE() ,GETDATE() ,1 ,0.0 ,N'NV003' ,N'KH0002')
INSERT INTO dbo.HoaDon VALUES  ( N'HD02' ,GETDATE() ,GETDATE() ,1 ,0.0 ,N'NV003' ,N'KH0004')
INSERT INTO dbo.HoaDon VALUES  ( N'HD03' ,GETDATE() ,GETDATE() ,1 ,0.0 ,N'NV002' ,N'KH0001')
INSERT INTO dbo.HoaDon VALUES  ( N'HD04' ,GETDATE() ,GETDATE() ,0 ,0.0 ,N'NV002' ,N'KH0005')
INSERT INTO dbo.HoaDon VALUES  ( N'HD05' ,GETDATE() ,GETDATE() ,0 ,0.0 ,N'NV004' ,N'KH0006')

DELETE FROM dbo.HoaDonCT
INSERT INTO dbo.HoaDonCT VALUES  ( N'HD03',2,2 )
INSERT INTO dbo.HoaDonCT VALUES  ( N'HD04',7,2 )
INSERT INTO dbo.HoaDonCT VALUES  ( N'HD01',5,2 )
INSERT INTO dbo.HoaDonCT VALUES  ( N'HD05',3,2 )

