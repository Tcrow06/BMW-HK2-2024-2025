# ĐỀ TÀI

## TRANG WEB BÁN HÀNG THỜI TRANG - Nhóm 14

### Thành viên thực hiện:
- **Nguyễn Đức Sang** - 22110404
- **Lương Quang Thịnh** - 22110428
- **Nguyễn Công Quý** - 22110403
- **Phạm Tiến Anh** - 22110282
- **Nguyễn Hoàng Thùy Linh** - 22110364

---

# 🚀 Hướng Dẫn Cài Đặt và Chạy Dự Án

## 🛠 Yêu Cầu Hệ Thống

Trước khi chạy dự án, hãy đảm bảo bạn đã cài đặt các công cụ sau:

- **Docker** (phiên bản mới nhất) - [📥 Tải Docker](https://www.docker.com/get-started)
- **JDK 21** - [📥 Tải JDK 21](https://www.oracle.com/java/technologies/javase/jdk21-archive-downloads.html)
- **Maven 3.9.9** - [📥 Tải Maven 3.9.9](https://drive.google.com/drive/u/0/folders/1CpC8sUWQmw2C9Fo0OBp1TaVj5un91SHq?fbclid=IwAR0pkpiKBvCjs0vgaeDgoD-TvgRsO-eNR4pzoPCq7FNDEYCuV7ITlowkiuk)

## 📥 Clone Repository (Sao Chép Mã Nguồn)

Chạy lệnh sau để lấy mã nguồn từ GitHub:

```sh
git clone https://github.com/Tcrow06/BMW-HK2-2024-2025
cd BMW-HK2-2024-2025
```

- `git clone`: Sao chép toàn bộ mã nguồn từ kho GitHub về máy.
- `cd BMW-HK2-2024-2025`: Di chuyển vào thư mục dự án.

## 🔨 Xây Dựng Dự Án (Build)

Chạy lệnh sau để biên dịch và đóng gói dự án bằng Maven:

```sh
mvn clean package
```

- `mvn clean`: Xóa các file build cũ để đảm bảo build sạch.
- `mvn package`: Đóng gói ứng dụng thành tệp `.war` để chạy.

## 🐳 Chạy Dự Án bằng Docker

### Tạo Image và Chạy Container

```sh
docker-compose up -d --build
```

- `docker-compose up`: Khởi động ứng dụng dựa trên file `docker-compose.yml`.
- `-d`: Chạy ứng dụng ở chế độ nền (background mode).
- `--build`: Xây dựng lại image trước khi chạy container.

## 🌍 Truy Cập Ứng Dụng

Sau khi chạy thành công, bạn có thể truy cập ứng dụng tại:

```
http://localhost:8080
```

## ⚠ Xử Lý Sự Cố

- Kiểm tra Docker có đang chạy không trước khi thực hiện các lệnh Docker.
- Kiểm tra phiên bản JDK đang sử dụng:
  ```sh
  java -version
  ```
- Kiểm tra phiên bản Maven:
  ```sh
  mvn -version
  ```
- Nếu cổng `8080` đã được sử dụng, thay đổi trong `application.properties` hoặc sử dụng tham số `-p 8081:8080` khi chạy Docker.

---

## 🖼 Hình Ảnh Minh Họa

Dưới đây là một số hình ảnh về giao diện của dự án:

![Trang chủ](images/homepage.png)
*Giao diện trang chủ của ứng dụng.*

![Trang sản phẩm](images/products.png)
*Danh sách sản phẩm được hiển thị trên website.*

![Trang chi tiết sản phẩm](images/productdetail.png)
*Giao diện chi tiết sản phẩm.*

![Trang giỏ hàng](images/cart.png)
*Giao diện giỏ hàng khi người dùng thêm sản phẩm.*

... Còn nhiều giao diện khác nữa 

✅ **Cảm ơn bạn đã sử dụng phần mềm! Chúc bạn cài đặt thành công!** 🚀

