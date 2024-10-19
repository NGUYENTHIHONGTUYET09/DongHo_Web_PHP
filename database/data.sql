-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS qlbh;

-- Sử dụng cơ sở dữ liệu vừa tạo
USE qlbh;

-- Tạo bảng categories
CREATE TABLE IF NOT EXISTS danhmucsp (
    madm INT AUTO_INCREMENT PRIMARY KEY,
    tendm VARCHAR(100) NOT NULL,
    xuatsu VARCHAR(100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng products
CREATE TABLE IF NOT EXISTS sanpham (
    masp INT AUTO_INCREMENT PRIMARY KEY,
    tensp VARCHAR(255) NOT NULL,
    gia DECIMAL(10, 2) NOT NULL,
    baohanh VARCHAR(100),
    trongluong VARCHAR(100),
    chatlieu VARCHAR(100),
    chongnuoc VARCHAR(100),
    nangluong VARCHAR(100),
    loaibh VARCHAR(100),
    kichthuoc VARCHAR(100),
    mau VARCHAR(50),
    danhcho VARCHAR(100),
    phukien VARCHAR(255),
    khuyenmai VARCHAR(255),
    tinhtrang VARCHAR(50),
    madm INT,
    anhchinh VARCHAR(255),
    luotmua INT DEFAULT 0,
    luotxem INT DEFAULT 0,
    ngaytao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_nhap TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (madm) REFERENCES danhmucsp(madm) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng giao dịch
CREATE TABLE IF NOT EXISTS giaodich (
    magd INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    user_name VARCHAR(255) NOT NULL,
    user_dst VARCHAR(100),
    user_addr VARCHAR(255),
    user_phone VARCHAR(15),
    tongtien DECIMAL(10, 2) NOT NULL,
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tinhtrang TINYINT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng chi tiết giao dịch
CREATE TABLE IF NOT EXISTS chitietgiaodich (
    id INT AUTO_INCREMENT PRIMARY KEY,
    magd INT NOT NULL,
    masp INT NOT NULL,
    soluong INT NOT NULL,
    FOREIGN KEY (magd) REFERENCES giaodich(magd) ON DELETE CASCADE,
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng thành viên
CREATE TABLE IF NOT EXISTS thanhvien (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ten VARCHAR(255) NOT NULL,
    tentaikhoan VARCHAR(100) NOT NULL UNIQUE,
    matkhau VARCHAR(255) NOT NULL,
    diachi TEXT,
    sodt VARCHAR(15),
    email VARCHAR(100),
    ngaytao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    quyen INT DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng giỏ hàng
CREATE TABLE IF NOT EXISTS giohang (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    masp INT NOT NULL,
    soluong INT NOT NULL DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES thanhvien(id) ON DELETE CASCADE,
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng sản phẩm yêu thích
CREATE TABLE IF NOT EXISTS sanphamyeuthich (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    masp INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES thanhvien(id) ON DELETE CASCADE,
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Thêm dữ liệu mẫu cho bảng danh mục sản phẩm
INSERT INTO danhmucsp (tendm, xuatsu) VALUES
('Đồng hồ cơ', 'Thụy Sĩ'),
('Đồng hồ pin', 'Nhật Bản'),
('Đồng hồ thời trang', 'Trung Quốc'),
('Đồng hồ thể thao', 'Mỹ'),
('Đồng hồ nữ', 'Đức');

-- Thêm dữ liệu mẫu cho bảng sản phẩm
INSERT INTO sanpham (tensp, gia, baohanh, trongluong, chatlieu, chongnuoc, nangluong, loaibh, kichthuoc, mau, danhcho, phukien, khuyenmai, tinhtrang, madm, anhchinh) VALUES
('Rolex-Datejust-179174-0031', 25000000.00, '2 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Đen', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/rolex/Rolex-Datejust-179174-0031.png'),
('Rolex-Datejust-179174-0094', 25000000.00, '2 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nữ', '40mm', 'Đen', 'Nữ', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/rolex/Rolex-Datejust-179174-0094.png'),
('Piaget z3', 1500000.00, '2 năm', '70g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Trắng', 'Nữ', 'Hộp quà', 'Giảm 10%', 'Mới', 2, 'images/rolex/Piaget-z3.png'),
('Casio MTP-V002D-1B3', 1000000.00, '1 năm', '120g', 'Thép không gỉ', '50m', 'Pin', 'Nam', '38mm', 'Bạc', 'Nam', 'Hộp quà', 'Giảm 5%', 'Mới', 3, 'images/rolex/Casio-MTP-V002D-1B3.png'),
('Seiko 5 Automatic', 2000000.00, '2 năm', '130g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Xanh', 'Nam', 'Hộp quà', 'Giảm 15%', 'Mới', 4, 'images/rolex/Seiko-5-Automatic.png');

INSERT INTO sanpham (tensp, gia, baohanh, trongluong, chatlieu, chongnuoc, nangluong, loaibh, kichthuoc, mau, danhcho, phukien, khuyenmai, tinhtrang, madm, anhchinh) VALUES
('Rolex-Datejust-179174-0031', 25000000.00, '2 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Đen', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/rolex/Rolex-Datejust-179174-0031.png'),
('Rolex-Datejust-179174-0094', 25000000.00, '2 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nữ', '40mm', 'Đen', 'Nữ', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/rolex/Rolex-Datejust-179174-0094.png'),
('Piaget z3', 1500000.00, '2 năm', '70g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Trắng', 'Nữ', 'Hộp quà', 'Giảm 10%', 'Mới', 2, 'images/rolex/Piaget-z3.png'),
('Casio MTP-V002D-1B3', 1000000.00, '1 năm', '120g', 'Thép không gỉ', '50m', 'Pin', 'Nam', '38mm', 'Bạc', 'Nam', 'Hộp quà', 'Giảm 5%', 'Mới', 3, 'images/rolex/Casio-MTP-V002D-1B3.png'),
('Seiko 5 Automatic', 2000000.00, '2 năm', '130g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Xanh', 'Nam', 'Hộp quà', 'Giảm 15%', 'Mới', 4, 'images/rolex/Seiko-5-Automatic.png'),
('Piaget z2', 10000000.00, '1 năm', '50g', 'Nhựa', 'Chống nước', 'Pin', 'Nam/Nữ', '44mm', 'Đen', 'Nam/Nữ', 'Cáp sạc', 'Giảm 15%', 'Mới', 3, 'images/piaget/piaget z2.png'),
('Piaget z1', 3000000.00, '1 năm', '200g', 'Thép không gỉ', '50m', 'Cơ', 'Nam', '42mm', 'Bạc', 'Nam', 'Hộp quà', 'Giảm 20%', 'Mới', 1, 'images/piaget/piaget z1.png'),
('Omega CO', 800000.00, '1 năm', '100g', 'Nhựa', '30m', 'Pin', 'Nam', '40mm', 'Xanh', 'Nam', 'Hộp quà', 'Giảm 5%', 'Mới', 5, 'images/omega/Omega CO.png'),
('Omega 307', 4000000.00, '1 năm', '120g', 'Thép không gỉ', '50m', 'Pin', 'Nữ', '38mm', 'Hồng', 'Nữ', 'Cáp sạc', 'Giảm 15%', 'Mới', 6, 'images/omega/Omega 307.png'),
('Montblanc 1', 3500000.00, '1 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Nâu', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/montblanc/montblanc 1.png'),
('Montblanc 2', 3500000.00, '1 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Nâu', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/montblanc/montblanc 2.png');


-- Thêm dữ liệu mẫu cho bảng giao dịch
INSERT INTO giaodich (user_id, user_name, user_dst, user_addr, user_phone, tongtien) VALUES
(1, 'Nguyễn Văn A', 'Quận 1', '123 Đường ABC', '0123456789', 25000000.00),
(2, 'Trần Thị B', 'Quận 2', '456 Đường XYZ', '0987654321', 15000000.00),
(3, 'Lê Văn C', 'Quận 3', '789 Đường DEF', '0345678901', 5000000.00),
(4, 'Phạm Thị D', 'Quận 4', '159 Đường GHI', '0456789012', 30000000.00),
(5, 'Nguyễn Thị E', 'Quận 5', '753 Đường JKL', '0567890123', 22000000.00);

-- Thêm dữ liệu mẫu cho bảng chi tiết giao dịch
INSERT INTO chitietgiaodich (magd, masp, soluong) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(3, 4, 2),
(4, 5, 1);

DESCRIBE thanhvien;
ALTER TABLE thanhvien ADD COLUMN ten VARCHAR(255) NOT NULL;
ALTER TABLE thanhvien ADD COLUMN sodt VARCHAR(15);
ALTER TABLE thanhvien ADD COLUMN name VARCHAR(255) NOT NULL;





-- Thêm dữ liệu mẫu cho bảng thành viên
INSERT INTO thanhvien (name, ten, tentaikhoan, matkhau, diachi, sodt, email) VALUES
('Nguyễn Văn A', 'Nguyễn Văn A', 'nguyenvana', 'matkhau123', '123 Đường ABC', '0123456789', 'vana@example.com'),
('Trần Thị B', 'Trần Thị B', 'tranthib', 'matkhau123', '456 Đường XYZ', '0987654321', 'thib@example.com'),
('Lê Văn C', 'Lê Văn C', 'levanc', 'matkhau123', '789 Đường DEF', '0345678901', 'vanc@example.com'),
('Phạm Thị D', 'Phạm Thị D', 'phamthid', 'matkhau123', '159 Đường GHI', '0456789012', 'thid@example.com'),
('Nguyễn Thị E', 'Nguyễn Thị E', 'nguyenthi', 'matkhau123', '753 Đường JKL', '0567890123', 'thi@example.com');

-- Thêm dữ liệu mẫu cho bảng giỏ hàng
INSERT INTO giohang (user_id, masp, soluong) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 1),
(4, 5, 3);

-- Thêm dữ liệu mẫu cho bảng sản phẩm yêu thích
INSERT INTO sanphamyeuthich (user_id, masp) VALUES
(1, 1),
(2, 3),
(3, 4),
(4, 2),
(5, 5);