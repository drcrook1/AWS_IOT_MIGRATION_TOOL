import argparse
import boto3
import json
from uuid import uuid4
import os

if __name__ == '__main__':

    client = boto3.client(
        'iot',
        region_name=os.environ["AWS_REGION"],
        aws_access_key_id=os.environ["AWS_KEY_ID"],
        aws_secret_access_key=os.environ["AWS_KEY"]
    )
    response = client.list_things()
    j = json.loads(str(response).replace("\'", "\""))

    f = open("/mnt/list-things-values.json", "w")
    f.write(json.dumps(j, sort_keys=True, indent=4))
    f.close()
    print(json.dumps(j, sort_keys=True, indent=4))

