import boto3
import csv
import os
import random
import datetime

def create_temp_files(bucket, key):
    file_extension = key.split('.')[-1]
    
    if file_extension == 'csv':
        s3_client = boto3.client('s3')
        s3_object = s3_client.get_object(Bucket=bucket, Key=key)
        
        csv_content = s3_object['Body'].read().decode('utf-8')

        temp_input_file = f"/tmp/{key}"
        temp_output_file = temp_input_file.replace('.csv', '_output.csv')
        
        # Write the original CSV content to the temporary input file
        with open(temp_input_file, 'w', newline='') as input_file:
            input_file.write(csv_content)

        # 🛠️ Create the output CSV file (even if empty)
        with open(temp_output_file, 'w', newline='') as output_file:
            output_file.write('')  # Creates an empty file
        
        return temp_input_file, temp_output_file
    else:
        print(f"File type not supported")
        return None, None

def write_to_bucket(bucket, temp_output_file):
    s3_client = boto3.client('s3')

    # Upload the output file to the S3 bucket as the name of the file in /tmp
    with open(temp_output_file, 'rb') as data:
        s3_client.put_object(
            Bucket=bucket, 
            Key=os.path.basename(temp_output_file),
            Body=data
        )

def lambda_handler(event, context):
    for record in event['Records']:
        object_key = record['s3']['object']['key']

    current_region = os.environ['AWS_REGION']

    bucket_name = f"cl-recipe-bucket-v2-{current_region}"
    output_bucket = f"cl-recipe-distribution-v2-{current_region}"

    temp_input_file, temp_output_file = create_temp_files(bucket_name, object_key)
 
    write_to_bucket(output_bucket, temp_output_file)
            
    # Clean up the temporary files
    os.remove(temp_input_file)
    os.remove(temp_output_file)

if __name__ == '__main__':
    lambda_handler(None, None)