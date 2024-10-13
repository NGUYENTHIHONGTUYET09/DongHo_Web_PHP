-- Tạo cơ sở dữ liệu nếu chưa tồn tại
CREATE DATABASE IF NOT EXISTS qlbh;

-- Sử dụng cơ sở dữ liệu vừa tạo
USE qlbh;

-- Tạo bảng danh mục sản phẩm
CREATE TABLE IF NOT EXISTS danhmucsp (
    madm INT AUTO_INCREMENT PRIMARY KEY,   -- Khóa chính
    tendm VARCHAR(100) NOT NULL,          -- Tên danh mục
    xuatsu VARCHAR(100)                    -- Xuất xứ
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng sanpham
CREATE TABLE IF NOT EXISTS sanpham (
    masp INT AUTO_INCREMENT PRIMARY KEY,            -- Khóa chính
    tensp VARCHAR(255) NOT NULL,                    -- Tên sản phẩm
    giaban DECIMAL(10, 2) NOT NULL,                 -- Giá bán
    thoihan VARCHAR(100),                           -- Thời gian bảo hành
    trongluong VARCHAR(100),                        -- Trọng lượng
    chatlieu VARCHAR(100),                          -- Chất liệu
    dochihang VARCHAR(100),                         -- Độ chịu nước
    loai VARCHAR(100),                              -- Loại sản phẩm
    kichthuoc VARCHAR(100),                         -- Kích thước
    mau VARCHAR(100),                               -- Màu sắc
    gioitinh VARCHAR(100),                          -- Giới tính
    phu_kien VARCHAR(100),                          -- Phụ kiện đi kèm
    khuyenmai VARCHAR(100),                         -- Khuyến mãi
    trangthai VARCHAR(100),                         -- Trạng thái
    danhgia INT,                                    -- Đánh giá
    hinh VARCHAR(255),                              -- Hình ảnh
    ngaytao DATE,                                   -- Ngày tạo
    luotmua INT DEFAULT 0,                           -- Số lượt mua
    madm INT,                                        -- Khóa ngoại liên kết với bảng danhmucsp
    FOREIGN KEY (madm) REFERENCES danhmucsp(madm) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Thêm dữ liệu mẫu cho bảng danh mục sản phẩm
INSERT INTO danhmucsp (tendm, xuatsu) VALUES
('Đồng hồ cơ', 'Nhật Bản'),
('Đồng hồ điện tử', 'Thụy Sĩ'),
('Đồng hồ thông minh', 'Mỹ'),
('Đồng hồ thể thao', 'Trung Quốc'),
('Đồng hồ thời trang', 'Ý'),
('Đồng hồ giá rẻ', 'Việt Nam'),
('Đồng hồ cao cấp', 'Thụy Sĩ'),
('Đồng hồ thông minh thể thao', 'Mỹ')
ON DUPLICATE KEY UPDATE madm=madm; -- Không thêm nếu đã có

-- Tạo bảng giao dịch
CREATE TABLE IF NOT EXISTS giaodich (
    magd INT AUTO_INCREMENT PRIMARY KEY,           -- Khóa chính
    nguoimua VARCHAR(255) NOT NULL,                -- Người mua
    ngaygiaodich DATETIME NOT NULL,                -- Ngày giao dịch
    tongtien DECIMAL(10, 2) NOT NULL               -- Tổng tiền
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng chi tiết giao dịch
CREATE TABLE IF NOT EXISTS chitietgiaodich (
    id INT AUTO_INCREMENT PRIMARY KEY,               -- Khóa chính
    magd INT NOT NULL,                               -- ID giao dịch (khóa ngoại liên kết với bảng giaodich)
    masp INT NOT NULL,                               -- Mã sản phẩm (khóa ngoại liên kết với bảng sanpham)
    soluong INT NOT NULL,                            -- Số lượng sản phẩm
    FOREIGN KEY (magd) REFERENCES giaodich(magd) ON DELETE CASCADE,
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng thành viên
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

-- Tạo bảng giỏ hàng
CREATE TABLE IF NOT EXISTS giohang (
    id INT AUTO_INCREMENT PRIMARY KEY,            -- Khóa chính
    user_id INT NOT NULL,                          -- ID của người dùng
    masp INT NOT NULL,                             -- Mã sản phẩm
    soluong INT NOT NULL DEFAULT 1,                -- Số lượng sản phẩm
    FOREIGN KEY (user_id) REFERENCES thanhvien(id) ON DELETE CASCADE,  -- Ràng buộc khóa ngoại
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE          -- Ràng buộc khóa ngoại
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tạo bảng sản phẩm yêu thích
CREATE TABLE IF NOT EXISTS sanphamyeuthich (
    id INT AUTO_INCREMENT PRIMARY KEY,            -- Khóa chính
    user_id INT NOT NULL,                          -- ID của người dùng
    masp INT NOT NULL,                             -- Mã sản phẩm
    FOREIGN KEY (user_id) REFERENCES thanhvien(id) ON DELETE CASCADE,  -- Ràng buộc khóa ngoại
    FOREIGN KEY (masp) REFERENCES sanpham(masp) ON DELETE CASCADE          -- Ràng buộc khóa ngoại
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Thêm dữ liệu mẫu cho bảng sản phẩm
INSERT INTO sanpham (tensp, giaban, thoihan, trongluong, chatlieu, dochihang, loai, kichthuoc, mau, gioitinh, phu_kien, khuyenmai, trangthai, danhgia, hinh, ngaytao, madm) VALUES
('Đồng hồ Rolex', 25000000.00, '2 năm', '150g', 'Thép không gỉ', '30m', 'Nam', '40mm', 'Đen', 'Nam', 'Hộp quà', 'Giảm 10%', 'Mới', 5, 'rolex.jpg', '2024-10-10', 1),
('Đồng hồ Casio', 1500000.00, '1 năm', '50g', 'Nhựa', '50m', 'Nam', '38mm', 'Trắng', 'Nam', 'Sạc USB', 'Giảm 5%', 'Mới', 4, 'casio.jpg', '2024-10-10', 2),
('Đồng hồ Apple Watch', 10000000.00, '1 năm', '50g', 'Nhựa', 'Chống nước', 'Nam/Nữ', '44mm', 'Đen', 'Nam/Nữ', 'Cáp sạc', 'Giảm 15%', 'Mới', 4, 'apple_watch.jpg', '2024-10-10', 3),
('Đồng hồ Seiko', 3000000.00, '1 năm', '200g', 'Thép không gỉ', '50m', 'Nam', '42mm', 'Bạc', 'Nam', 'Hộp quà', 'Giảm 20%', 'Mới', 5, 'seiko.jpg', '2024-10-10', 1),
('Đồng hồ Garmin', 5000000.00, '2 năm', '180g', 'Nhựa', 'Chống nước', 'Nam/Nữ', '45mm', 'Đen', 'Nam/Nữ', 'Cáp sạc', 'Giảm 10%', 'Mới', 4, 'garmin.jpg', '2024-10-10', 4),
('Đồng hồ Timex', 1200000.00, '1 năm', '150g', 'Nhựa', '30m', 'Pin', 'Nữ', '38mm', 'Hồng', 'Nữ', 'Hộp quà', 'Giảm 5%', 'Mới', 4, 'timex.jpg', '2024-10-10', 2),
('Đồng hồ Citizen', 4000000.00, '1 năm', '150g', 'Thép không gỉ', '100m', 'Nam', '40mm', 'Đen', 'Nam', 'Hộp quà', 'Giảm 15%', 'Mới', 5, 'citizen.jpg', '2024-10-10', 3)
ON DUPLICATE KEY UPDATE masp=masp; -- Không thêm nếu đã có

-- Thêm dữ liệu mẫu cho bảng thành viên
INSERT INTO thanhvien (ten, tentaikhoan, matkhau, diachi, sodt, email, quyen) VALUES
('Nguyễn Văn A', 'nguyenvana', 'password1', 'Hà Nội', '0123456789', 'vana@gmail.com', 0),
('Trần Thị B', 'tranthib', 'password2', 'Đà Nẵng', '0987654321', 'thib@gmail.com', 0),
('Nguyễn Thị C', 'nguyenthic', 'password3', 'Hồ Chí Minh', '0912345678', 'thic@gmail.com', 1)
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có

-- Thêm dữ liệu mẫu cho bảng giao dịch
INSERT INTO giaodich (nguoimua, ngaygiaodich, tongtien) VALUES
('Nguyễn Văn A', '2024-10-10 10:00:00', 20000000.00),
('Trần Thị B', '2024-10-11 15:30:00', 5000000.00)
ON DUPLICATE KEY UPDATE magd=magd; -- Không thêm nếu đã có

-- Thêm dữ liệu mẫu cho bảng chi tiết giao dịch
INSERT INTO chitietgiaodich (magd, masp, soluong) VALUES
(1, 1, 2), -- 2 sản phẩm Rolex
(1, 3, 1), -- 1 sản phẩm Apple Watch
(2, 2, 3)  -- 3 sản phẩm Casio
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có

-- Thêm dữ liệu mẫu cho bảng giỏ hàng
INSERT INTO giohang (user_id, masp, soluong) VALUES
(1, 3, 1), -- Người dùng A thêm Apple Watch vào giỏ hàng
(2, 4, 1)  -- Người dùng B thêm Seiko vào giỏ hàng
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có

-- Thêm dữ liệu mẫu cho bảng sản phẩm yêu thích
INSERT INTO sanphamyeuthich (user_id, masp) VALUES
(1, 1), -- Người dùng A yêu thích sản phẩm Rolex
(1, 2), -- Người dùng A yêu thích sản phẩm Casio
(2, 3)  -- Người dùng B yêu thích sản phẩm Apple Watch
ON DUPLICATE KEY UPDATE id=id; -- Không thêm nếu đã có

----
-- add quan trọng phải có
DESCRIBE sanpham;
ALTER TABLE sanpham ADD COLUMN luotmua INT DEFAULT 0;

SELECT sp.*
FROM sanpham sp
ORDER BY sp.luotmua DESC;

-- test
SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME = 'ngay_nhap' 
AND TABLE_SCHEMA = 'qlbh';  -- Thay 'qlbh' bằng tên cơ sở dữ liệu của bạn

-- add quan trọng nhé
ALTER TABLE sanpham ADD COLUMN ngay_nhap DATE;


