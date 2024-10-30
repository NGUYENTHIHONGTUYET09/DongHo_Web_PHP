-- Tạo cơ sở dữ liệu
-- CREATE DATABASE IF NOT EXISTS qlbh;

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
    masp VARCHAR(255) NOT NULL,
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
('Áo Khoác', 'Việt Nam'),
('Áo Thun', 'Việt Nam'),
('Áo Sơ Mi', 'Việt Nam'),
('Quần', 'Việt Nam'),
('Đầm Váy', 'Việt Nam'),
('Giày Phụ Kiện', 'Việt Nam');
-- Thêm dữ liệu mẫu cho bảng sản phẩm
DELETE FROM sanpham; -- để làm lại sản phẩm


--- update thử cps masp
ALTER TABLE sanpham ADD masp INT;


INSERT INTO sanpham (tensp, gia, baohanh, trongluong, chatlieu, chongnuoc, nangluong, loaibh, kichthuoc, mau, danhcho, phukien, khuyenmai, tinhtrang, madm, anhchinh, masp) VALUES
('Áo Khoác Denim', 600000.00, '6 tháng', '300g', 'Denim', 'Không', 'N/A', 'Nam', 'M', 'Xanh', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 1, 'images/clothes/ao_khoac_denim.jpg', 1),
('Áo Thun Cổ Tròn', 250000.00, '1 năm', '200g', 'Cotton', 'Không', 'N/A', 'Nam', 'L', 'Đen', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 1, 'images/clothes/ao_thun_co_tron.jpg', 2),
('Quần Jeans Rách', 500000.00, '1 năm', '400g', 'Jean', 'Không', 'N/A', 'Nam', '32', 'Xanh', 'Nam', 'Thắt lưng', 'Giảm 15%', 'Mới', 2, 'images/clothes/quan_jeans_rach.jpg', 3),
('Áo Sơ Mi Trắng', 450000.00, '1 năm', '250g', 'Cotton', 'Không', 'N/A', 'Nam', 'M', 'Trắng', 'Nam', 'Nón', 'Giảm 20%', 'Mới', 2, 'images/clothes/ao_so_mi_trang.jpg', 4),
('Quần Short Thể Thao', 300000.00, '1 năm', '150g', 'Polyester', 'Không', 'N/A', 'Nam', 'M', 'Đen', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 2, 'images/clothes/quan_short_the_thao.jpg', 5),
('Áo Hoodie Nỉ', 700000.00, '1 năm', '500g', 'Nỉ', 'Không', 'N/A', 'Nam', 'L', 'Xám', 'Nam', 'Nón', 'Giảm 15%', 'Mới', 3, 'images/clothes/ao_hoodie_ni.jpg', 6),
('Áo Polo Thể Thao', 350000.00, '6 tháng', '250g', 'Cotton', 'Không', 'N/A', 'Nam', 'M', 'Xanh lá', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/clothes/ao_polo_the_thao.jpg', 7),
('Quần Baggy Nữ', 400000.00, '1 năm', '300g', 'Cotton', 'Không', 'N/A', 'Nữ', 'M', 'Đen', 'Nữ', 'Thắt lưng', 'Giảm 10%', 'Mới', 3, 'images/clothes/quan_baggy_nu.jpg', 8),
('Đầm Maxi Hoa', 800000.00, '1 năm', '200g', 'Lụa', 'Không', 'N/A', 'Nữ', 'L', 'Đỏ', 'Nữ', 'Nón', 'Giảm 15%', 'Mới', 4, 'images/clothes/dam_maxi_hoa.jpg', 9),
('Áo Thun Nữ Cổ V', 300000.00, '1 năm', '150g', 'Cotton', 'Không', 'N/A', 'Nữ', 'S', 'Hồng', 'Nữ', 'Nón', 'Giảm 5%', 'Mới', 4, 'images/clothes/ao_thun_nu_co_v.jpg', 10),
('Chân Váy Midi', 450000.00, '1 năm', '250g', 'Lụa', 'Không', 'N/A', 'Nữ', 'M', 'Đen', 'Nữ', 'Thắt lưng', 'Giảm 10%', 'Mới', 4, 'images/clothes/chan_vay_midi.jpg', 11),
('Áo Khoác Dạ Nữ', 900000.00, '1 năm', '800g', 'Dạ', 'Không', 'N/A', 'Nữ', 'M', 'Be', 'Nữ', 'Nón', 'Giảm 20%', 'Mới', 5, 'images/clothes/ao_khoac_da_nu.jpg', 12),
('Quần Kaki Nữ', 500000.00, '1 năm', '300g', 'Kaki', 'Không', 'N/A', 'Nữ', 'L', 'Xanh', 'Nữ', 'Thắt lưng', 'Giảm 15%', 'Mới', 5, 'images/clothes/quan_kaki_nu.jpg', 13),
('Áo Sơ Mi Nữ', 350000.00, '1 năm', '200g', 'Cotton', 'Không', 'N/A', 'Nữ', 'M', 'Trắng', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 5, 'images/clothes/ao_so_mi_nu.jpg', 14),
('Đầm Dạ Hội', 1200000.00, '1 năm', '600g', 'Lụa', 'Không', 'N/A', 'Nữ', 'L', 'Xanh', 'Nữ', 'Nón', 'Giảm 20%', 'Mới', 6, 'images/clothes/dam_da_hoi.jpg', 15),
('Áo Len Nam', 650000.00, '6 tháng', '400g', 'Len', 'Không', 'N/A', 'Nam', 'M', 'Xám', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 1, 'images/clothes/ao_len_nam.jpg', 16),
('Quần Tây Nam', 700000.00, '1 năm', '350g', 'Kaki', 'Không', 'N/A', 'Nam', '32', 'Đen', 'Nam', 'Thắt lưng', 'Giảm 15%', 'Mới', 2, 'images/clothes/quan_tay_nam.jpg', 17),
('Áo Dài Nữ', 1500000.00, '1 năm', '500g', 'Lụa', 'Không', 'N/A', 'Nữ', 'L', 'Tím', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 4, 'images/clothes/ao_dai_nu.jpg', 18),
('Áo Khoác Gió', 800000.00, '1 năm', '450g', 'Polyester', 'Có', 'N/A', 'Nam', 'L', 'Đỏ', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/clothes/ao_khoac_gio.jpg', 19),
('Quần Jeans Skinny', 550000.00, '1 năm', '350g', 'Jean', 'Không', 'N/A', 'Nữ', 'S', 'Xanh', 'Nữ', 'Thắt lưng', 'Giảm 15%', 'Mới', 5, 'images/clothes/quan_jeans_skinny.jpg', 20),
('Áo Sơ Mi Caro', 400000.00, '6 tháng', '300g', 'Cotton', 'Không', 'N/A', 'Nam', 'L', 'Đỏ', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 2, 'images/clothes/ao_so_mi_caro.jpg', 21),
('Quần Jogger Thể Thao', 450000.00, '1 năm', '400g', 'Polyester', 'Không', 'N/A', 'Nam', 'L', 'Xanh', 'Nam', 'Nón', 'Giảm 20%', 'Mới', 3, 'images/clothes/quan_jogger_the_thao.jpg', 22);
-- thêm 10 sản phẩm nữa
INSERT INTO sanpham (tensp, gia, baohanh, trongluong, chatlieu, chongnuoc, nangluong, loaibh, kichthuoc, mau, danhcho, phukien, khuyenmai, tinhtrang, madm, anhchinh, masp) VALUES
('Áo Khoác Bomber', 750000.00, '6 tháng', '450g', 'Nylon', 'Có', 'N/A', 'Nam', 'M', 'Đen', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 1, 'images/clothes/ao_khoac_bomber.jpg', 23),
('Quần Chạy Bộ', 350000.00, '1 năm', '200g', 'Chất liệu thể thao', 'Không', 'N/A', 'Nam', 'L', 'Xanh biển', 'Nam', 'Nón', 'Giảm 15%', 'Mới', 1, 'images/clothes/quan_chay_bo.jpg', 24),
('Áo Sơ Mi Kẻ Sọc', 500000.00, '1 năm', '250g', 'Cotton', 'Không', 'N/A', 'Nam', 'M', 'Xanh', 'Nam', 'Nón', 'Giảm 20%', 'Mới', 2, 'images/clothes/ao_so_mi_ke_soc.jpg', 25),
('Quần Legging Nữ', 300000.00, '6 tháng', '150g', 'Polyester', 'Không', 'N/A', 'Nữ', 'M', 'Đen', 'Nữ', 'Nón', 'Giảm 5%', 'Mới', 4, 'images/clothes/quan_legging_nu.jpg', 26),
('Áo T-Shirt Nữ', 200000.00, '1 năm', '100g', 'Cotton', 'Không', 'N/A', 'Nữ', 'S', 'Hồng', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 4, 'images/clothes/ao_tshirt_nu.jpg', 27),
('Giày Thể Thao Nam', 1200000.00, '1 năm', '800g', 'Da tổng hợp', 'Không', 'N/A', 'Nam', '41', 'Trắng', 'Nam', 'Nón', 'Giảm 15%', 'Mới', 3, 'images/clothes/giay_the_thao_nam.jpg', 28),
('Giày Sandal Nữ', 800000.00, '1 năm', '600g', 'Da', 'Không', 'N/A', 'Nữ', '38', 'Đen', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 5, 'images/clothes/giay_sandal_nu.jpg', 29),
('Áo Khoác Mùa Đông', 1200000.00, '1 năm', '700g', 'Vải giữ nhiệt', 'Có', 'N/A', 'Nam', 'L', 'Xám', 'Nam', 'Nón', 'Giảm 20%', 'Mới', 6, 'images/clothes/ao_khoac_mua_dong.jpg', 30),
('Quần Tập Gym', 400000.00, '1 năm', '300g', 'Chất liệu thể thao', 'Không', 'N/A', 'Nữ', 'M', 'Đen', 'Nữ', 'Nón', 'Giảm 15%', 'Mới', 5, 'images/clothes/quan_tap_gym.jpg', 31),
('Đầm Maxi Trễ Vai', 900000.00, '1 năm', '400g', 'Lụa', 'Không', 'N/A', 'Nữ', 'L', 'Xanh', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 4, 'images/clothes/dam_maxi_tre_vai.jpg', 32);



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



INSERT INTO sanpham (tensp, gia, baohanh, trongluong, chatlieu, chongnuoc, nangluong, loaibh, kichthuoc, mau, danhcho, phukien, khuyenmai, tinhtrang, madm, anhchinh, masp) VALUES
-- Áo Khoác
('Áo Khoác Denim', 600000.00, '6 tháng', '300g', 'Denim', 'Không', 'N/A', 'Nam', 'M', 'Xanh', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 1, 'images/ao_khoac/ao_khoac_denim.jpg', 1),
('Áo Hoodie Nỉ', 700000.00, '1 năm', '500g', 'Nỉ', 'Không', 'N/A', 'Nam', 'L', 'Xám', 'Nam', 'Nón', 'Giảm 15%', 'Mới', 3, 'images/ao_khoac/ao_hoodie_ni.jpg', 6),
('Áo Khoác Dạ Nữ', 900000.00, '1 năm', '800g', 'Dạ', 'Không', 'N/A', 'Nữ', 'M', 'Be', 'Nữ', 'Nón', 'Giảm 20%', 'Mới', 5, 'images/ao_khoac/ao_khoac_da_nu.jpg', 12),
('Áo Khoác Gió', 800000.00, '1 năm', '450g', 'Polyester', 'Có', 'N/A', 'Nam', 'L', 'Đỏ', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/ao_khoac/ao_khoac_gio.jpg', 19),
('Áo Khoác Bomber', 750000.00, '6 tháng', '450g', 'Nylon', 'Có', 'N/A', 'Nam', 'M', 'Đen', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 1, 'images/ao_khoac/ao_khoac_bomber.jpg', 23),
('Áo Len Nam', 650000.00, '6 tháng', '400g', 'Len', 'Không', 'N/A', 'Nam', 'M', 'Be', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 1, 'images/ao_khoac/ao_len_nam.jpg', 25),

-- Áo Sơ Mi
('Áo Sơ Mi Trắng', 450000.00, '1 năm', '250g', 'Cotton', 'Không', 'N/A', 'Nam', 'M', 'Trắng', 'Nam', 'Nón', 'Giảm 20%', 'Mới', 2, 'images/ao_so_mi/ao_so_mi_trang.jpg', 4),
('Áo Sơ Mi Nữ', 350000.00, '1 năm', '200g', 'Cotton', 'Không', 'N/A', 'Nữ', 'M', 'Trắng', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 5, 'images/ao_so_mi/ao_so_mi_nu.jpg', 14),
('Áo Sơ Mi Caro', 400000.00, '6 tháng', '300g', 'Cotton', 'Không', 'N/A', 'Nam', 'L', 'Đỏ', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 2, 'images/ao_so_mi/ao_so_mi_caro.jpg', 21),
('Áo Sơ Mi Ke Soc', 400000.00, '6 tháng', '300g', 'Cotton', 'Không', 'N/A', 'Nam', 'L', 'Đỏ', 'Nam', 'Không nón', 'Giảm 10%', 'Mới', 2, 'images/ao_so_mi/ao_so_mi_caro.jpg', 21),

-- Áo Thun
('Áo Thun Cổ Tròn', 250000.00, '1 năm', '200g', 'Cotton', 'Không', 'N/A', 'Nam', 'L', 'Đen', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 1, 'images/ao_thun_Tshirt/ao_thun_co_tron.jpg', 2),
('Áo Thun Nữ Cổ V', 300000.00, '1 năm', '150g', 'Cotton', 'Không', 'N/A', 'Nữ', 'S', 'Hồng', 'Nữ', 'Nón', 'Giảm 5%', 'Mới', 4, 'images/ao_thun_Tshirt/ao_thun_nu_co_v.jpg', 10),
('Áo Thun Dài Tay', 400000.00, '1 năm', '250g', 'Cotton', 'Không', 'N/A', 'Nam', 'M', 'Xám', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 1, 'images/ao_thun_Tshirt/ao_thun_tay_dai.jpg', 27),
('Áo Thun Unisex', 350000.00, '6 tháng', '200g', 'Cotton', 'Không', 'N/A', 'Unisex', 'L', 'Trắng', 'Nam, Nữ', 'Nón', 'Giảm 10%', 'Mới', 2, 'images/ao_thun_Tshirt/ao_tshirt_nu.jpg', 31),
('Áo Polo Thể Thao', 350000.00, '6 tháng', '250g', 'Cotton', 'Không', 'N/A', 'Nam', 'M', 'Xanh lá', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/ao_thun_Tshirt/ao_polo_the_thao.jpg', 7),
('Áo Hoodie Nỉ', 350000.00, '6 tháng', '250g', 'Nỉ', 'Không', 'N/A', 'Nam', 'M', 'Xanh lá', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/ao_thun_Tshirt/ao_hoodie_ni.jpg', 7),

-- Quần
('Quần Jeans Rách', 500000.00, '1 năm', '400g', 'Jean', 'Không', 'N/A', 'Nam', '32', 'Xanh', 'Nam', 'Thắt lưng', 'Giảm 15%', 'Mới', 2, 'images/quan/quan_jeans_rach.jpg', 3),
('Quần Kaki Nữ', 500000.00, '1 năm', '300g', 'Kaki', 'Không', 'N/A', 'Nữ', 'L', 'Xanh', 'Nữ', 'Thắt lưng', 'Giảm 15%', 'Mới', 5, 'images/quan/quan_kaki_nu.jpg', 13),
('Quần Tây Nam', 700000.00, '1 năm', '350g', 'Kaki', 'Không', 'N/A', 'Nam', '32', 'Đen', 'Nam', 'Thắt lưng', 'Giảm 15%', 'Mới', 2, 'images/quan/quan_tay_nam.jpg', 17),
('Quần Jeans Skinny', 550000.00, '1 năm', '350g', 'Jean', 'Không', 'N/A', 'Nữ', 'S', 'Xanh', 'Nữ', 'Thắt lưng', 'Giảm 15%', 'Mới', 5, 'images/quan/quan_jeans_skinny.jpg', 20),
('Quần Short Thể Thao', 300000.00, '1 năm', '150g', 'Polyester', 'Không', 'N/A', 'Nam', 'M', 'Đen', 'Nam', 'Nón', 'Giảm 10%', 'Mới', 2, 'images/quan/quan_short_the_thao.jpg', 5),
('Quần Jogger Thể Thao', 450000.00, '1 năm', '400g', 'Polyester', 'Không', 'N/A', 'Nam', 'L', 'Xanh', 'Nam', 'Nón', 'Giảm 20%', 'Mới', 3, 'images/quan/quan_jogger_the_thao.jpg', 22),
('Quần Chạy Bộ Tập Gym', 350000.00, '1 năm', '200g', 'Chất liệu thể thao', 'Không', 'N/A', 'Nam', 'L', 'Xanh biển', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 2, 'images/quan/quan_chay_bo.jpg', 24),
('Quần Đùi Thể Thao', 250000.00, '1 năm', '150g', 'Polyester', 'Không', 'N/A', 'Nam', 'M', 'Xám', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/quan/quan_tap_gym.jpg', 32),
('Quần Baggy Nữ', 250000.00, '1 năm', '150g', 'Polyester', 'Không', 'N/A', 'Nam', 'M', 'Trắng', 'Nữ', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/quan/quan_baggy_nu.jpg', 32),
('Quần Legging ', 250000.00, '1 năm', '150g', 'Polyester', 'Không', 'N/A', 'Nam', 'M', 'Xám', 'Nam', 'Nón', 'Giảm 5%', 'Mới', 3, 'images/quan/quan_legging_nu.jpg', 32),

-- Đầm Váy
('Đầm Maxi Hoa', 800000.00, '1 năm', '200g', 'Lụa', 'Không', 'N/A', 'Nữ', 'M', 'Hồng', 'Nữ', 'Nón', 'Giảm 20%', 'Mới', 5, 'images/dam_vay/dam_maxi_hoa.jpg', 8),
('Đầm Dự Tiệc', 900000.00, '1 năm', '400g', 'Lụa', 'Không', 'N/A', 'Nữ', 'L', 'Đen', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 5, 'images/dam_vay/dam_da_hoi.jpg', 11),
('Đầm Suông Trẻ Trung', 600000.00, '6 tháng', '350g', 'Cotton', 'Không', 'N/A', 'Nữ', 'M', 'Trắng', 'Nữ', 'Nón', 'Giảm 15%', 'Mới', 5, 'images/dam_vay/dam_maxi_tre_vai.jpg', 15),
('Đầm Xòe Vinatge', 800000.00, '1 năm', '200g', 'Lụa', 'Không', 'N/A', 'Nữ', 'M', 'Hồng', 'Nữ', 'Nón', 'Giảm 20%', 'Mới', 5, 'images/dam_vay/dam_xoe_vintage.jpg', 8),
('Áo Dài Nữ', 900000.00, '1 năm', '400g', 'Lụa', 'Không', 'N/A', 'Nữ', 'L', 'Đen', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 5, 'images/dam_vay/ao_dai_nu.jpg', 11),
('Đầm Maxi Trễ Vai', 600000.00, '6 tháng', '350g', 'Cotton', 'Không', 'N/A', 'Nữ', 'M', 'Trắng', 'Nữ', 'Nón', 'Giảm 15%', 'Mới', 5, 'images/dam_vay/dam_suong_tre_trung.jpg', 15),

-- Phụ Kiện
('Nón Lưỡi Trai', 200000.00, '6 tháng', '100g', 'Cotton', 'Không', 'N/A', 'Unisex', 'N/A', 'Đen', 'Nam, Nữ', 'Nón', 'Giảm 10%', 'Mới', 4, 'images/phu_kien/non_luoi_trai.jpg', 9),
('Thắt Lưng Da', 250000.00, '1 năm', '150g', 'Da', 'Không', 'N/A', 'Unisex', 'N/A', 'Nâu', 'Nam, Nữ', 'Nón', 'Giảm 5%', 'Mới', 4, 'images/phu_kien/that_lung_da.jpg', 16),
('Kính Mát Thời Trang', 300000.00, '1 năm', '50g', 'Nhựa', 'Không', 'N/A', 'Unisex', 'N/A', 'Đen', 'Nam, Nữ', 'Nón', 'Giảm 15%', 'Mới', 4, 'images/phu_kien/kinh_mat_thoi_trang.jpg', 28),
('Vòng Tay Thời Trang', 150000.00, '6 tháng', '50g', 'Kim loại', 'Không', 'N/A', 'Nữ', 'N/A', 'Vàng', 'Nữ', 'Nón', 'Giảm 10%', 'Mới', 5, 'images/phu_kien/vong_tay_thoi_trang.png', 29)



