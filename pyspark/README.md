# PySpark Projects

This directory contains PySpark notebooks and scripts for learning Apache Spark with Python.

## Notebooks

### quickstart.ipynb
Introduction to PySpark covering:
- Spark session initialization
- RDD operations
- DataFrame basics
- SQL queries
- Performance optimization

### wordcount_rdd_df.ipynb
Comparison of different approaches to implement WordCount:
- RDD-based implementation
- DataFrame-based implementation  
- SQL-based implementation
- Performance analysis

## Setup Instructions

### Prerequisites
- Python 3.7+
- Apache Spark 3.x
- Jupyter Notebook
- PySpark library

### Installation
```bash
# Install PySpark
pip install pyspark

# Install Jupyter
pip install jupyter

# Start Jupyter
jupyter notebook
```

### Running Notebooks
1. Start Jupyter Notebook server
2. Navigate to the pyspark directory
3. Open desired notebook
4. Run cells sequentially

## Sample Data
Sample datasets are available in `../data/sample/` directory for practicing with realistic data.

## Learning Path
1. Start with `quickstart.ipynb` to learn basics
2. Progress to `wordcount_rdd_df.ipynb` for advanced concepts
3. Experiment with your own datasets