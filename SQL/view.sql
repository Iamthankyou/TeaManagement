/*	View 01: 
	View các Hoa Don Ban trong ngay hom nay*/
create view View01_HoaDonBanTrongNgay as
select BillId, UserName, PhoneNumber, CodeVoucher, Total,  Payments, TableId, OrderTimeStart, OrderTimeEnd from Bills 
where DAY(OrderTimeStart) = Day(getDate()) and YEAR(OrderTimeStart) = YEAR(GETDATE()) and MONTH(OrderTimeStart) = MONTH(GETDATE())
-----------------------------------------------------------------------------------------------------------------------------------------------
/*	View 02: 
	Top 3 Nhan Vien có số lượng hóa đơn cao nhất tháng vừa qua (nếu số lượng hóa đơn bằng nhau thì sẽ so sánh bằng tổng tiền của các hóa đơn)
*/
create view View02_Top3NhanVien as
select top(3) Bills.UserName, COUNT(BillId) as SoHoaDon, Sum(Total) as Tong  from Staff inner join Bills on Bills.UserName = Staff.UserName 
group by Bills.UserName
order by SoHoaDon, Tong desc
-----------------------------------------------------------------------------------------------------------------------------------------------
/*	View 03:
	Quán sẽ tặng Voucher cho 5 Khách hàng mua nhiều nhất trong tháng trước(Tổng mua >= 500.000) 
	Tạo view xuất ra thông tin của các khách hàng này (PhoneNumber, FullName, TongMuaThangTruoc, TongALL)
*/ 
create view View03_Top5KhacHang as
select Top(5) Bills.PhoneNumber, FullName, SUM(Total) as Tong from Customer inner join Bills on Bills.PhoneNumber = Customer.PhoneNumber
group by Bills.PhoneNumber,FullName
having SUM(Total) >= 500000
order by Tong desc
-----------------------------------------------------------------------------------------------------------------------------------------------
/*	View 04:
	Thống kê tổng tiền các tháng trong năm hiện tại
*/ 
create view View04_ThongKeTongTienHangThang as
SELECT 'TongThu' AS TongThuTheoThang, 
[1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12]
FROM 
(SELECT MONTH(OrderTimeStart) as Thang, Total
FROM Bills) AS BangNguon
PIVOT 
(
 SUM(Total)
 FOR Thang IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
) AS BangChuyen;
-----------------------------------------------------------------------------------------------------------------------------------------------
/*
	Proc
	Tạo thủ tục lấy ra thống kê số  lượng bán trà, topping theo ngày hôm nay (không cần truyền tham số)
*/
create proc proc01_ThongKe as
begin
	select ISNULL(Table1.DrinkId,'') as DrinkID, ISNULL(DrinkName,'') as DrinkName, ISNULL(SLBanD,'') as SLBanDrink, ISNULL(Table2.ToppingId,'') as ToppingId, ISNULL(ToppingName,'') as ToppingName, ISNULL(SLBanT,'') SLBanTopping 
	from (select ROW_NUMBER() OVER (ORDER BY d1.DrinkId) AS [STT], d1.DrinkId, DrinkName, count(d1.DrinkId) as SLBanD from (Bills b1 inner join Items i1 on b1.BillId = i1.BillId)  full join Drinks d1 on d1.DrinkId = i1.DrinkId WHERE DAY(OrderTimeStart) = DAY(GETDATE()) and MONTH(OrderTimeStart) = MONTH(GETDATE()) and YEAR(OrderTimeStart) = YEAR(GETDATE()) group by d1.DrinkId, DrinkName) Table1 
	full join 
	( select ROW_NUMBER() OVER (ORDER BY t2.ToppingId) AS [STT], t2.ToppingId, ToppingName ,count(t2.ToppingId) as SLBanT	from ((Bills b2 inner join Items i2 on b2.BillId = i2.BillId) inner join ItemTopping it2 on it2.ItemId = i2.ItemId) full join Toppings t2 on t2.ToppingId = it2.ToppingId WHERE DAY(OrderTimeStart) = DAY(GETDATE()) and MONTH(OrderTimeStart) = MONTH(GETDATE()) and YEAR(OrderTimeStart) = YEAR(GETDATE()) group by t2.ToppingId,ToppingName ) Table2 on Table1.STT = Table2.STT
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------
