import argparse
import boto3
import json
from uuid import uuid4
import os

parser = argparse.ArgumentParser(description="Create an AWS job to migrate an IoT Thing to Azure")
parser.add_argument('--s3bucket', required=True, help="Bucket with azure code. ")
parser.add_argument('--s3bucket-key-id', required=True, help="Bucket key ID. ")
parser.add_argument('--s3bucket-key', required=True, help="Bucket key. ")
parser.add_argument('--jsontoprocess', required=True, help="aws-things-azure-processed file")
args = parser.parse_args()

if __name__ == '__main__':

    client = boto3.client(
        'iot',
        region_name=os.environ["AWS_REGION"],
        aws_access_key_id=os.environ["AWS_KEY_ID"],
        aws_secret_access_key=os.environ["AWS_KEY"]
    )

    with open (args.jsontoprocess) as file:
        jsonJobDoc = json.load(file)
    
    for thing in jsonJobDoc['things']:
        print (thing['thingName'])
        print (thing['thingArn'])
        print (thing['azure']['iotconnstr'])

        response = client.create_job(
            jobId='upgrade-'+thing['thingName'] + "-" + str(uuid4()),
            targets=[
                thing['thingArn'],
            ],
            document="{ \"operation\": \"upgradetoAzure\", \"fileBucket\": \""+args.s3bucket+"\", \"ACCESS_KEY\": \""+args.s3bucket_key_id + "\",\"SECRET_KEY\": \""+args.s3bucket_key + "\", \"AZURE_CONNECTION_STRING\": \""+thing['azure']['iotconnstr'] + "\" }",
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