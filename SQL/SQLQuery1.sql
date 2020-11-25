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
  ItemId INT NOT NULL,
  ToppingId VARCHAR(10) NOT NULL,
  BillId VARCHAR(10) NOT NULL,
  DrinkId VARCHAR(10) NOT NULL,
  FOREIGN KEY (ItemId,BillId,DrinkId) REFERENCES Items(ItemId,BillId,DrinkId),
  FOREIGN KEY (ToppingId) REFERENCES Toppings(ToppingId),
  PRIMARY KEY(ItemId,ToppingId,BillId,DrinkId)
);

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

SELECT * FROM Items INNER JOIN ItemTopping ON ItemTopping.ItemId = Items.ItemId INNER JOIN Toppings ON Toppings.ToppingId = ItemTopping.ToppingId WHERE Items.BillId = '241143317'

SELECT * FROM Resources

SELECT * FROM Bills

CREATE FUNCTION 











