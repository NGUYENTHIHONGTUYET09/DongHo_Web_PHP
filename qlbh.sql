-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS qlbh;

-- Sử dụng cơ sở dữ liệu vừa tạo
USE qlbh;


-- Tạo bảng categories để lưu trữ thông tin danh mục sản phẩm
CREATE TABLE IF NOT EXISTS danhmucsp (
    madm INT AUTO_INCREMENT PRIMARY KEY,   -- Khóa chính
    tendm VARCHAR(100) NOT NULL,         -- Tên danh mục
    xuatsu VARCHAR(100)                   -- Xuất xứ
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng products để lưu trữ thông tin sản phẩm
CREATE TABLE IF NOT EXISTS sanpham (
    masp INT AUTO_INCREMENT PRIMARY KEY,    -- Khóa chính
    tensp VARCHAR(255) NOT NULL,          -- Tên sản phẩm
    gia DECIMAL(10, 2) NOT NULL,          -- Giá sản phẩm
    baohanh VARCHAR(100),                  -- Thời gian bảo hành
    trongluong VARCHAR(100),               -- Trọng lượng
    chatlieu VARCHAR(100),                 -- Chất liệu
    chongnuoc VARCHAR(100),                -- Chống nước
    nangluong VARCHAR(100),                -- Nguồn năng lượng
    loaibh VARCHAR(100),                   -- Loại hàng
    kichthuoc VARCHAR(100),                -- Kích thước
    mau VARCHAR(50),                       -- Màu sắc
    danhcho VARCHAR(100),                  -- Dành cho
    phukien VARCHAR(255),                  -- Phụ kiện
    khuyenmai VARCHAR(255),                -- Khuyến mãi
    tinhtrang VARCHAR(50),                 -- Tình trạng sản phẩm
    madm INT,                              -- ID danh mục (khóa ngoại)
    anhchinh VARCHAR(255),                 -- Ảnh chính sản phẩm
    luotmua INT DEFAULT 0,                -- Số lượt mua
    luotxem INT DEFAULT 0,                 -- Số lượt xem
    ngaytao TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Ngày tạo
    ngay_nhap TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Ngày nhập sản phẩm
    FOREIGN KEY (madm) REFERENCES danhmucsp(madm) ON DELETE CASCADE -- Liên kết với bảng danhmuc
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Tạo bảng giao dịch để lưu trữ thông tin giao dịch
CREATE TABLE IF NOT EXISTS giaodich (
    magd INT AUTO_INCREMENT PRIMARY KEY,        -- Khóa chính
    user_id INT,                               -- ID của người dùng
    user_name VARCHAR(255) NOT NULL,            -- Tên người dùng
    user_dst VARCHAR(100),                       -- Quận
    user_addr VARCHAR(255),                      -- Địa chỉ
    user_phone VARCHAR(15),                      -- Số điện thoại
    tongtien DECIMAL(10, 2) NOT NULL,           -- Tổng tiền
    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    -- Ngày giao dịch
    tinhtrang TINYINT DEFAULT 0                  -- Tình trạng giao dịch (0: chưa giao, 1: đã giao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng chitietgiaodich để lưu trữ thông tin chi tiết giao dịch
CREATE TABLE IF NOT EXISTS chitietgiaodich (
    id INT AUTO_INCREMENT PRIMARY KEY,           -- Khóa chính
    magd INT NOT NULL,                           -- ID giao dịch (khóa ngoại liên kết với bảng giaodich)
    masp INT NOT NULL,                           -- Mã sản phẩm
    soluong INT NOT NULL,                        -- Số lượng sản phẩm
    FOREIGN KEY (magd) REFERENCES giaodich(magd) ON DELETE CASCADE,
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng thanhvien để lưu trữ thông tin thành viên
CREATE TABLE IF NOT EXISTS thanhvien (
    id INT AUTO_INCREMENT PRIMARY KEY,            -- Khóa chính
    ten VARCHAR(255) NOT NULL,                    -- Tên thành viên
    tentaikhoan VARCHAR(100) NOT NULL UNIQUE,     -- Tên tài khoản (độc nhất)
    matkhau VARCHAR(255) NOT NULL,                 -- Mật khẩu
    diachi TEXT,                                   -- Địa chỉ (tùy chọn)
    sodt VARCHAR(15),                              -- Số điện thoại (tùy chọn)
    email VARCHAR(100),                            -- Email (tùy chọn)
    ngaytao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,   -- Ngày tạo tài khoản
    quyen INT DEFAULT 0                            -- Quyền hạn (0: người dùng bình thường, 1: admin)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng giohang để lưu trữ thông tin giỏ hàng
CREATE TABLE IF NOT EXISTS giohang (
    id INT AUTO_INCREMENT PRIMARY KEY,            -- Khóa chính
    user_id INT NOT NULL,                          -- ID của người dùng
    masp INT NOT NULL,                             -- Mã sản phẩm
    soluong INT NOT NULL DEFAULT 1,                -- Số lượng sản phẩm
    FOREIGN KEY (user_id) REFERENCES thanhvien(id) ON DELETE CASCADE,  -- Ràng buộc khóa ngoại
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE          -- Ràng buộc khóa ngoại
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng sanphamyeuthich để lưu trữ thông tin sản phẩm yêu thích
CREATE TABLE IF NOT EXISTS sanphamyeuthich (
    id INT AUTO_INCREMENT PRIMARY KEY,            -- Khóa chính
    user_id INT NOT NULL,                          -- ID của người dùng
    masp INT NOT NULL,                             -- Mã sản phẩm
    FOREIGN KEY (user_id) REFERENCES thanhvien(id) ON DELETE CASCADE,  -- Ràng buộc khóa ngoại
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE          -- Ràng buộc khóa ngoại
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Thêm dữ liệu mẫu cho bảng sản phẩm
CREATE TABLE IF NOT EXISTS sanpham (
    masp INT AUTO_INCREMENT PRIMARY KEY,    -- Khóa chính
    tensp VARCHAR(255) NOT NULL,          -- Tên sản phẩm
    gia DECIMAL(10, 2) NOT NULL,          -- Giá sản phẩm
    baohanh VARCHAR(100),                  -- Thời gian bảo hành
    trongluong VARCHAR(100),               -- Trọng lượng
    chatlieu VARCHAR(100),                 -- Chất liệu
    chongnuoc VARCHAR(100),                -- Chống nước
    nangluong VARCHAR(100),                -- Nguồn năng lượng
    loaibh VARCHAR(100),                   -- Loại hàng
    kichthuoc VARCHAR(100),                -- Kích thước
    mau VARCHAR(50),                       -- Màu sắc
    danhcho VARCHAR(100),                  -- Dành cho
    phukien VARCHAR(255),                  -- Phụ kiện
    khuyenmai VARCHAR(255),                -- Khuyến mãi
    tinhtrang VARCHAR(50),                 -- Tình trạng sản phẩm
    madm INT,                              -- ID danh mục (khóa ngoại)
    anhchinh VARCHAR(255),                 -- Ảnh chính sản phẩm
    luotmua INT DEFAULT 0,                -- Số lượt mua
    luotxem INT DEFAULT 0,                 -- Số lượt xem
    ngaytao TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Ngày tạo
    ngay_nhap TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Ngày nhập sản phẩm
    FOREIGN KEY (madm) REFERENCES danhmucsp(madm) ON DELETE CASCADE -- Liên kết với bảng danhmuc
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



INSERT INTO danhmucsp (madm, tendm) VALUES
(1, 'Đồng hồ cơ'),
(2, 'Đồng hồ pin'),
(3, 'Đồng hồ thời trang'),
(4, 'Đồng hồ thể thao'),
(5, 'Đồng hồ nữ'),
(6, 'Đồng hồ nam')
ON DUPLICATE KEY UPDATE madm = madm; -- Không thêm nếu đã có


INSERT INTO sanpham (tensp, gia, baohanh, trongluong, chatlieu, chongnuoc, nangluong, loaibh, kichthuoc, mau, danhcho, phukien, khuyenmai, tinhtrang, madm, anhchinh) VALUES
('Rolex-Datejust-179174-0031', 25000000.00, '2 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Đen', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/rolex/Rolex-Datejust-179174-0031.png'),
('Rolex-Datejust-179174-0094', 25000000.00, '2 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Đen', 'Nữ', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/rolex/Rolex-Datejust-179174-0094.png'),
('Piaget z3', 1500000.00, '1 năm', '50g', 'Nhựa', '50m', 'Pin', 'Nam', '38mm', 'Trắng', 'Nam', 'Sạc USB', 'Giảm 5%', 'Mới', 2, 'images/piaget/piaget z3.png'),
('Piaget z2', 10000000.00, '1 năm', '50g', 'Nhựa', 'Chống nước', 'Pin', 'Nam/Nữ', '44mm', 'Đen', 'Nam/Nữ', 'Cáp sạc', 'Giảm 15%', 'Mới', 3, 'images/piaget/piaget z2.png'),
('Piaget z1', 3000000.00, '1 năm', '200g', 'Thép không gỉ', '50m', 'Cơ', 'Nam', '42mm', 'Bạc', 'Nam', 'Hộp quà', 'Giảm 20%', 'Mới', 1, 'images/piaget/piaget z1.png'),
('Omega CO', 800000.00, '1 năm', '100g', 'Nhựa', '30m', 'Pin', 'Nam', '40mm', 'Xanh', 'Nam', 'Hộp quà', 'Giảm 5%', 'Mới', 5, 'images/omega/Omega CO.png'),
('Omega 307', 4000000.00, '1 năm', '120g', 'Thép không gỉ', '50m', 'Pin', 'Nữ', '38mm', 'Hồng', 'Nữ', 'Cáp sạc', 'Giảm 15%', 'Mới', 6, 'images/omega/Omega 307.png'),
('Montblanc 1', 3500000.00, '1 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Nâu', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/montblanc/montblanc 1.png'),
('Montblanc 2', 3500000.00, '1 năm', '150g', 'Thép không gỉ', '30m', 'Cơ', 'Nam', '40mm', 'Nâu', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 1, 'images/montblanc/montblanc 2.png')
ON DUPLICATE KEY UPDATE masp=masp; -- Không thêm nếu đã có

INSERT INTO giaodich (user_id, user_name, user_dst, user_addr, user_phone, tongtien, tinhtrang) VALUES
(1, 'Nguyễn Văn A', 'Hà Nội', '123 Đường ABC', '0901234567', 25000000.00, 1),  -- Giao dịch cho đồng hồ Rolex
(2, 'Trần Thị B', 'Hồ Chí Minh', '456 Đường DEF', '0912345678', 1500000.00, 1),  -- Giao dịch cho đồng hồ Piaget z3
(3, 'Lê Văn C', 'Đà Nẵng', '789 Đường GHI', '0923456789', 10000000.00, 1),      -- Giao dịch cho Piaget z2
(1, 'Nguyễn Văn A', 'Hà Nội', '123 Đường ABC', '0901234567', 3000000.00, 0),    -- Giao dịch cho Piaget z1
(2, 'Trần Thị B', 'Hồ Chí Minh', '456 Đường DEF', '0912345678', 4000000.00, 0),  -- Giao dịch cho Omega 307
(3, 'Lê Văn C', 'Đà Nẵng', '789 Đường GHI', '0923456789', 3500000.00, 1)         -- Giao dịch cho Montblanc 2
ON DUPLICATE KEY UPDATE magd=magd;


INSERT INTO thanhvien (ten, tentaikhoan, matkhau, diachi, sodt, email, quyen) VALUES
('Nguyễn Văn A', 'nguyenvana', 'password123', '123 Đường ABC, Hà Nội', '0901234567', 'a@example.com', 0),
('Trần Thị B', 'tranthib', 'password456', '456 Đường DEF, Hồ Chí Minh', '0912345678', 'b@example.com', 0),
('Lê Văn C', 'levanc', 'password789', '789 Đường GHI, Đà Nẵng', '0923456789', 'c@example.com', 1),
('Phạm Minh D', 'phaminhd', 'password101', '321 Đường JKL, Hà Nội', '0934567890', 'd@example.com', 0),
('Nguyễn Thị E', 'nguyenthie', 'password202', '654 Đường MNO, Hồ Chí Minh', '0945678901', 'e@example.com', 1),
('Trần Văn F', 'tranvanf', 'password303', '987 Đường PQR, Đà Nẵng', '0956789012', 'f@example.com', 0)
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có



INSERT INTO giohang (user_id, masp, soluong) VALUES
(1, 1, 2),  -- Người dùng 1 thêm 2 đồng hồ Rolex vào giỏ hàng
(1, 3, 1),  -- Người dùng 1 thêm 1 đồng hồ Piaget z3 vào giỏ hàng
(2, 4, 1),  -- Người dùng 2 thêm 1 đồng hồ Piaget z2 vào giỏ hàng
(3, 5, 3),  -- Người dùng 3 thêm 3 đồng hồ Omega CO vào giỏ hàng
(2, 1, 1),  -- Người dùng 2 thêm 1 đồng hồ Rolex vào giỏ hàng
(3, 6, 1)   -- Người dùng 3 thêm 1 đồng hồ Omega 307 vào giỏ hàng
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có

INSERT INTO chitietgiaodich (magd, masp, soluong) VALUES
(1, 1, 1),  -- Chi tiết giao dịch 1: 1 đồng hồ Rolex
(1, 2, 1),  -- Chi tiết giao dịch 1: 1 đồng hồ Casio
(2, 3, 1),  -- Chi tiết giao dịch 2: 1 đồng hồ Apple Watch
(3, 4, 1),  -- Chi tiết giao dịch 3: 1 đồng hồ Seiko
(3, 5, 1),  -- Chi tiết giao dịch 3: 1 đồng hồ Garmin
(4, 1, 1),  -- Chi tiết giao dịch 4: 1 đồng hồ Rolex
(5, 2, 1)   -- Chi tiết giao dịch 5: 1 đồng hồ Casio
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có

INSERT INTO sanphamyeuthich (user_id, masp) VALUES
(1, 1),  -- Người dùng 1 thích đồng hồ Rolex
(1, 2),  -- Người dùng 1 thích đồng hồ Casio
(2, 3),  -- Người dùng 2 thích đồng hồ Apple Watch
(3, 1),  -- Người dùng 3 thích đồng hồ Rolex
(3, 4),  -- Người dùng 3 thích đồng hồ Seiko
(2, 5)   -- Người dùng 2 thích đồng hồ Garmin
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có