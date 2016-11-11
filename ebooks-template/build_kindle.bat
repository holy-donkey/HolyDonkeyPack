@ECHO off
CHCP 65001 1>NUL

REM Hướng dẫn:
REM   - Những dòng bắt đầu bằng 'REM' là dòng chú thích và được tô màu riêng, nếu coi trên EmEditor sẽ có màu nâu đỏ, trên Notepad++ có màu xanh lá mạ
REM   - Những dòng không bắt đầu bằng 'REM' là những dòng lệnh, thường có màu đen nếu coi trên EmEditor, trên Notepad++ từ đầu tiên thường được tô xanh đậm
REM   - Nên coi trên Notepad++ sẽ dễ thấy hơn
REM   - Một số dòng lệnh bị vô hiệu hóa bằng cách đặt 'REM' ở đầu, ví dụ:
REM       + REM CALL "%master_script%"  -o "%book_title%" -f "%~dp0eBook.opf"
REM       + Chỉ cần bỏ 'REM' ở đầu nó sẽ trở thành một dòng lệnh thực sự
REM   - Để tạo file MOBI hoặc/và AWZ3 bạn chọn một trong các dòng lệnh 'CALL "%master_script%" ' phù hợp yêu cầu và
REM     vô hiệu hóa các dòng 'CALL "%master_script%" ' còn lại
REM     Trước mỗi lệnh CALL "%master_script%" có những dòng chú thích, đọc kỹ trước khi lựa chọn

REM CHÚ Ý QUAN TRỌNG: file này (build_kindle.bat) chỉ chạy được khi được lưu dưới dạng "UTF-8 without Signature (BOM)"
REM Lưu nó dưới bất kỳ dạng nào khác đều dẫn đến lỗi hoặc không chạy được.
REM Kiểm tra điều này trước tiên trước khi tiến hành dò lỗi.


REM THÔNG TIN CẦN THIẾT ĐỂ LÀM EBOOK - NGƯỜI DÙNG ĐỌC KỸ TRƯỚC KHI ĐIỀN VÀO

REM Những thông tin dưới đây cần thiết để đặt tên file khi chạy KindleGen tạo file MOBI hay AZW3
REM "Tên truyện_Tên tác giả_Tên người làm ebook_số chương.AZW3"
REM Ví dụ: "Bàn Long.mobi" hoặc "Bàn Long_Big Bang_Q8.azw3" hoặc "Bàn Long_Ngã Cật Tây Hồng Thị_Q12.mobi"

REM Dòng lệnh dưới đây xác định tên truyện, bình thường eBookWorm làm thay bạn, bạn không cần phải làm gì.
REM Ví dụ:  SET book_title=Bàn Long
SET book_title=EBWP_BOOK_TITLE

REM Dòng lệnh dưới đây xác định tên tác giả, bình thường eBookWorm làm thay bạn, bạn không cần phải làm gì.
REM Ví dụ:  SET author_name=Ngã Cật Tây Hồng Thị
SET author_name=EBWP_AUTHOR_NAME

REM Dòng lệnh dưới đây xác định người làm ebook, bình thường eBookWorm làm thay bạn, bạn không cần phải làm gì.
REM Ví dụ:  SET ebook_maker=Big Bang
SET ebook_maker=EBWP_EBOOK_MAKER

REM Dòng lệnh dưới đây xác định số chương truyện đã cập nhật hay một thông tin bất kỳ bạn thích, bạn điền thông tin
REM nếu muốn. Nếu không muốn thì để trống. Nếu bạn chọn lựa chọn #6 thì nhất định phải điền  thông tin.
REM Ví dụ:  SET sufix_chapnum=C750, SET sufix_chapnum=Q9, SET sufix_chapnum=Q7C15, SET sufix_chapnum=Đừng Hỏi Nữa
SET sufix_chapnum=

REM Đường dẫn đến master script, chỉ làm một lần khi cài đặt eBookWorm. Bạn không được sửa dòng này.
SET master_script=C:\Users\NNToan\Desktop\EBOOKS\eBookWorm\eBookWorm_Builder\eBookWorm_Kindle_Builder.bat

REM KẾT THÚC THÔNG TIN CẦN THIẾT ĐỂ LÀM EBOOK

REM CÁC LỆNH TRỢ GIÚP TRONG TRƯỜNG HỢP BỊ LỖI KHI TẠO FILE EBOOK
REM Kích hoạt _MỘT_ trong hai lệnh trợ giúp dưới đây trong trường hợp bị lỗi khi tạo file ebook
REM Lệnh trợ giúp không tạo ra file ebook, vì vậy sau khi sửa lỗi phải tắt nó đi

REM Trợ Giúp #1: chạy KindleGen ở chế độ dò lỗi, kết quả tự động xuất ra file 'eBook_KindleGen_Report.txt'
GOTO debug_mode

REM Trợ Giúp #2: xuất ra cách dùng master script vào file 'eBook_KindleGen_Report.txt',
REM bạn có thể dựa vào đó sửa các lựa chọn hoặc thêm các lựa chọn phù hợp với mình.
REM GOTO print_help


ECHO Gathering data to launch eBookWorm Builder


REM CHỌN LỰA KIỂU FILE, TÊN FILE EBOOK, MỨC ĐỘ NÉN CỦA FILE EBOOK, NÉN EBOOK BẰNG WINRAR ĐỂ UPLOAD LÊN MẠNG

REM Bạn chỉ được chọn _MỘT_ trong số các lựa chọn dưới đây, mỗi lựa chọn đều có hướng dẫn, đọc kỹ trước khi làm
REM Bỏ 'REM' trước 'CALL "%master_script%" ' của lựa chọn bạn muốn để kích hoạt lệnh,
REM thêm 'REM' trước 'CALL "%master_script%" ' của những lựa chọn khác để vô hiệu hóa chúng

REM Lựa chọn #0
REM - Mô tả: tạo file MOBI với mức độ nén trung bình (-c1)
REM - Kiểu file: MOBI (Kindle MOBI format)
REM - Tên file: Tên truyện (ví dụ 'Bàn Long.mobi')
REM - Ghi chú: dùng cho cá nhân hoặc để chia sẻ truyện, thời gian chạy KindleGen không quá lâu
REM CALL "%master_script%"  -mobi -c2 -em "%ebook_maker%" -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #1: lựa chọn mặc định của eBookWorm
REM - Mô tả: tạo file AZW3 với mực độ nén mặc định (không nén)
REM - Kiểu file: AZW3 (Kindle KF8 format)
REM - Tên file: Tên truyện (ví dụ 'Bàn Long.azw3')
REM CALL "%master_script%"  -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #2
REM - Mô tả: tạo file MOBI với mức độ nén mặc định (không nén)
REM - Kiểu file: MOBI (Kindle MOBI format, đã cũ)
REM - Tên file: Tên truyện (ví dụ 'Bàn Long.mobi')
REM - Ghi chú: ai có iPhone, iPad thì chọn loại này
CALL "%master_script%"  -mobi -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #3
REM - Mô tả: tạo file AZW3 với mức độ nén trung bình (-c1)
REM - Kiểu file: AZW3 (Kindle KF8 format)
REM - Tên file: Tên truyện_Tên người làm ebook (ví dụ 'Bàn Long_Big Bang.azw3')
REM - Ghi chú: dùng cho cá nhân hoặc để chia sẻ truyện, thời gian chạy KindleGen không quá lâu
REM CALL "%master_script%"  -c1 -em "%ebook_maker%" -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #4
REM - Mô tả: tạo file MOBI với mức độ nén trung bình (-c1)
REM - Kiểu file: MOBI (Kindle MOBI format)
REM - Tên file: Tên truyện_Tên người làm ebook (ví dụ 'Bàn Long_Big Bang.azw3')
REM - Ghi chú: dùng cho cá nhân hoặc để chia sẻ truyện, thời gian chạy KindleGen không quá lâu
REM CALL "%master_script%"  -mobi -c1 -em "%ebook_maker%" -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #5
REM - Mô tả: tạo file AZW3 và MOBI với mức độ nén trung bình (-c1)
REM - Kiểu file: 1 file AZW3 (Kindle KF8 format), 1 file MOBI (Kindle MOBI format, đã cũ)
REM - Tên file: Tên truyện_Tên người làm ebook (ví dụ: 1 file 'Bàn Long_Big Bang.mobi' và 1 file 'Bàn Long_Big Bang.azw3')
REM - Ghi chú: dùng để chia sẻ truyện, thời gian chạy KindleGen không quá lâu
REM CALL "%master_script%"  -mobi -kf8 -c1 -em "%ebook_maker%" -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #6
REM - Mô tả: tạo file AZW3 và MOBI với mức độ nén cao (-c2)
REM - Kiểu file: 1 file AZW3 (Kindle KF8 format), 1 file MOBI (Kindle MOBI format, đã cũ)
REM - Tên file: Tên truyện_Tên tác giả_Tên người làm ebook (ví dụ: 1 file 'Bàn Long_Cà Chua_Big Bang.mobi' và 1 file 'Bàn Long_Cà Chua_Big Bang.azw3')
REM - Ghi chú: dùng để chia sẻ truyện, thời gian chạy KindleGen khá lâu (tùy theo máy)
REM CALL "%master_script%"  -mobi -kf8 -c2 -au "%author_name%" -em "%ebook_maker%" -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #7
REM - Mô tả: tạo file AZW3 và MOBI không nén, sau đó file MOBI và AZW3 sẽ được nén bằng WinRAR
REM - Tên file: Tên truyện_Tên tác giả_Tên người làm ebook (ví dụ: 'Bàn Long_Cà Chua_Big Bang')
REM - Kiểu file:
REM   + 1 file AZW3 (Kindle KF8 format), 1 file MOBI (Kindle MOBI format, đã cũ)
REM   + 1 file AZW3.RAR nén tối đa, 1 file MOBI.RAR nén tối đa
REM   + Ví dụ: sau khi chạy sẽ có 4 file, 2 file ebook không nén 'Bàn Long_Cà Chua_Big Bang.mobi' và 'Bàn Long_Cà Chua_Big Bang.azw3'
REM     2 file nén 'Bàn Long_Cà Chua_Big Bang.mobi.rar' và 'Bàn Long_Cà Chua_Big Bang.azw3.rar' ở trong folder 'eBookWorm\eBookWorm_Builder\Upload'
REM - Ghi chú: dùng để chia sẻ truyện, thời gian chạy KindleGen và WinRAR rất nhanh, các file *.rar dùng để upload lên mạng
REM CALL "%master_script%"  -mobi -kf8 -u -au "%author_name%" -em "%ebook_maker%" -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #8
REM - Mô tả: tạo file AZW3 và MOBI không nén, sau đó file MOBI và AZW3 sẽ được nén bằng WinRAR
REM - Tên file: Tên truyện_Tên tác giả_Tên người làm ebook_Số chương (ví dụ: 'Bàn Long_Cà Chua_Big Bang_Q16')
REM - Kiểu file:
REM   + 1 file AZW3 (Kindle KF8 format), 1 file MOBI (Kindle MOBI format, đã cũ)
REM   + 1 file AZW3.RAR nén tối đa, 1 file MOBI.RAR nén tối đa
REM   + Ví dụ: sau khi chạy sẽ có 4 file, 2 file ebook không nén 'Bàn Long_Cà Chua_Big Bang_Q16.mobi' và 'Bàn Long_Cà Chua_Big Bang_Q16.azw3'
REM     2 file nén 'Bàn Long_Cà Chua_Big Bang_Q16.mobi.rar' và 'Bàn Long_Cà Chua_Big Bang_Q16.azw3.rar' ở trong folder 'eBookWorm\eBookWorm_Builder\Upload'
REM - Ghi chú:
REM   + dùng để chia sẻ truyện, thời gian chạy KindleGen và WinRAR rất nhanh, các file *.rar dùng để upload lên mạng
REM   + Lựa chọn #6 yêu cầu thông tin về số chương truyện cập nhật (hoặc thông tin bất kỳ bạn muốn  thêm vào tên file)
REM     đã được xác định trước đó, nếu không chương trình sẽ chạy không chính xác hoặc không chạy được
REM CALL "%master_script%"  -mobi -kf8 -u -au "%author_name%" -em "%ebook_maker%" -sc "%sufix_chapnum%" -o "%book_title%" -f "%~dp0eBook.opf"

REM Lựa chọn #9
REM - Mô tả: tạo file AZW3 và MOBI nén siêu cao, sau đó file MOBI và AZW3 sẽ được nén tiếp bằng WinRAR
REM - Tên file: Tên truyện_Tên tác giả_Tên người làm ebook_Số chương (ví dụ: 'Bàn Long_Cà Chua_Big Bang_Q16')
REM - Kiểu file:
REM   + 1 file AZW3 (Kindle KF8 format), 1 file MOBI (Kindle MOBI format, đã cũ)
REM   + 1 file AZW3.RAR nén tối đa, 1 file MOBI.RAR nén tối đa
REM   + Ví dụ: sau khi chạy sẽ có 4 file, 2 file ebook không nén 'Bàn Long_Cà Chua_Big Bang_Q16.mobi' và 'Bàn Long_Cà Chua_Big Bang_Q16.azw3'
REM     2 file nén 'Bàn Long_Cà Chua_Big Bang_Q16.mobi.rar' và 'Bàn Long_Cà Chua_Big Bang_Q16.azw3.rar' ở trong folder 'eBookWorm\eBookWorm_Builder\Upload'
REM - Ghi chú:
REM   + dùng để chia sẻ truyện, thời gian chạy KindleGen và WinRAR rất nhanh, các file *.rar dùng để upload lên mạng
REM   + Lựa chọn #6 yêu cầu thông tin về số chương truyện cập nhật (hoặc thông tin bất kỳ bạn muốn  thêm vào tên file)
REM     đã được xác định trước đó, nếu không chương trình sẽ chạy không chính xác hoặc không chạy được
REM CALL "%master_script%"  -mobi -kf8 -u -c2 -au "%author_name%" -em "%ebook_maker%" -sc "%sufix_chapnum%" -o "%book_title%" -f "%~dp0eBook.opf"

REM KẾT THÚC DANH SÁCH LỰA CHỌN - KHÔNG ĐƯỢC THAY ĐỔI NHỮNG DÒNG Ở DƯỚI

GOTO end_batch

:debug_mode
CALL "%master_script%"  -o "%book_title%" -f "%~dp0eBook.opf" --test
GOTO end_batch

:print_help
CALL "%master_script%" --help > "%~dp0eBook_KindleGen_Report.txt"
START /B NOTEPAD.EXE "%~dp0eBook_KindleGen_Report.txt"

:end_batch
