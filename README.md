# HỆ THỐNG THƯƠNG MẠI ĐIỆN TỬ
## Mô hình phân tán dữ liệu (SQL Server & MongoDB)

## 1. Giới thiệu đề tài
Sự phát triển nhanh chóng của thương mại điện tử đòi hỏi các hệ thống thông tin phải xử lý khối lượng dữ liệu lớn, đa dạng và có khả năng phục vụ nhiều người dùng đồng thời. Trong bối cảnh đó, việc áp dụng **mô hình phân tán dữ liệu** kết hợp giữa **cơ sở dữ liệu quan hệ (SQL Server)** và **cơ sở dữ liệu NoSQL (MongoDB)** giúp tận dụng ưu điểm của từng loại hệ quản trị cơ sở dữ liệu.

Đề tài này xây dựng **hệ thống thương mại điện tử** trong đó dữ liệu được phân tán và lưu trữ trên nhiều nền tảng khác nhau:
- **SQL Server** dùng để quản lý dữ liệu có cấu trúc, yêu cầu tính toàn vẹn và nhất quán cao như người dùng, đơn hàng, thanh toán.
- **MongoDB** dùng để lưu trữ dữ liệu phi cấu trúc hoặc bán cấu trúc như thông tin sản phẩm, mô tả chi tiết, lịch sử truy cập và log hệ thống.

---

## 2. Mục tiêu nghiên cứu
- Thiết kế và triển khai hệ thống thương mại điện tử theo **mô hình phân tán dữ liệu đa CSDL**.
- Kết hợp hiệu quả giữa **SQL Server và MongoDB** trong cùng một hệ thống.
- Đảm bảo các yêu cầu về:
    - Tính nhất quán dữ liệu.
    - Hiệu năng truy vấn.
    - Khả năng mở rộng và chịu lỗi.
- Đánh giá khả năng hoạt động của mô hình phân tán so với mô hình lưu trữ tập trung truyền thống.

---

## 3. Phương pháp thực hiện
- **Phân tích nghiệp vụ** của hệ thống thương mại điện tử (quản lý người dùng, sản phẩm, đơn hàng).
- **Thiết kế kiến trúc phân tán**, xác định rõ:
    - Phân vùng dữ liệu lưu trên SQL Server.
    - Phân vùng dữ liệu lưu trên MongoDB.
- **Triển khai hệ thống** với các thành phần:
    - Backend xử lý nghiệp vụ và kết nối đa CSDL.
    - Cơ chế đồng bộ và tích hợp dữ liệu giữa các hệ quản trị.
- **Thực nghiệm và đánh giá** thông qua các kịch bản tải cao, truy vấn đồng thời và so sánh hiệu năng.

---

## 4. Kết quả đạt được
- Xây dựng thành công hệ thống thương mại điện tử sử dụng **mô hình phân tán dữ liệu kết hợp SQL Server và MongoDB**.
- Hệ thống đáp ứng tốt các yêu cầu về:
    - Quản lý dữ liệu nhất quán cho các nghiệp vụ cốt lõi.
    - Linh hoạt trong lưu trữ và mở rộng dữ liệu sản phẩm.
- Kết quả thử nghiệm cho thấy mô hình phân tán giúp:
    - Giảm tải cho cơ sở dữ liệu quan hệ.
    - Tăng hiệu năng truy vấn dữ liệu lớn.
    - Nâng cao khả năng mở rộng và độ tin cậy của hệ thống.

---

## 5. Ý nghĩa của đề tài
Đề tài minh họa rõ ràng việc ứng dụng **mô hình phân tán dữ liệu đa nền tảng** trong hệ thống thương mại điện tử, góp phần nâng cao khả năng xử lý dữ liệu và đáp ứng yêu cầu phát triển của các hệ thống thông tin hiện đại.

## License
**Giấy phép:** MIT License  
Dự án được phát hành theo giấy phép MIT, cho phép sử dụng, chỉnh sửa và phân phối
một cách tự do cho mục đích học tập và thương mại. Tác giả không chịu trách nhiệm
đối với mọi rủi ro phát sinh trong quá trình sử dụng phần mềm.

## Contributing
Mọi đóng góp cho dự án đều được hoan nghênh.
Vui lòng xem chi tiết tại file [CONTRIBUTING.md](CONTRIBUTING.md).

## Citation
Nếu bạn sử dụng mã nguồn hoặc tài liệu từ repository này trong bài báo,
luận văn hoặc nghiên cứu khoa học, vui lòng trích dẫn theo hướng dẫn trong
file [CITATION.cff](CITATION.cff).