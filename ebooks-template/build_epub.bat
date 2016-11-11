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
SET master_script=C:\Users\NNToan\Desktop\EBOOKS\eBookWorm\eBookWorm_Builder\eBookWorm_ePub_Builder.bat


REM KẾT THÚC THÔNG TIN CẦN THIẾT ĐỂ LÀM EBOOK



REM LỆNH TRỢ GIÚP TRONG TRƯỜNG HỢP BỊ LỖI KHI TẠO FILE EBOOK
REM Kích hoạt LỆNH TRỢ GIÚP dưới đây trong trường hợp bạn muốn taooj ra hay chỉnh sửa các lựa chọn cho phù hợp với yêu cầu
REM của mình hơn so với các lựa chọn có sẵn.
REM Lệnh trợ giúp không tạo ra file ebook, vì vậy sau khi sửa lỗi phải tắt nó đi

REM Trợ Giúp #1: xuất ra cách dùng master script vào file 'eBook_KindleGen_Report.txt',
REM bạn có thể dựa vào đó sửa các lựa chọn hoặc thêm các lựa chọn phù hợp với mình.
REM GOTO print_help




REM CHỌN LỰA KIỂU FILE, TÊN FILE EBOOK, MỨC ĐỘ NÉN CỦA FILE EBOOK, NÉN EBOOK BẰNG WINRAR ĐỂ UPLOAD LÊN MẠNG

REM Bạn chỉ được chọn _MỘT_ trong số các lựa chọn dưới đây, mỗi lựa chọn đều có hướng dẫn, đọc kỹ trước khi làm
REM Bỏ 'REM' trước 'CALL "%master_script%" ' của lựa chọn bạn muốn để kích hoạt lệnh,
REM thêm 'REM' trước 'CALL "%master_script%" ' của những lựa chọn khác để vô hiệu hóa chúng

REM Lựa chọn #1: lựa chọn mặc định của eBookWorm
REM - Mô tả: tạo file EPUB với mức độ nén mặc định (không nén)
REM - Tên file: Tên truyện (ví dụ 'Bàn Long.epub')
CALL "%master_script%"  -o "%book_title%" -f "%~dp0"

REM Lựa chọn #2
REM - Mô tả: tạo file EPUB với mức độ nén trung bình (-m3)
REM - Tên file: Tên truyện (ví dụ 'Bàn Long.epub')
REM CALL "%master_script%"  -m3 -o "%book_title%" -f "%~dp0"

REM Lựa chọn #3
REM - Mô tả: tạo file EPUB với mức độ nén trung bình (-m3)
REM - Tên file: Tên truyện_Người làm ebook (ví dụ 'Bàn Long_Big Bang.epub')
REM CALL "%master_script%"  -m3 -em "%ebook_maker%" -o "%book_title%" -f "%~dp0"

REM Lựa chọn #4
REM - Mô tả: tạo file EPUB với mức độ nén trung bình (-m3)
REM - Tên file: Tên truyện_Tác giả (ví dụ 'Bàn Long_Cà Chua.epub')
REM CALL "%master_script%"  -m3 -au "%author_name%" -o "%book_title%" -f "%~dp0"

REM Lựa chọn #5
REM - Mô tả: tạo file EPUB với mức độ nén cao (-m5)
REM - Tên file: Tên truyện_Tác giả_Người làm ebook (ví dụ 'Bàn Long_Cà Chua_Big Bang.epub')
REM - Ghi chú: lựa chọn này dùng để chia sẻ ebook
REM CALL "%master_script%"  -m5 -au "%author_name%" -em "%ebook_maker%" -o "%book_title%" -f "%~dp0"

REM Lựa chọn #6
REM - Mô tả: tạo file EPUB với mức độ nén cao (-m5)
REM - Tên file: Tên truyện_Số chương (ví dụ 'Bàn Long_Q12C5.epub')
REM - Ghi chú: lựa chọn này dùng để chia sẻ ebook
REM CALL "%master_script%"  -m5 -sc "%sufix_chapnum%" -o "%book_title%" -f "%~dp0"

REM Lựa chọn #7
REM - Mô tả: tạo file EPUB không nén (-m0), sau đó dùng WinRAR nén lại rồi copy vào 'eBookWorm\eBookWorm_Builder\Upload'
REM - Tên file: Tên truyện_Số chương (ví dụ: 1 file epub 'Bàn Long_Q12C5.epub' và 1 file zip 'Bàn Long_Q12C5.epub.zip')
REM - Ghi chú: lựa chọn này dùng để chia sẻ ebook
REM CALL "%master_script%" -u -sc "%sufix_chapnum%" -o "%book_title%" -f "%~dp0"



REM KẾT THÚC DANH SÁCH LỰA CHỌN - KHÔNG ĐƯỢC THAY ĐỔI NHỮNG DÒNG Ở DƯỚI

GOTO end_batch

:print_help
CALL "%master_script%" --help > "%~dp0eBook_KindleGen_Report.txt"
START /B NOTEPAD.EXE "%~dp0eBook_KindleGen_Report.txt"

:end_batch

