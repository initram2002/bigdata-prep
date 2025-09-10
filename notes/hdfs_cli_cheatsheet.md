# HDFS Command Line Interface (CLI) Cheatsheet

## Basic File Operations

### List Files and Directories
```bash
# List files in HDFS root
hdfs dfs -ls /

# List files in specific directory
hdfs dfs -ls /user/data

# List files recursively
hdfs dfs -ls -R /user

# List with human-readable file sizes
hdfs dfs -ls -h /user/data
```

### Create Directories
```bash
# Create single directory
hdfs dfs -mkdir /user/data

# Create nested directories
hdfs dfs -mkdir -p /user/data/input/raw
```

### Copy Files

#### From Local to HDFS
```bash
# Copy single file
hdfs dfs -put localfile.txt /user/data/

# Copy entire directory
hdfs dfs -put -f local_dir/ /user/data/

# Copy with progress indication
hdfs dfs -put -p localfile.txt /user/data/
```

#### From HDFS to Local
```bash
# Copy single file
hdfs dfs -get /user/data/file.txt ./

# Copy entire directory
hdfs dfs -get /user/data/output ./local_output

# Copy and merge files
hdfs dfs -getmerge /user/data/output/* merged_output.txt
```

#### Within HDFS
```bash
# Copy file within HDFS
hdfs dfs -cp /user/data/input.txt /user/backup/

# Move/rename file
hdfs dfs -mv /user/data/old_name.txt /user/data/new_name.txt
```

### View File Contents
```bash
# Display entire file
hdfs dfs -cat /user/data/file.txt

# Display first few lines
hdfs dfs -head /user/data/file.txt

# Display last few lines
hdfs dfs -tail /user/data/file.txt

# Follow file (like tail -f)
hdfs dfs -tail -f /user/logs/app.log
```

### File Information
```bash
# Show file statistics
hdfs dfs -stat %n %s %r /user/data/file.txt

# Show disk usage
hdfs dfs -du /user/data/

# Show disk usage in human-readable format
hdfs dfs -du -h /user/data/

# Show summary of directory
hdfs dfs -dus /user/data/

# Count files and directories
hdfs dfs -count /user/data/
```

### Delete Operations
```bash
# Delete file
hdfs dfs -rm /user/data/file.txt

# Delete directory (recursive)
hdfs dfs -rm -r /user/data/temp/

# Delete with skip trash
hdfs dfs -rm -skipTrash /user/data/file.txt

# Empty trash
hdfs dfs -expunge
```

## File Permissions

### Change Permissions
```bash
# Change file permissions (like chmod)
hdfs dfs -chmod 755 /user/data/file.txt

# Change permissions recursively
hdfs dfs -chmod -R 644 /user/data/

# Change owner
hdfs dfs -chown user:group /user/data/file.txt

# Change group
hdfs dfs -chgrp hadoop /user/data/file.txt
```

## Advanced Operations

### File System Check
```bash
# Check file system
hdfs fsck /

# Check specific directory
hdfs fsck /user/data

# Check with file details
hdfs fsck /user/data -files -blocks -locations
```

### Block Operations
```bash
# Show block locations
hdfs fsck /user/data/large_file.txt -blocks -locations

# Balance cluster
hdfs balancer

# Set replication factor
hdfs dfs -setrep 3 /user/data/important_file.txt
```

### Administrative Commands
```bash
# Safe mode operations
hdfs dfsadmin -safemode get
hdfs dfsadmin -safemode enter
hdfs dfsadmin -safemode leave

# Report file system status
hdfs dfsadmin -report

# Refresh nodes
hdfs dfsadmin -refreshNodes
```

## Performance and Monitoring

### Monitor Operations
```bash
# Check current operations
hdfs dfsadmin -printTopology

# Monitor data nodes
hdfs dfsadmin -report

# Check name node status
hdfs haadmin -getServiceState nn1
```

### Benchmarking
```bash
# Test write performance
hdfs dfs -put /dev/zero /tmp/test_file

# Test read performance
hdfs dfs -get /tmp/test_file /dev/null

# Distributed file system benchmark
hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-tests.jar TestDFSIO -write -nrFiles 10 -fileSize 1GB
```

## Common Use Cases

### Data Pipeline Operations
```bash
# Archive old data
hdfs dfs -mv /user/data/2023/ /user/archive/

# Backup important files
hdfs dfs -cp -p /user/production/ /user/backup/

# Clean up temporary files
hdfs dfs -rm -r /user/temp/*

# Monitor log files
hdfs dfs -tail -f /user/logs/application.log
```

### Development Workflow
```bash
# Upload input data
hdfs dfs -put input_data.csv /user/input/

# Run MapReduce job
hadoop jar wordcount.jar WordCount /user/input /user/output

# Check output
hdfs dfs -cat /user/output/part-r-00000

# Download results
hdfs dfs -get /user/output/part-r-00000 results.txt
```

## Tips and Best Practices

1. **Use -p flag** when copying to preserve permissions and timestamps
2. **Set appropriate replication** for important files using -setrep
3. **Monitor disk usage** regularly with -du commands
4. **Use -skipTrash** for large files to avoid filling trash
5. **Check file system health** with fsck regularly
6. **Use -f flag** with put to force overwrite existing files
7. **Compress large files** before uploading to save space
8. **Use getmerge** to combine multiple small files into one

## Environment Variables
```bash
# Common HDFS environment variables
export HADOOP_CONF_DIR=/etc/hadoop/conf
export HDFS_NAMENODE_USER=hdfs
export HDFS_DATANODE_USER=hdfs
export HDFS_SECONDARYNAMENODE_USER=hdfs
```