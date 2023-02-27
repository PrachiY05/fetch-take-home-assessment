--Which brand saw the most dollars spent in the month of June?
SELECT TOP 5 b.BRAND_CODE, DATENAME(MONTH, ri.MODIFY_DATE) AS MONTH_NAME, ri.TOTAL_FINAL_PRICE
FROM brands AS b 
INNER JOIN receipt_items AS ri 
ON b.BRAND_CODE = ri.BRAND_CODE 
WHERE MONTH(ri.MODIFY_DATE) = 6
GROUP BY b.BRAND_CODE, DATENAME(MONTH, ri.MODIFY_DATE), ri.TOTAL_FINAL_PRICE
ORDER BY ri.TOTAL_FINAL_PRICE DESC;
--'ANNIES HOMEGROWN' brand saw the most dollars spent in the month of June with a total spend of $493.9

--Which user spent the most money in the month of August?
SELECT TOP 5 u.ID AS USER_ID, DATENAME(MONTH, r.PURCHASE_DATE) AS MONTH_NAME, SUM(r.TOTAL_SPENT) AS TOTAL_SPENT
FROM users AS u
INNER JOIN receipts AS r
ON u.ID = r.USER_ID
WHERE MONTH(r.PURCHASE_DATE) = 8
GROUP BY u.ID, DATENAME(MONTH, r.PURCHASE_DATE)
ORDER BY TOTAL_SPENT DESC;
--User '609ab37f7a2e8f2f95ae968f' spent the most money in the month of August

--What user bought the most expensive item?
SELECT u.ID AS USER_ID, ri.REWARDS_RECEIPT_ITEM_ID, ri.DESCRIPTION, MAX(ri.TOTAL_FINAL_PRICE / ri.QUANTITY_PURCHASED) AS PRICE 
FROM users AS u
INNER JOIN receipts AS r
ON u.ID = r.USER_ID
INNER JOIN receipt_items AS ri
ON r.ID = ri.REWARDS_RECEIPT_ID
WHERE ri.QUANTITY_PURCHASED > 0 AND ri.TOTAL_FINAL_PRICE > 0
GROUP BY u.ID, ri.REWARDS_RECEIPT_ITEM_ID, ri.DESCRIPTION
ORDER BY PRICE DESC;
--User '617376b8a9619d488190e0b6' bought the most expensive item in the form of a 'Starbucks Iced Coffee' with a price of '31005.99'
--But the data looks faulty and the next believable item/spend is a 'CHECKING DEPOSIT' of '8700' by user '6032cb807d464912dab4dc1e'

--What is the name of the most expensive item purchased?
SELECT TOP 5 b.ID AS BRAND_ID, b.NAME, MAX(ri.TOTAL_FINAL_PRICE / ri.QUANTITY_PURCHASED) AS PRICE 
FROM brands AS b
INNER JOIN receipt_items AS ri
ON b.BRAND_CODE = ri.BRAND_CODE
WHERE ri.QUANTITY_PURCHASED != 0
GROUP BY b.ID, b.NAME
ORDER BY PRICE DESC;
--'Starbucks' is the most expensive item purchased with a price of '31005.99'
--But the data looks faulty and the next believable item/spend is 'IMPERIAL' with a price of '1400'

--How many users scanned in each month?
SELECT DATENAME(MONTH, r.DATE_SCANNED) AS MONTH_NAME, COUNT(DISTINCT u.ID) AS NO_OF_USERS
FROM users AS u
INNER JOIN receipts AS r
ON u.ID = r.USER_ID
GROUP BY DATENAME(MONTH, r.DATE_SCANNED), MONTH(r.DATE_SCANNED)
ORDER BY MONTH(r.DATE_SCANNED);
--Average number of users scanning in each month is '90.5'