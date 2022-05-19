USE HW_3_SQL_NorthWinds;
SELECT table_name, table_rows 
FROM information_schema.tables
WHERE TABLE_NAME  LIKE 'hw%';

#1
select * from hwCategories;
#2
select CompanyName, Address, City,Region,PostalCode,Phone
	from hwSuppliers
    where Country="France" or Country="Germany";
#3
select ContactName,ContactTitle
	from hwSuppliers
    where SupplierID>=5 and SupplierID<=20
    order by ContactName;
#4
select ProductName, QuantityPerUnit, UnitPrice, UnitsInStock
	from hwProducts
    where UnitPrice<10;
#5
select ProductID, ProductName, UnitsInStock, UnitPrice, ReorderLevel
	from hwProducts
    where UnitsInStock>0 and UnitsInStock<=ReorderLevel;
#6
SELECT LastName,FirstName, Date_Format(HireDate, '%m/%d/%Y')
	FROM hwEmployees
	WHERE Country!="USA" and HireDate<='2014-06-28'
    order by LastName;
#7
SELECT ProductName, UnitPrice
	FROM hwProducts
	WHERE ProductID 
    IN(SELECT ProductID
	FROM hwProducts
	WHERE UnitPrice =(SELECT MAX(UnitPrice)
	FROM hwProducts));
#8
SELECT ProductID, ProductName,(UnitsInStock*UnitPrice) as "Total Inventory Value"
	from hwProducts
    WHERE UnitsInStock*UnitPrice>2000;
#9
Select ProductID,ProductName,UnitPrice
	from hwProducts
	where QuantityPerUnit
    like '%cans%' and Discontinued=1;
#10
SELECT ShipCountry,COUNT(OrderID) as Orders
	FROM hwOrders
    WHERE ShipCountry != "USA"
	and MONTH(ShippedDate)='9'
    and YEAR(ShippedDate)='2013'
    Group BY ShipCountry;
#11
SELECT Round(sum(UnitPrice)/COUNT(ProductID),2) as 'Average Unit Price' 
	From hwProducts;
#12
Select Count(CustomerID) as "Customer from France"
	From hwCustomers
    Where Country="France";
#13
select CustomerID, ShipCountry
	from hwOrders
    group by CustomerID,ShipCountry
    having COUNT(CustomerID)>20;
#14
select SupplierID, SUM(UnitPrice*UnitsInStock)
	as "total value of inventory"
	from hwProducts
    where SupplierID BETWEEN 1 and 5
    group by SupplierID;
#15
SELECT CompanyName, hwProducts.ProductName,hwProducts.UnitPrice
	from hwSuppliers
    Join hwProducts
	on hwProducts.SupplierID=hwSuppliers.SupplierID
    WHERE Country='USA'
    GROUP BY CompanyName, hwProducts.ProductName,hwProducts.UnitPrice;
#16
select FirstName, LastName,Title, count(hwOrders.OrderID)
	from hwOrders
    join hwEmployees
    on hwEmployees.employeeId=hwOrders.EmployeeID
    group by FirstName, LastName,Title
    having count(hwOrders.OrderID)>100
    order by Concat(FirstName,' ',LastName);
#17
Select hwCustomers.CustomerID, hwCustomers.CompanyName
	from hwCustomers
    Left join hwOrders
    on hwCustomers.CustomerID=hwOrders.CustomerID
    where hwOrders.OrderID is NULL;
#18
Select CompanyName, ContactName,
	hwCategories.CategoryName,hwCategories.Description,
    hwProducts.ProductName,hwProducts.UnitsInStock
    from hwSuppliers
    Join hwCategories,hwProducts
    where hwProducts.UnitsInStock=0 
    and hwProducts.SupplierID=hwSuppliers.SupplierID
    and hwProducts.CategoryID=hwCategories.CategoryID;
#19
Select ProductName,UnitsInStock,
	hwSuppliers.CompanyName,hwSuppliers.Country
    from hwProducts
    Join hwSuppliers
    where hwProducts.SupplierID=hwSuppliers.SupplierID
    and QuantityPerUnit Like '%bottle%' or '%bottles%';
#20
SELECT CompanyName,hwOrders.ShipName,
	Round((hwOrderDetails.UnitPrice*hwOrderDetails.Quantity)*(1-hwOrderDetails.Discount),2)
    as 'Value of all orders'
    from hwCustomers
    Inner JOIN hwOrders,hwOrderDetails
    where hwCustomers.Country='Mexico'
    and hwCustomers.CustomerID=hwOrders.CustomerID
    and hwOrders.OrderID=hwOrderDetails.OrderID;
#21
Create VIEW EmployeesOrders As
	SELECT FirstName,LastName,COUNT(hwOrders.OrderID)
    as 'OrderCount'
    from hwEmployees
	Inner Join hwOrders
    where hwEmployees.EmployeeID=hwOrders.EmployeeID
    GROUP BY FirstName,LastName;
#22
Select * from EmployeesOrders;
#23
CREATE TABLE IF NOT EXISTS TopItems (
    ItemID INT NOT NULL,
    ItemCode INT,
    ItemName VARCHAR(40) NOT NULL,
    ItemDate DATE NOT NULL,
    ItemQuantity INT NOT NULL,
    ItemPrice DECIMAL(9, 2) NOT NULL,
    SupplierID INT NOT NULL,
    PRIMARY KEY (ItemID)
);
#24
insert into 
	TopItems (ItemID, ItemName,ItemDate,ItemQuantity,ItemPrice,SupplierID)
    select ProductID,ProductName,curdate(),UnitsInStock,UnitPrice,SupplierID
    from hwProducts
    where UnitPrice<8;
select * from TopItems;
#25
delete from TopItems where itemID=54 or itemID=75;
select * from TopItems;
#26
alter table TopItems add InventoryValue decimal(9,2) After  ItemPrice;
select * from TopItems;
#27
update TopItems set InventoryValue=ItemPrice*ItemQuantity;
Select * from TopItems;
#28
SHOW COLUMNS FROM TopItems;
#29
drop table TopItems;
#30
drop view EmployeesOrders;
