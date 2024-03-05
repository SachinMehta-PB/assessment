import json
import boto3
import csv
import gzip
from io import BytesIO
import redis

# AWS credentials and region
aws_region_name = 'us-east-2'

# ElastiCache for Redis endpoint
redis_endpoint = 'aws_elasticache_cluster'
redis_port = 11211

# S3 bucket details
s3_bucket_name = 'stateassess'
s3_key_prefix = 'elastiCacheData/'

# Connect to ElastiCache for Redis
redis_client = redis.StrictRedis(host=redis_endpoint, port=redis_port, decode_responses=True)

# Connect to S3
s3_client = boto3.client('s3', region_name=aws_region_name)

def export_redis_data_to_s3(event, context):
    # Fetch data from Redis
    redis_data = redis_client.keys('*')  # Example: Fetch all keys, modify this according to your data structure
    
    # Prepare data for CSV
    data_to_export = []
    for key in redis_data:
        value = redis_client.get(key)
        data_to_export.append({'key': key, 'value': value})
    
    # Write CSV data to a string buffer
    csv_buffer = BytesIO()
    fieldnames = ['key', 'value']
    writer = csv.DictWriter(csv_buffer, fieldnames=fieldnames)
    writer.writeheader()
    for item in data_to_export:
        writer.writerow(item)
    
    # Write CSV to S3 bucket
    s3_key = s3_key_prefix + 'elastiCacheData.csv.gz'
    csv_buffer.seek(0)
    s3_client.upload_fileobj(gzip.GzipFile(fileobj=csv_buffer), s3_bucket_name, s3_key)

    print(f"Data exported to S3: s3://{s3_bucket_name}/{s3_key}")

    return {
        'statusCode': 200,
        'body': json.dumps('Data exported successfully to S3!')
    }