* Ứng dụng quản lý trà sữa:
- Mô phỏng chức năng:
	- Giao điện đăng nhập cho chủ quán, nhân viên
	- Chủ quán kiểm soát hóa đơn, doanh thu, số lượng kho tồn
	- Nhân viên kiểm soát đặt bàn, gọi món

- Tổ chức thư mục:
	- TeaManagementSystem
		- Properties
		- References
		- DataAccessLayer
		- EntityFramework
		- Image
		- Model
		- UI
		- App.config [XML]
		- pagekages.config [XML]
		- Program.cs

- SQL Schema
	- Hóa đơn (Bills) thì chỉ có một quan trọng nhất là tổng tiền, khách hàng là ai và nhân viên nào ghi nhận hóa đơn đó.
	- Items là join table của Bills và Drinks ví dụ với mã hóa đơn 112358 mua trà sữa Chân châu (còn DrinkType chỉ là phân trà sữa thành các loại) với số lượng 2, 
	và mã hóa đơn 235711 mua Trà sữa chân châu với số lượng 3.
	- Resource chính là nguyên liệu tạo thành của trà sữa và topping, được coi là thành phần nhỏ nhất vì thế liên kết giữa Resource và Drink và Topping là nhiều nhiều
	- Customer có một bảng duy nhất không có gì giải thích thêm
	- User có nhiều loại để phân quyền được rõ ràng hơn sau này bắt buộc phải chia thành 4 bảng như vậy.
		- Ví dụ Permision có các quyền Full, Admin, ReadOnly, Edit, Create
		- Vì một nhân viên có thể cùng thời có quyền ReadOnly và Edit nên Permision và User là quan hệ nhiều nhiều
		- PermisionDetail phân chia quyền hạn được rõ ràng hơn, ví dụ:
			- ActionName là EditPrice và PermisionName của nó là Edit
			- ActionName là EditPrice và PermisionName của nó là Admin

#Tea Management Project

Framework: Entity & Devexpress Winform
Navigation bar: responsive style and navigation 


	
![Visualization of the codebase](./diagram.svg)


















