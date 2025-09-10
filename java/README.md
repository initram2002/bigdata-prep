# Hadoop WordCount Project

Classic MapReduce WordCount implementation using Java and Maven.

## Build and Run

### Prerequisites
- Java 8+
- Maven 3.6+
- Hadoop cluster (local or distributed)

### Build
```bash
mvn clean package
```

### Run Locally
```bash
# Create input directory
hadoop fs -mkdir /input

# Copy input files
hadoop fs -put input.txt /input/

# Run WordCount
hadoop jar target/hadoop-wordcount-1.0.0.jar com.bigdataprep.WordCount /input /output

# View results
hadoop fs -cat /output/part-r-00000
```

### Run on Cluster
```bash
# Submit to YARN
yarn jar target/hadoop-wordcount-1.0.0.jar com.bigdataprep.WordCount /input /output
```

## Sample Input
Create a file named `input.txt` with sample text to test the WordCount program.

## Learning Objectives
- Understand MapReduce programming model
- Learn Hadoop job configuration
- Practice distributed computing concepts
- Master Maven build tools for Hadoop projects