USE HW_4_SQL_sales_dw;  
SELECT 'Table', 'Rows' FROM dim_customer 
UNION
SELECT 'dim_customer', COUNT(*) FROM dim_customer 
UNION
SELECT 'dim_date', COUNT(*) FROM dim_date 
UNION
SELECT 'dim_product', COUNT(*) FROM dim_product 
UNION
SELECT 'dim_salesperson', COUNT(*) FROM dim_salesperson 
UNION
SELECT 'dim_store', COUNT(*) FROM dim_store 
UNION
SELECT 'fact_productsales', COUNT(*) FROM fact_productsales;
#1
SELECT SalesPersonName,
	SUM(fact_productsales.SalesPrice*fact_productsales.Quantity)
    as 'Total Revenue'
	from dim_salesperson
    JOIN fact_productsales
    on dim_salesperson.SalesPersonID=fact_productsales.SalesPersonID
    Join dim_date
    on fact_productsales.SalesDateKey=dim_date.DateKey
    WHERE dim_date.Year=2012
    GROUP BY SalesPersonName
    ORDER BY SUM(fact_productsales.SalesPrice*fact_productsales.Quantity) DESC
    LIMIT 1;
    
#2
SELECT CustomerName,
	SUM(fact_productsales.SalesPrice*fact_productsales.Quantity)
    as 'Total Revenue'
	from dim_customer
    Join fact_productsales
    on fact_productsales.CustomerID=dim_customer.CustomerID
    Join dim_date
    on fact_productsales.SalesDateKey=dim_date.DateKey
    WHERE dim_date.Year=2013
    GROUP BY CustomerName
    ORDER BY SUM(fact_productsales.SalesPrice*fact_productsales.Quantity) DESC
    LIMIT 3;
#3
SELECT YEAR,
	fact_productsales.StoreID,SUM(SalesPrice)
    as 'Total Sales Price'
	from Dim_Date
    JOIN fact_productsales
    on fact_productsales.SalesDateKey=dim_date.DateKey
    where Dim_Date.YEAR BETWEEN 2016 and 2017
    GROUP BY Dim_Date.YEAR,fact_productsales.StoreID;
#4
SELECT ProductName,
	SUM((ProductSalesPrice-ProductActualCost)*fact_productsales.Quantity)
    as 'Profit'
    from dim_product
    JOIN fact_productsales
    on dim_product.ProductKey=fact_productsales.ProductID
    JOIN dim_date
    on fact_productsales.SalesDateKey=dim_date.DateKey
    where dim_date.Year=2015
    GROUP BY dim_product.ProductName
    ORDER BY SUM((ProductSalesPrice-ProductActualCost)*fact_productsales.Quantity) DESC
    LIMIT 3;
#5
SELECT QUARTER,
	SUM(fact_productsales.SalesPrice*fact_productsales.Quantity)
    as 'revenue'
    from dim_date
    JOIN fact_productsales
    on fact_productsales.SalesDateKey=dim_date.DateKey
    Join dim_store
    on dim_store.StoreID=fact_productsales.StoreID
    WHERE dim_store.StoreName='ValueMart Boulder' and dim_date.Year=2016
    GROUP BY dim_date.QUARTER
    Order BY SUM(fact_productsales.SalesPrice*fact_productsales.Quantity) DESC
    LIMIT 1;
#6
SELECT CustomerName, SUM(SalesPrice) as 'Total Sales Price'
	FROM Fact_ProductSales
    JOIN Dim_Customer
    ON Fact_ProductSales.CustomerID = Dim_Customer.CustomerID
    WHERE Dim_Customer.CustomerName = "Melinda Gates";
#7
SELECT StoreName,
	SUM(fact_productsales.SalesPrice*fact_productsales.Quantity)
    as 'Total Revenue'
    FROM dim_store
    JOIN fact_productsales
    on dim_store.StoreID=fact_productsales.StoreID
    JOIN dim_date
    on fact_productsales.SalesDateKey=dim_date.DateKey
    where dim_date.YEAR=2013 and dim_date.MONTH ='3'
    GROUP BY StoreName;
#8
SELECT SalesPersonName,
	SUM(fact_productsales.SalesPrice*fact_productsales.Quantity)
    as 'Total Revenue'
	FROM dim_salesperson
    JOIN fact_productsales
    ON dim_salesperson.SalesPersonID=fact_productsales.SalesPersonID
    GROUP BY dim_salesperson.SalesPersonName
    ORDER BY SUM(fact_productsales.SalesPrice*fact_productsales.Quantity) DESC
    LIMIT 1;
#9
SELECT ProductName,
	SUM((Fact_ProductSales.salesprice*Fact_ProductSales.quantity)-(Fact_ProductSales.productcost*Fact_ProductSales.quantity))
    as 'Profit'
	FROM dim_product
    Join Fact_ProductSales
    on dim_product.ProductKey=fact_productsales.ProductID
    GROUP BY ProductName
    ORDER BY SUM((Fact_ProductSales.salesprice*Fact_ProductSales.quantity)-(Fact_ProductSales.productcost*Fact_ProductSales.quantity)) DESC
	LIMIT 1;
#10
SELECT YEAR,MONTHNAME,
	SUM(fact_productsales.SalesPrice*fact_productsales.Quantity)
    as 'Total Revenue'
	FROM dim_date
    JOIN fact_productsales
    on dim_dxate.DateKey=fact_productsales.SalesDateKey
    WHERE (dim_date.MONTH='1' or dim_date.MONTH='2' or dim_date.MONTH='3')
    and dim_date.YEAR=2017
    GROUP BY YEAR,MONTHNAME;