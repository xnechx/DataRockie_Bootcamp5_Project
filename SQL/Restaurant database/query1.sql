-- Top 5 Spenders
WITH spend AS (SELECT 
                o.bill_id,
                SUM(o.quantity * m.price) spending
                FROM orders o
                JOIN menus m
                USING (menu_id)
                GROUP BY o.bill_id)

SELECT b.customer_id,
  c.firstname,
  c.lastname,
  c.birthdate,
  c.gmail,
  SUM(s.spending) total_spending
FROM bills b
JOIN spend s
USING (bill_id)
JOIN customers c
ON b.customer_id = c.customer_id
GROUP BY b.customer_id
ORDER BY SUM(s.spending) DESC
LIMIT 5;


-- Top 5 Popular Dishes
SELECT 
  m.menu_name,
  SUM(o.quantity) total_order
FROM orders o
JOIN menus m
USING (menu_id)
WHERE m.menu_type = "food"
GROUP BY m.menu_name
ORDER BY SUM(o.quantity) DESC
LIMIT 5;


-- Compare each branch's sales
WITH sales AS (SELECT 
                o.bill_id,
                SUM(o.quantity * m.price) sales
                FROM orders o
                JOIN menus m
                USING (menu_id)
                GROUP BY o.bill_id)
  
SELECT 
  bran.branch_id,
  bran.location,
  bran.scale,
  SUM(sales) total_sales
FROM bills bill 
JOIN branches bran
USING (branch_id)
JOIN sales s
ON bill.bill_id = s.bill_id
GROUP BY 1
ORDER BY 4 DESC;
  

-- Birthday Gift Voucher
WITH cusbirth AS (SELECT 
                  customer_id,
                  firstname,
                  lastname,
                  gmail,
                  CAST(strftime("%m", birthdate) AS INT) AS birthmonth,
                  CAST(strftime("%m", "now") AS INT) AS thismonth
                FROM customers
                WHERE birthmonth = thismonth),
  
      spend AS (SELECT 
                o.bill_id,
                SUM(o.quantity * m.price) spending
                FROM orders o
                JOIN menus m
                USING (menu_id)
                GROUP BY o.bill_id)

SELECT 
  c.customer_id,
  c.firstname,
  c.lastname,
  c.birthmonth,
  c.gmail,
  AVG(s.spending) avg_spending
FROM spend s
JOIN bills b
USING (bill_id)
JOIN cusbirth c
USING (customer_id)
GROUP BY 1
ORDER BY avg_spending DESC;