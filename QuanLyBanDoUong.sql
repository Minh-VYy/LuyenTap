DROP DATABASE IF EXISTS QuanLyBanDoUong;
CREATE DATABASE QuanLyBanDoUong;
GO

USE QuanLyBanDoUong;
GO

-- Bảng KhuVuc
CREATE TABLE KhuVuc (
    MaKhuVuc CHAR(6) PRIMARY KEY,
    TenKhuVuc NVARCHAR(50) NOT NULL,
    MoTa NVARCHAR(200)
);

-- Bảng DonGia
CREATE TABLE DonGia (
    DonGia_ID CHAR(6) PRIMARY KEY,
    MaDoUong CHAR(6) NOT NULL,
    TuNgay DATE NOT NULL,
    DenNgay DATE NULL,
    MoTa NVARCHAR(200),
);

-- Bảng DanhMuc
CREATE TABLE DanhMuc (
    MaDanhMuc CHAR(6) PRIMARY KEY,
    TenDanhMuc NVARCHAR(50) NOT NULL,
    MaDanhMuc_Cha CHAR(6),
);

-- Bảng MenuDoUong (liên kết với DonGia)
CREATE TABLE MenuDoUong (
    MaDoUong CHAR(6) PRIMARY KEY,
    TenDoUong NVARCHAR(50) NOT NULL,
    DonGia_ID CHAR(6) NOT NULL,
    MaDanhMuc CHAR(6),
    FOREIGN KEY (DonGia_ID) REFERENCES DonGia(DonGia_ID),
    FOREIGN KEY (MaDanhMuc) REFERENCES DanhMuc(MaDanhMuc)
);

-- Bảng Ban
CREATE TABLE Ban (
    MaBan CHAR(6) PRIMARY KEY,
    TenBan NVARCHAR(20) NOT NULL,
    TrangThai NVARCHAR(20) NOT NULL,
    MoTa NVARCHAR(200),
    MaKhuVuc CHAR(6),
    FOREIGN KEY (MaKhuVuc) REFERENCES KhuVuc(MaKhuVuc)
);

-- Bảng HoaDon
CREATE TABLE HoaDon (
    MaHoaDon CHAR(6) PRIMARY KEY,
    MaBan CHAR(6),
    NgayBan DATETIME NOT NULL,
    TongTien MONEY,
    FOREIGN KEY (MaBan) REFERENCES Ban(MaBan)
);

-- Bảng ChiTietHoaDon
CREATE TABLE ChiTietHoaDon (
    MaChiTiet CHAR(6) PRIMARY KEY,
    MaHoaDon CHAR(6) NOT NULL,
    MaDoUong CHAR(6) NOT NULL,
    DonGia MONEY NOT NULL,
    SoLuong INT NOT NULL CHECK (SoLuong > 0),
    FOREIGN KEY (MaHoaDon) REFERENCES HoaDon(MaHoaDon),
    FOREIGN KEY (MaDoUong) REFERENCES MenuDoUong(MaDoUong)
);
INSERT INTO KhuVuc (MaKhuVuc, TenKhuVuc, MoTa)
VALUES 
('KV001', N'Tầng 1', N'Khu vực tầng trệt'),
('KV002', N'Tầng 2', N'Khu vực lầu 1');
INSERT INTO DanhMuc (MaDanhMuc, TenDanhMuc, MaDanhMuc_Cha)
VALUES 
('DM001', N'Nước ngọt', NULL),
('DM002', N'Cà phê', NULL),
('DM003', N'Latte', 'DM002');
INSERT INTO DonGia (DonGia_ID, MaDoUong, TuNgay, DenNgay, MoTa)
VALUES 
('DG001', 'DU001', '2024-01-01', NULL, N'Giá hiện tại'),
('DG002', 'DU002', '2024-01-01', NULL, N'Giá mới');

INSERT INTO MenuDoUong (MaDoUong, TenDoUong, DonGia_ID, MaDanhMuc)
VALUES 
('DU001', N'Coca Cola', 'DG001', 'DM001'),
('DU002', N'Cà phê sữa', 'DG002', 'DM002');
INSERT INTO Ban (MaBan, TenBan, TrangThai, MoTa, MaKhuVuc)
VALUES 
('B001', N'Bàn 1', N'Trống', N'Gần cửa', 'KV001'),
('B002', N'Bàn 2', N'Đang dùng', N'Gần cửa sổ', 'KV001');
INSERT INTO HoaDon (MaHoaDon, MaBan, NgayBan, TongTien)
VALUES 
('HD001', 'B001', GETDATE(), 25000);
INSERT INTO ChiTietHoaDon (MaChiTiet, MaHoaDon, MaDoUong, DonGia, SoLuong)
VALUES 
('CT001', 'HD001', 'DU001', 25000, 1);
GO
-- Lấy toàn bộ đồ uống
CREATE PROCEDURE sp_GetAllDoUong
AS
BEGIN
    SELECT M.MaDoUong, M.TenDoUong, M.MaDanhMuc, D.TuNgay, D.DenNgay, D.MoTa
    FROM MenuDoUong M
    JOIN DonGia D ON M.DonGia_ID = D.DonGia_ID
END
GO

-- Cập nhật đồ uống
CREATE PROCEDURE sp_SuaDoUong
    @MaDoUong CHAR(6),
    @TenDoUong NVARCHAR(50),
    @DonGia_ID CHAR(6),
    @MaDanhMuc CHAR(6)
AS
BEGIN
    UPDATE MenuDoUong
    SET TenDoUong = @TenDoUong,
        DonGia_ID = @DonGia_ID,
        MaDanhMuc = @MaDanhMuc
    WHERE MaDoUong = @MaDoUong
END
GO
-- Lấy tất cả danh mục
CREATE PROCEDURE sp_GetAllDanhMuc
AS
BEGIN
    SELECT * FROM DanhMuc
END
GO
-- Lấy đơn giá theo mã đồ uống
CREATE PROCEDURE sp_GetDonGiaByDoUong
    @MaDoUong CHAR(6)
AS
BEGIN
    SELECT * FROM DonGia WHERE MaDoUong = @MaDoUong
END
GO
-- Lấy toàn bộ hóa đơn
CREATE PROCEDURE sp_GetAllHoaDon
AS
BEGIN
    SELECT * FROM HoaDon
END
GO

-- Lấy chi tiết hóa đơn theo mã hóa đơn
CREATE PROCEDURE sp_GetChiTietHoaDonByMa
    @MaHoaDon CHAR(6)
AS
BEGIN
    SELECT * FROM ChiTietHoaDon WHERE MaHoaDon = @MaHoaDon
END
GO
-- Lấy tất cả bàn
CREATE PROCEDURE sp_GetAllBan
AS
BEGIN
    SELECT B.MaBan, B.TenBan, B.TrangThai, B.MoTa, K.TenKhuVuc
    FROM Ban B
    LEFT JOIN KhuVuc K ON B.MaKhuVuc = K.MaKhuVuc
END
GO
-- Lấy tất cả khu vực
CREATE PROCEDURE sp_GetAllKhuVuc
AS
BEGIN
    SELECT * FROM KhuVuc
END
GO

