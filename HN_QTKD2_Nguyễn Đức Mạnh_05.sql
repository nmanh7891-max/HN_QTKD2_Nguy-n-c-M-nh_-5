create database AirlineManagement;
use AirlineManagement;
create table passengers(
passengerId varchar(10) primary key,
fullname varchar(100) not null,
passportNumber varchar(20),
nationality varchar(50)
);
create table flights(
flightsId varchar(10) primary key,
departureCity varchar(50) not null,
arrivalCity varchar(50) not null,
flightsDate date,
flightsTime time
);
create table tickets(
passengerId varchar(10),
flightId varchar(10),
class enum ('PhoThong','ThuongGia') default 'PhoThong',
price decimal(15,2)
);
insert into passengers(passengerId,fullname,passportNumber,nationality) values
('HK01', 'Nguyen Van Hung', 'B1234567', 'Viet Nam'),
('HK02', 'John Smith', 'C9876543', 'USA'),
('HK03', 'Tran Thi Mai', 'B2345678', 'Viet Nam'),
('HK04', 'Lee Min Ho', 'K1122334', 'Korea'),
('HK05', 'Pham Van Tuan', 'B3456789', 'Viet Nam');
insert into flights(flightsId,departureCity,arrivalCity,flightsDate,flightsTime) values
('VN100', 'Ha Noi', 'Da Nang', '2023-10-20', '08:00:00'),
('VN200', 'Ho Chi Minh', 'Ha Noi', '2023-10-21', '14:30:00'),
('VJ300', 'Ha Noi', 'Tokyo', '2023-10-22', '23:00:00');
insert into tickets(passengerId,flightId,class,price) values
('HK01', 'VN100', 'PhoThong', 1500000),
('HK01', 'VN200', 'ThuongGia', 3000000),
('HK02', 'VN100', 'PhoThong', 1500000),
('HK03', 'VN200', 'PhoThong', 1200000),
('HK03', 'VJ300', 'PhoThong', 5000000),
('HK04', 'VJ300', 'ThuongGia', 10000000),
('HK05', 'VN100', 'PhoThong', 1400000);
-- Cập nhật dữ liệu 

-- Cập nhật giờ bay (FlightTime) của chuyến bay 'VN100' thành '09:00:00'
update flights
set flightsTime = '09:00:00'
where flightsId = 'VN100';
-- Tăng giá vé (Price) thêm 500000 cho khách hàng 'HK04' trên chuyến bay 'VJ300'
update tickets
SET price = price + 500000
where passengerId='HK04'AND flightsId ='VJ300';
-- Hủy vé máy bay của hành khách 'HK02' trên chuyến bay 'VN100'.
delete from tickets
where passengerId = 'HK02' and flightsId = 'VN100';

-- Truy vấn cơ bản 

-- Lấy danh sách hành khách (PassengerId, FullName) có quốc tịch là 'Viet Nam'
select passengerId, fullName
from passengers
where nationality = 'Viet Nam';
-- Lấy danh sách các chuyến bay (FlightId, ArrivalCity) bay đến 'Ha Noi'.
select flightId, arrivalCity
from flights
where arrivalCity = 'Ha Noi';
-- Lấy danh sách vé máy bay (PassengerId, FlightId, Price) có hạng vé là 'ThuongGia'.
select passengerId, flightId, price
from tickets
where class = 'ThuongGia';
-- Tìm các chuyến bay có ngày bay (FlightDate) trước ngày '2023-10-22'
select *
from flights
where flightDate / '2023-10-22';
-- Lấy ra danh sách vé máy bay, sắp xếp theo giá giảm dần.
select *
from tickets
order by price desc;
-- Lấy ra thông tin của 2 hành khách đầu tiên trong bảng Passengers.
select *
from passengers
limit 2;
-- truy vấn nâng cao

-- Thống kê tổng số tiền bán vé thu được từ mỗi chuyến bay (FlightId) dựa trên bảng Tickets.
select flightId SUM(price) as total
from tickets
order by flights;

-- Đếm số lượng hành khách đã đặt vé cho từng hạng vé (Class). Hiển thị: Class, Amount.
select class, count(*) as amout
from tickets
group by class;

-- Tìm những chuyến bay (FlightId) có ít nhất 3 hành khách đã đặt vé.
select flightId 
from tickets
group by flightId 
having count(passengerId) >= 3;























