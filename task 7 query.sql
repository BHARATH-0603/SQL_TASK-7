

-- View for Total Sales per Product
CREATE VIEW product_sales_summary AS
SELECT 
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM 
    products p
JOIN 
    order_items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_id, p.product_name;


-- View for Customer Order Count
CREATE VIEW customer_order_count AS
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.customer_name;


-- View for Latest Orders (last 30 days)
CREATE VIEW recent_orders AS
SELECT 
    o.order_id,
    c.customer_name,
    o.order_date
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
WHERE 
    o.order_date >= CURDATE() - INTERVAL 30 DAY;


-- View for Employee-wise Sales (Joins multiple tables)
CREATE VIEW employee_sales_summary AS
SELECT 
    e.employee_id,
    e.employee_name,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM 
    employees e
JOIN 
    orders o ON e.employee_id = o.salesman_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
GROUP BY 
    e.employee_id, e.employee_name;
