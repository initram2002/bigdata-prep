-- Sales Data Analysis Queries
-- Advanced SQL queries for sales analytics

-- Sales performance by region
SELECT 
    region,
    COUNT(*) as transaction_count,
    SUM(amount) as total_sales,
    AVG(amount) as avg_transaction_value,
    MIN(amount) as min_transaction,
    MAX(amount) as max_transaction
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;

-- Product category analysis
SELECT 
    product_category,
    COUNT(*) as transactions,
    SUM(amount) as revenue,
    AVG(amount) as avg_order_value,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(), 2) as transaction_percentage,
    ROUND(100.0 * SUM(amount) / SUM(SUM(amount)) OVER(), 2) as revenue_percentage
FROM sales_data
GROUP BY product_category
ORDER BY revenue DESC;

-- Payment method preferences by region
SELECT 
    region,
    payment_method,
    COUNT(*) as usage_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER(PARTITION BY region), 2) as percentage_in_region
FROM sales_data
GROUP BY region, payment_method
ORDER BY region, usage_count DESC;

-- Daily sales trends
SELECT 
    transaction_date,
    COUNT(*) as daily_transactions,
    SUM(amount) as daily_revenue,
    AVG(amount) as avg_transaction_value,
    LAG(SUM(amount)) OVER (ORDER BY transaction_date) as prev_day_revenue,
    SUM(amount) - LAG(SUM(amount)) OVER (ORDER BY transaction_date) as revenue_change
FROM sales_data
GROUP BY transaction_date
ORDER BY transaction_date;

-- Customer transaction patterns
SELECT 
    customer_id,
    COUNT(*) as total_transactions,
    SUM(amount) as total_spent,
    AVG(amount) as avg_order_value,
    MIN(transaction_date) as first_purchase,
    MAX(transaction_date) as last_purchase,
    DATEDIFF(MAX(transaction_date), MIN(transaction_date)) as customer_lifetime_days
FROM sales_data
GROUP BY customer_id
HAVING COUNT(*) > 1  -- Only customers with multiple transactions
ORDER BY total_spent DESC;

-- Top spending customers by category
WITH customer_category_spending AS (
    SELECT 
        customer_id,
        product_category,
        SUM(amount) as category_spending,
        COUNT(*) as category_transactions
    FROM sales_data
    GROUP BY customer_id, product_category
),
ranked_customers AS (
    SELECT 
        customer_id,
        product_category,
        category_spending,
        category_transactions,
        ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY category_spending DESC) as spending_rank
    FROM customer_category_spending
)
SELECT 
    product_category,
    customer_id,
    category_spending,
    category_transactions,
    spending_rank
FROM ranked_customers
WHERE spending_rank <= 3
ORDER BY product_category, spending_rank;