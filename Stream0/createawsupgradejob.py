import argparse
import boto3
import json
from uuid import uuid4
import os

parser = argparse.ArgumentParser(description="Create an AWS job to migrate an IoT Thing to Azure")
parser.add_argument('--thing-name', required=True, help="Thing name. ")
parser.add_argument('--thing-arn', required=True, help="Thing arn. ")
parser.add_argument('--s3bucket', required=True, help="Bucket with azure code. ")
parser.add_argument('--s3bucket-key-id', required=True, help="Bucket key ID. ")
parser.add_argument('--s3bucket-key', required=True, help="Bucket key. ")
args = parser.parse_args()

if __name__ == '__main__':
    client = boto3.client(
        'iot',
        region_name=os.environ["AWS_REGION"],
        aws_access_key_id=os.environ["AWS_KEY_ID"],
        aws_secret_access_key=os.environ["AWS_KEY"]
    )

    response = client.create_job(
        jobId='upgrade-'+args.thing_name + "-" + str(uuid4()),
        targets=[
            args.thing_arn,
        ],
        document="{ \"operation\": \"upgradetoAzure\", \"fileBucket\": \""+args.s3bucket+"\", \"ACCESS_KEY\": \""+args.s3bucket_key_id + "\",\"SECRET_KEY\": \""+args.s3bucket_key + "\", \"AZURE_CONNECTION_STRING\": \""+"HostName=johnbakairlift.azure-devices.net;DeviceId=JBThing1;SharedAccessKey=jgQ94w6mjFWioNNBj1TG4aKx4pCZypwvyy4sFstuHjk=" + "\" }",
        jobExecutionsRolloutConfig={
            'maximumPerMinute': 5,
            'exponentialRate': {
                'baseRatePerMinute': 5,
                'incrementFactor': 1.1,
                'rateIncreaseCriteria': {
                    'numberOfNotifiedThings': 1
                }
            }
        },
        abortConfig={
            'criteriaList': [
                {
                    'failureType': 'FAILED',
                    'action': 'CANCEL',
                    'thresholdPercentage': 100,
                    'minNumberOfExecutedThings': 1
                },
            ]
        }    
    )