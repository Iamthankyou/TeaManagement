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

SELECT * FROM Bills

ALTER TABLE Bills ADD CodeVoucher nvarchar(10)

ALTER TABLE Bills
ADD CONSTRAINT fk_codeVoucher
FOREIGN KEY (CodeVoucher) REFERENCES Voucher(Code);

SELECT * FROM Customer

SELECT * FROM Staff

SELECT * FROM Bills

SELECT * FROM Items

SELECT * FROM DrinkTopping

SELECT * FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId INNER JOIN Drinks ON Drinks.DrinkId= Items.DrinkId INNER JOIN DrinkTopping ON DrinkTopping.DrinkId = Drinks.DrinkId INNER JOIN Toppings ON Toppings.ToppingId = DrinkTopping.ToppingId

SELECT * FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId


CREATE TABLE ItemTopping
(
  IdItemTopping INT IDENTITY(1,1),
  ItemId INT NOT NULL,
  ToppingId VARCHAR(10) NOT NULL,
  BillId VARCHAR(10) NOT NULL,
  DrinkId VARCHAR(10) NOT NULL,
  FOREIGN KEY (ItemId,BillId,DrinkId) REFERENCES Items(ItemId,BillId,DrinkId),
  FOREIGN KEY (ToppingId) REFERENCES Toppings(ToppingId),
  PRIMARY KEY(IdItemTopping)
);

INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (8, N'11', N'231131458', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'10', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'11', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'4', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'5', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (9, N'6', N'231133324', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (11, N'11', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (11, N'2', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (11, N'5', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (12, N'10', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (12, N'11', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (12, N'2', N'231133324', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (13, N'1', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (13, N'10', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (13, N'4', N'231133324', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (14, N'10', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (14, N'11', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (14, N'4', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (15, N'10', N'231133324', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (18, N'11', N'23113487', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (18, N'5', N'23113487', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (19, N'2', N'231135316', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (21, N'11', N'24112165', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (22, N'6', N'24112165', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (23, N'4', N'24112165', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (24, N'6', N'241121725', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (25, N'2', N'24113224', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (26, N'1', N'24113458', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (26, N'2', N'24113458', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (27, N'9', N'241132821', N'6')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (28, N'5', N'241134047', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (29, N'5', N'241134150', N'01')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (30, N'2', N'241134339', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (31, N'5', N'24113480', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (32, N'3', N'241135040', N'05')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (33, N'10', N'241143248', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (34, N'10', N'241143317', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (35, N'11', N'241143317', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (36, N'10', N'241143426', N'02')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (37, N'11', N'241143426', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (38, N'5', N'25117221', N'03')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (39, N'10', N'261113951', N'04')
INSERT [dbo].[ItemTopping] ([ItemId], [ToppingId], [BillId], [DrinkId]) VALUES (41, N'11', N'261113951', N'6')

DROP TABLE ItemTopping

USE tea01

SELECT * FROM Resources

SELECT * FROM Items

SELECT * FROM Bills INNER JOIN Items ON Bills.BillId = Items.BillId

SELECT * FROM Bills


SELECT * FROM Staff

ALTER TABLE Staff ADD DayOf Datetime




SELECT * FROM ItemTopping

DROP TABLE ItemTopping


SELECT * FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId

SELECT * FROM Bills WHERE BillId = '221118133'

UPDATE Bills SET OrderTimeStart = GETDATE() WHERE BillId = '221118133'


SELECT * FROM Items

INSERT INTO Items(BillId,DrinkId) VALUES('221118133','03')
INSERT INTO Items(BillId,DrinkId) VALUES('221118133','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211181833','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211181833','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211181833','03')
INSERT INTO Items(BillId,DrinkId) VALUES('221118551','03')
INSERT INTO Items(BillId,DrinkId) VALUES('22111880','03')
INSERT INTO Items(BillId,DrinkId) VALUES('22111880','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211191020','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211191212','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211191356','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211191528','03')
INSERT INTO Items(BillId,DrinkId) VALUES('221119256','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211193549','03')
INSERT INTO Items(BillId,DrinkId) VALUES('22111945','03')
INSERT INTO Items(BillId,DrinkId) VALUES('2211194821','03')
INSERT INTO Items(BillId,DrinkId) VALUES('221119651','03')
INSERT INTO Items(BillId,DrinkId) VALUES('221119651','03')
INSERT INTO Items(BillId,DrinkId) VALUES('221119952','03')
INSERT INTO Items(BillId,DrinkId) VALUES('23110257','03')
INSERT INTO Items(BillId,DrinkId) VALUES('23110257','03')
INSERT INTO Items(BillId,DrinkId) VALUES('231112756','03')
INSERT INTO Items(BillId,DrinkId) VALUES('231112756','03')
INSERT INTO Items(BillId,DrinkId) VALUES('23111293','03')
INSERT INTO Items(BillId,DrinkId) VALUES('23111293','03')
INSERT INTO Items(BillId,DrinkId) VALUES('23111293','03')
INSERT INTO Items(BillId,DrinkId) VALUES('23111293','03')

DROP TABLE Items

ALTER TABLE Items ADD IdItem int NOT NULL

ALTER TABLE Items DROP COLUMN IdItem

ALTER TABLE Items ADD CONSTRAINT PK_Items PRIMARY KEY (IdItem)

ALTER TABLE Items ADD CONSTRAINT FK_01 FOREIGN KEY (BillId) REFERENCES Bills(BillId)
ALTER TABLE Items ADD CONSTRAINT FK_02 FOREIGN KEY (DrinkId) REFERENCES Drinks(DrinkId)


CREATE TABLE Items
(
  Amount INT DEFAULT NULL,
  ItemId INT NOT NULL IDENTITY(1,1),
  BillId VARCHAR(10) NOT NULL,
  DrinkId VARCHAR(10) NOT NULL,
  FOREIGN KEY (BillId) REFERENCES Bills(BillId),
  FOREIGN KEY (DrinkId) REFERENCES Drinks(DrinkId),
  PRIMARY KEY (ItemId,BillId,DrinkId)
);

SELECT * FROM Items

SELECT * FROM ItemTopping

SELECT * FROM Bills

SELECT * FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId INNER JOIN ItemTopping ON ItemTopping.Billid = Bills.BillId INNER JOIN Drinks ON Drinks.DrinkId = Items.DrinkId INNER JOIN Toppings ON Toppings.ToppingId = ItemTopping.ToppingId

SELECT * FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId INNER JOIN Drinks ON Drinks.DrinkId = Items.DrinkId INNER JOIN ItemTopping ON ItemTopping.ItemId = Items.ItemId WHERE PhoneNumber = '0967452219'


SELECT SUM(Total) FROM Bills GROUP BY PhoneNumber HAVING PhoneNumber = '0123401234'

SELECT * FROM Customer

-- TRIGGER 1
  
ALTER TRIGGER updateLevel ON Bills FOR INSERT,UPDATE,DELETE AS
BEGIN
	DECLARE @sum int
	SELECT @sum = SUM(Total) FROM Bills GROUP BY PhoneNumber HAVING PhoneNumber = (SELECT PhoneNumber FROM inserted)

	UPDATE Customer SET Level = @sum/500000 WHERE PhoneNumber = (SELECT PhoneNumber FROM inserted)
-- Auto update status tablespace
	DECLARE @count int
--	SELECT @count = ISNULL(COUNT(Bills.TableId),0) FROM Bills INNER JOIN TableSpace ON Bills.TableId = TableSpace.TableId  GROUP BY TableSpace.TableId HAVING TableSpace.TableId = (SELECT TableId FROM INSERTED)
	SELECT @count = ISNULL(COUNT(Bills.TableId),0) FROM Bills INNER JOIN TableSpace ON Bills.TableId = TableSpace.TableId WHERE Bills.OrderTimeEnd IS NULL GROUP BY TableSpace.TableId HAVING TableSpace.TableId = '1' 

	IF @count>=4
		UPDATE TableSpace SET Status=0 WHERE TableId = (SELECT TableId FROM INSERTED)
	ELSE
		UPDATE TableSpace SET Status=1 WHERE TableId = (SELECT TableId FROM INSERTED)
END

CREATE TRIGGER updateTable ON Bills FOR INSERT,UPDATE,DELETE AS
BEGIN 
DECLARE @count int
	SELECT @count = ISNULL(COUNT(Bills.TableId),0) FROM Bills INNER JOIN TableSpace ON Bills.TableId = TableSpace.TableId WHERE Bills.OrderTimeEnd IS NULL GROUP BY TableSpace.TableId HAVING TableSpace.TableId = '1' 

	IF @count>=4
		UPDATE TableSpace SET Status=0 WHERE TableId = (SELECT TableId FROM INSERTED)
	ELSE
		UPDATE TableSpace SET Status=1 WHERE TableId = (SELECT TableId FROM INSERTED)
END

SELECT * FROM Bills WHERE PhoneNumber = '0123401234'

SELECT * FROM Bills

SELECT * FROM Bills WHERE BillId = '24113224'
SELECT * FROM Bills WHERE BillId = '24113458'

SELECT * FROM TableSpace

SELECT * FROM Resources

SELECT * FROM DrinkResource

SELECT * FROM ToppingResource


UPDATE TableSpace SET Status = 1

SELECT * FROM Bills INNER JOIN TableSpace ON Bills.TableId = TableSpace.TableId

DECLARE @count int
SELECT @count = ISNULL(COUNT(Bills.TableId),0) FROM Bills INNER JOIN TableSpace ON Bills.TableId = TableSpace.TableId WHERE Bills.OrderTimeEnd IS NULL GROUP BY TableSpace.TableId HAVING TableSpace.TableId = '1' 
print @count

SELECT * FROM Permision

SELECT * FROM PermisionDetail

SELECT * FROM Resources

SELECT * FROM ToppingResource

SELECT * FROM DrinkResource

ALTER TABLE ToppingResource ADD Amount int

ALTER TABLE DrinkResource ADD Amount int


CREATE TABLE Drink_Resource
(
  ResourceId VARCHAR(10) NOT NULL,
  DrinkId VARCHAR(10) NOT NULL,
  Amount int,
  FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId),
  FOREIGN KEY (DrinkId) REFERENCES Drinks(DrinkId),
  PRIMARY KEY(ResourceId,DrinkId)
);

DROP TABLE DrinkResource


CREATE TABLE Drink_Topping
(
  DrinkId VARCHAR(10) NOT NULL,
  ToppingId VARCHAR(10) NOT NULL,
  Amount int,
  FOREIGN KEY (DrinkId) REFERENCES Drinks(DrinkId),
  FOREIGN KEY (ToppingId) REFERENCES Toppings(ToppingId),
  PRIMARY KEY (DrinkId,ToppingId)
);

DROP TABLE DrinkTopping

DROP TABLE Drink_Topping

DROP TABLE ToppingResource

CREATE TABLE Topping_Resource
(
  ResourceId VARCHAR(10) NOT NULL,
  ToppingId VARCHAR(10) NOT NULL,
  Amount int,
  FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId),
  FOREIGN KEY (ToppingId) REFERENCES Toppings(ToppingId),
  PRIMARY KEY(ResourceId,ToppingId)
);


SELECT * FROM Drinks

SELECT * FROM Toppings

SELECT * FROM Drink_Resource

SELECT * FROM Topping_Resource

SELECT Topping_Resource.Amount FROM Items INNER JOIN ItemTopping ON ItemTopping.ItemId = Items.ItemId INNER JOIN Toppings ON Toppings.ToppingId = ItemTopping.ToppingId INNER JOIN Topping_Resource ON Topping_Resource.ToppingId = Toppings.ToppingId INNER JOIN Resources ON Resources.ResourceId = Topping_Resource.ResourceId WHERE Items.BillId = '241143317' AND Resources.ResourceId = '000007'


SELECT * FROM Items INNER JOIN ItemTopping ON ItemTopping.ItemId = Items.ItemId INNER JOIN Toppings ON Toppings.ToppingId = ItemTopping.ToppingId INNER JOIN Topping_Resource ON Topping_Resource.ToppingId = Toppings.ToppingId INNER JOIN Resources ON Resources.ResourceId = Topping_Resource.ResourceId WHERE Items.BillId = '241143317'

SELECT * FROM Resources

SELECT * FROM Bills

-- FUNCTION 1

CREATE FUNCTION getAmountResourceTopping(@idResource varchar(10), @idBill varchar(10)) RETURNS INT AS 
BEGIN
	DECLARE @res int
	SELECT @res = ISNULL(Topping_Resource.Amount,0) FROM Items INNER JOIN ItemTopping ON ItemTopping.ItemId = Items.ItemId INNER JOIN Toppings ON Toppings.ToppingId = ItemTopping.ToppingId INNER JOIN Topping_Resource ON Topping_Resource.ToppingId = Toppings.ToppingId INNER JOIN Resources ON Resources.ResourceId = Topping_Resource.ResourceId WHERE Items.BillId = @idBill AND Resources.ResourceId = @idResource
	RETURN @res
END

CREATE FUNCTION getAmountResourceDrink(@idResource varchar(10), @idBill varchar(10)) RETURNS INT AS
BEGIN
	DECLARE @res int
	SELECT @res = ISNULL(Drink_Resource.Amount,0) FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId INNER JOIN Drink_Resource On Drink_Resource.DrinkId = Items.DrinkId WHERE Items.BillId = @idBill AND Drink_Resource.ResourceId = @idResource
	RETURN @res
END

SELECT * FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId INNER JOIN Drink_Resource On Drink_Resource.DrinkId = Items.DrinkId WHERE Items.BillId = '241143317'


PRINT(dbo.getAmountResourceDrink('000001','241143317'))


UPDATE Resources SET Amount = 100

USE tea01


UPDATE Resources SET Amount = Amount - ISNULL(dbo.getAmountResourceDrink(ResourceId,'241143317'),0)	
UPDATE Resources SET Amount = Amount - ISNULL(dbo.getAmountResourceTopping(ResourceId,'241143317'),0)

-- TRIGGER 2

ALTER TRIGGER updateResource ON Items FOR INSERT,UPDATE AS
BEGIN
	DECLARE @idBill nvarchar(10) 
	SELECT @idBill = BillId FROM INSERTED 
	UPDATE Resources SET Amount = Amount - ISNULL(dbo.getAmountResourceDrink(ResourceId,@idBill),0)	
	UPDATE Resources SET Amount = Amount - ISNULL(dbo.getAmountResourceTopping(ResourceId,@idBill),0)
END

SELECT * FROM Resources

SELECT * FROM Bills




SELECT * FROM ItemTopping


SELECT * FROM Bills WHERE Bills.PhoneNumber = '0392301017'

SELECT * FROM Bills

Use tea01


UPDATE Bills SET Bills.UserName = 'nobita' WHERE UserName IS NULL


SELECT * FROM UserPermision

SELECT * FROM ItemTopping

SELECT * FROM Bills WHERE BillId = '261119114'

SELECT * FROM Bills INNER JOIN Items ON Bills.BillId = Items.BillId WHERE Bills.BillId = '2611185350'

SELECT * FROM ItemTopping WHERE ItemTopping.BillId = '261119114'

SELECT * FROM Items WHERE BillId = '261119114' --'

DELETE Bills WHERE BillId = '261119114'

-- TRIGGER 3

CREATE TRIGGER autoDeleteBill ON Bills INSTEAD OF Delete AS
BEGIN
	DECLARE @billId varchar(10)
	SELECT @billId=BillId FROM DELETED

	DELETE ItemTopping WHERE ItemTopping.BillId = @billId
	DELETE Items WHERE Items.BillId = @billId
	DELETE Bills WHERE BillId = @billId
END

SELECT * FROM Customer

SELECT * FROM Staff INNER JOIN  UserPermision ON UserPermision.UserName = Staff.UserName INNER JOIN Permision ON Permision.PermisionID = UserPermision.PermisionID INNER JOIN PermisionDetail ON PermisionDetail.PermisionID = Permision.PermisionID WHERE Staff.UserName = 'nobita'

DROP FUNCTION checkPer


CREATE FUNCTION checkPer(@per varchar(1), @userName varchar(10)) RETURNS BIT AS
BEGIN
	DECLARE @res BIT
	DECLARE @id varchar(10)
	SELECT @id = Staff.UserName FROM Staff INNER JOIN UserPermision ON Staff.UserName = UserPermision.UserName INNER JOIN Permision ON Permision.PermisionID = UserPermision.PermisionID INNER JOIN PermisionDetail ON PermisionDetail.PermisionID = Permision.PermisionID WHERE Staff.UserName = @userName AND PermisionDetail.ActionName = @per
	
	IF @id = @userName
		SET @res = 1
	ELSE
		SET @res = 0

	RETURN @res
END
-- Ví dụ
print dbo.checkPer('C','prochicken007')

DROP FUNCTION billCustom


CREATE FUNCTION billCustom(@start VARCHAR(10), @end VARCHAR(10)) RETURNS INT AS
BEGIN
	DECLARE @startDate DATETIME
	DECLARE @endDate DATETIME
	DECLARE @res INT

	SET @startDate = CONVERT(DATETIME,@start,103)
	SET @endDate = CONVERT(DATETIME,@end,103)

	SELECT @res = SUM(Bills.Total) FROM Bills WHERE Bills.OrderTimeStart>=@startDate AND Bills.OrderTimeStart<=@endDate
	
	RETURN @res
END

print dbo.billCustom('26/11/2020','27/11/2020')


SELECT * FROM Bills

-- 2611222430

SELECT * FROM Bills INNER JOIN Items ON Items.BillId = Bills.BillId INNER JOIN ItemTopping ON ItemTopping.BillId = Items.BillId INNER JOIN Toppings ON Toppings.ToppingId = ItemTopping.ToppingId

CREATE FUNCTION checkTable(@idTable varchar(10)) RETURNS TABLE AS
RETURN (SELECT Customer.FullName FROM TableSpace INNER JOIN Bills ON Bills.TableId = TableSpace.TableId INNER JOIN Customer ON Customer.PhoneNumber = Bills.PhoneNumber WHERE Bills.OrderTimeEnd IS NULL AND TableSpace.TableId = @idTable
)

SELECT * FROM dbo.checkTable('1')

CREATE PROC staffDay AS
BEGIN
	SELECT * FROM Bills INNER JOIN Staff ON Bills.UserName = Staff.UserName WHERE DAY(Bills.OrderTimeStart) = DAY(GETDATE()) AND MONTH(Bills.OrderTimeStart) = MONTH(GETDATE()) AND YEAR(Bills.OrderTimeStart) = YEAR(GETDATE())  
END

EXEC staffDay

CREATE PROC teaResource @idTea VARCHAR(10) AS 
BEGIN
	SELECT Resources.ResourceName, Resources.ResourceId FROM Drinks INNER JOIN Drink_Resource ON Drinks.DrinkId = Drink_Resource.DrinkId INNER JOIN Resources ON Resources.ResourceId = Drink_Resource.ResourceId WHERE Drinks.DrinkId = @idTea
END

DECLARE @idTea VARCHAR(10)
SET @idTea = '01'
EXEC dbo.teaResource @idTea

CREATE PROC combiTeaTopping AS
BEGIN
	SELECT Drinks.DrinkName,Toppings.ToppingName FROM Drinks INNER JOIN Items ON Items.DrinkId = Drinks.DrinkId INNER JOIN ItemTopping ON ItemTopping.DrinkId = Drinks.DrinkId  FULL OUTER JOIN Toppings ON ItemTopping.ToppingId = Toppings.ToppingId
END

EXEC dbo.combiTeaTopping





