-- detailed information from multiple joined tables
SELECT
    od.id        AS order_detail_id,
    o.id         AS order_id,
    o.date       AS order_date,
    c.name       AS customer_name,
    e.employee_id,
    e.first_name,
    e.last_name,
    p.name       AS product_name,
    cat.name     AS category_name,
    s.name       AS shipper_name,
    sup.name     AS supplier_name,
    od.quantity
FROM order_details od
INNER JOIN orders o       ON od.order_id = o.id
INNER JOIN customers c    ON o.customer_id = c.id
INNER JOIN employees e    ON o.employee_id = e.employee_id
INNER JOIN products p     ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN shippers s     ON o.shipper_id = s.id
INNER JOIN suppliers sup  ON p.supplier_id = sup.id;

-- total rows in a complex join across multiple tables
SELECT COUNT(*) AS total_rows
FROM order_details od
INNER JOIN orders o       ON od.order_id = o.id
INNER JOIN customers c    ON o.customer_id = c.id
INNER JOIN employees e    ON o.employee_id = e.employee_id
INNER JOIN products p     ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
INNER JOIN shippers s     ON o.shipper_id = s.id
INNER JOIN suppliers sup  ON p.supplier_id = sup.id;

-- total rows in a complex join across multiple tables

SELECT COUNT(*) AS total_rows
FROM order_details od
LEFT JOIN orders o       ON od.order_id = o.id
LEFT JOIN customers c    ON o.customer_id = c.id
LEFT JOIN employees e    ON o.employee_id = e.employee_id
LEFT JOIN products p     ON od.product_id = p.id
LEFT JOIN categories cat ON p.category_id = cat.id
LEFT JOIN shippers s     ON o.shipper_id = s.id
LEFT JOIN suppliers sup  ON p.supplier_id = sup.id;

-- detailed category quantities for employees with IDs between 4 and 10
SELECT
    cat.name     AS category_name,
    od.quantity
FROM order_details od
INNER JOIN orders o       ON od.order_id = o.id
INNER JOIN employees e    ON o.employee_id = e.employee_id
INNER JOIN products p     ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
WHERE e.employee_id > 3
  AND e.employee_id <= 10;

-- category statistics for employees with IDs between 4 and 10

SELECT
    cat.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN orders o       ON od.order_id = o.id
INNER JOIN employees e    ON o.employee_id = e.employee_id
INNER JOIN products p     ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
WHERE e.employee_id > 3
  AND e.employee_id <= 10
GROUP BY cat.name;

-- category statistics for employees with IDs between 4 and 10

SELECT
    cat.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN orders o       ON od.order_id = o.id
INNER JOIN employees e    ON o.employee_id = e.employee_id
INNER JOIN products p     ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
WHERE e.employee_id > 3
  AND e.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21;

-- sort limited category statistics for employees with IDs between 4 and 10
SELECT
    cat.name AS category_name,
    COUNT(*) AS total_rows,
    AVG(od.quantity) AS avg_quantity
FROM order_details od
INNER JOIN orders o       ON od.order_id = o.id
INNER JOIN employees e    ON o.employee_id = e.employee_id
INNER JOIN products p     ON od.product_id = p.id
INNER JOIN categories cat ON p.category_id = cat.id
WHERE e.employee_id > 3
  AND e.employee_id <= 10
GROUP BY cat.name
HAVING AVG(od.quantity) > 21
ORDER BY total_rows DESC
LIMIT 4 OFFSET 1;