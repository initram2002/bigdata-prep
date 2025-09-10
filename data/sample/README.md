# Sample Data Directory

This directory contains sample datasets for practicing big data processing techniques.

## Available Datasets

### employees.csv
Employee data with the following fields:
- employee_id: Unique identifier
- name: Employee full name
- department: Engineering, Data Science, Marketing
- salary: Annual salary
- hire_date: Date of hiring
- age: Employee age
- performance_score: Performance rating (1-5 scale)

**Use cases:**
- Aggregations by department
- Salary analysis
- Performance correlations
- Time-based hiring trends

### sales_data.csv
E-commerce transaction data with fields:
- transaction_id: Unique transaction identifier
- customer_id: Customer identifier
- product_category: Electronics, Clothing, Books
- amount: Transaction amount
- transaction_date: Date of transaction
- payment_method: Credit Card, Debit Card, PayPal, Cash
- region: North, South, East, West

**Use cases:**
- Sales analytics by region
- Payment method preferences
- Category performance analysis
- Time series analysis

## Data Usage Examples

### Hadoop MapReduce
```bash
# Upload to HDFS
hdfs dfs -put employees.csv /input/

# Process with MapReduce
hadoop jar wordcount.jar WordCount /input /output
```

### PySpark
```python
# Load data
df = spark.read.csv("employees.csv", header=True, inferSchema=True)

# Analyze
df.groupBy("department").avg("salary").show()
```

### SQL
```sql
-- Create external table
CREATE TABLE employees (
    employee_id INT,
    name STRING,
    department STRING,
    salary INT,
    hire_date DATE,
    age INT,
    performance_score DOUBLE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/data/sample/';
```

## Data Generation
These datasets are synthetic and generated for educational purposes. For larger datasets or specific formats, consider using data generation tools or public datasets like:
- NYC Taxi data
- MovieLens dataset
- Apache access logs
- Stock market data

## Best Practices
1. Always backup original data before processing
2. Validate data quality before analysis
3. Use appropriate file formats (Parquet, ORC) for production
4. Consider partitioning strategies for large datasets
5. Implement proper error handling for data ingestion