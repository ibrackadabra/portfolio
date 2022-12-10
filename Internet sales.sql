		-- EXPLORING DATE DATA
SELECT
	*
FROM
	[AdventureWorksDW2019].[dbo].[DimDate];


		-- SELECTING NECESSARY COLUMNS
SELECT	
	[DateKey],
	[FullDateAlternateKey] AS Date,
	--	[DayNumberOfWeek],
	[EnglishDayNameOfWeek] AS Day,
	--	[SpanishDayNameOfWeek],
    --	[FrenchDayNameOfWeek],
    --	[DayNumberOfMonth],
    --	[DayNumberOfYear],
    --	[WeekNumberOfYear],
	[EnglishMonthName] AS Month,
	LEFT ([EnglishMonthName],3) AS MonthShort,
	--	[SpanishMonthName],
    --	[FrenchMonthName],
	[MonthNumberOfYear] As MonthNo,
	--	[CalendarSemester],
	[CalendarQuarter] AS Quarter,
	[CalendarYear] AS Year

FROM
	[AdventureWorksDW2019].[dbo].[DimDate];



		-- EXPLORING CUSTOMER DATA
SELECT
	*
FROM
	[AdventureWorksDW2019].[dbo].[DimCustomer];

		--SELECTING NECESSARY COLUMNS
SELECT
	c.[CustomerKey],
    --	[GeographyKey],
    --	[CustomerAlternateKey],
    --	[Title],
    --	[FirstName],
    --	[MiddleName],
    --	[LastName],
	CONCAT([FirstName],' ', [LastName]) AS Name,
    --	[NameStyle],
    --	[BirthDate],
  	CASE c.[MaritalStatus]  WHEN 'M' THEN 'Married'
	WHEN 'S' THEN 'Single' END AS MaritalStatus,
  	--	[Suffix],
    CASE c.[Gender] WHEN 'M' THEN 'Male'
	WHEN 'F' THEN 'Female' END AS Gender,
	c.[AddressLine1] AS AddressLine,
	g.[City],
	g.[StateProvinceName] AS State,
	g.[EnglishCountryRegionName] AS Country,
    --	[AddressLine2],
    --	[EmailAddress],
    c.[YearlyIncome],
    c.[TotalChildren],
    c.[NumberChildrenAtHome],
  	--	[EnglishEducation],
 	--	[SpanishEducation],
    --	[FrenchEducation],
	c.[EnglishOccupation],
    --	[SpanishOccupation],
    --	[FrenchOccupation],
    --	[HouseOwnerFlag],
    --	[NumberCarsOwned],
    --	[Phone],
    c.[DateFirstPurchase]

FROM
	[AdventureWorksDW2019].[dbo].[DimCustomer] AS c
	LEFT JOIN [AdventureWorksDW2019].[dbo].[DimGeography] AS g ON c.GeographyKey = g.GeographyKey

ORDER BY
	c.CustomerKey;


		-- EXPLORING PRODUCT DATA
SELECT
	*
FROM
	[AdventureWorksDW2019].[dbo].[DimProduct];


		-- SELECTING NECESSARY COLUMNS
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  --	[ProductSubcategoryKey], 
  --	[WeightUnitMeasureCode], 
  --	[SizeUnitMeasureCode], 
  p.[EnglishProductName] AS ProductName,
  ps.[EnglishProductSubcategoryName] AS SubCategory,
  pc.[EnglishProductCategoryName] AS ProductCategory,
  --	[SpanishProductName], 
  --	[FrenchProductName], 
  --	[StandardCost], 
  --	[FinishedGoodsFlag], 
  p.[Color] AS ProductColor, 
  --	[SafetyStockLevel], 
  --	[ReorderPoint], 
  --	[ListPrice], 
  p.[Size], 
  p.[SizeRange], 
  p.[Weight], 
  p.[DaysToManufacture], 
  p.[ProductLine], 
  p.[DealerPrice], 
  --	[Class], 
  --	[Style], 
  p.[ModelName], 
  --	[LargePhoto], 
  p.[EnglishDescription],
  --	[FrenchDescription], 
  --	[ChineseDescription], 
  --	[ArabicDescription], 
  --	[HebrewDescription], 
  --	[ThaiDescription], 
  --	[GermanDescription], 
  --	[JapaneseDescription], 
  --	[TurkishDescription], 
  p.[StartDate], 
  p.[EndDate], 
  ISNULL (p.[Status], 'Outdated') AS ProductStatus

FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] AS p
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductSubcategory] AS ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
  LEFT JOIN [AdventureWorksDW2019].[dbo].[DimProductCategory] AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey

ORDER BY
	p.ProductKey;

		-- EXPLORING INTERNET SALES DATA
--
SELECT
	*
FROM
	[AdventureWorksDW2019].[dbo].[FactInternetSales];

		-- SELECTING NECESSARY COLUMNS
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey], 
  --	[PromotionKey], 
  --	[CurrencyKey], 
  --	[SalesTerritoryKey], 
  [SalesOrderNumber], 
  --	[SalesOrderLineNumber], 
  --	[RevisionNumber], 
  --	[OrderQuantity], 
  [UnitPrice], 
  [ExtendedAmount], 
  -- [UnitPriceDiscountPct], 
  [DiscountAmount], 
  [ProductStandardCost], 
  [TotalProductCost], 
  [SalesAmount], 
  [TaxAmt], 
  [Freight], 
  --	[CarrierTrackingNumber], 
  --	[CustomerPONumber], 
  [OrderDate], 
  [DueDate], 
  [ShipDate]
  
FROM 
  [AdventureWorksDW2019].[dbo].[FactInternetSales]

WHERE
	LEFT (OrderDateKey,4) >= YEAR(GETDATE())-3
ORDER BY
	OrderDateKey;