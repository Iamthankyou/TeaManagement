USE tea01

SELECT * FROM Permision

SELECT * FROM UserPermision

SELECT * FROM PermisionDetail


DELETE Permision WHERE PermisionID LIKE '7'

INSERT INTO Permision(PermisionID,PermisionName) VALUES('8','?')

INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('07','','01')
INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('09','','01')
INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('10','','01')
INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('11','','01')
INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('13','','01')
INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('15','','01')
INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('18','','01')
INSERT INTO PermisionDetail(PermisionDetailId,ActionName,PermisionID) VALUES('19','','01')

SELECT * FROM Drinks

SELECT * FROM DrinkTypes

DELETE DrinkTypes WHERE DrinkTypeId LIKE '2'
DELETE DrinkTypes WHERE DrinkTypeId LIKE '3'

INSERT INTO DrinkTypes(DrinkTypeId,DrinkTypeName) VALUES('01',N'Trà giảm béo')

SELECT * FROM DrinkTypes

SELECT * FROM Toppings

SELECT * FROM UserPermision

SELECT * FROM Customer

SELECT * FROM Drinks
DELETE Toppings WHERE ToppingId LIKE '10'
INSERT INTO Toppings(ToppingId,ToppingName,Price) VALUES('9',N'Chân châu cao sang',10000)
INSERT INTO Toppings(ToppingId,ToppingName,Price) VALUES('10',N'Nếp thơm',10000)
INSERT INTO Toppings(ToppingId,ToppingName,Price) VALUES('11',N'Gạo tẻ',7000)

SELECT * FROM Customer

INSERT INTO Customer(PhoneNumber,FullName,Address,Level) VALUES('0392301017',N'Phạm Thị Thu Hiền',N'Yên Nhân, Yên Mô, Ninh Bình',0)

CREATE TABLE Voucher(
	Code nvarchar(10) PRIMARY KEY,
	dateStart datetime,
	dateEnd datetime,
	ratio int
)

SELECT * FROM Voucher

