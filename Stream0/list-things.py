import argparse
import boto3
import json
from uuid import uuid4

parser = argparse.ArgumentParser(description="get a list of things in your subscription.")
parser.add_argument('--region', required=True, help="Your AWS region. " +
                                                      "Ex: us-west-2")
parser.add_argument('--keyid', help="key id")
parser.add_argument('--key', help="key")
args = parser.parse_args()

if __name__ == '__main__':

    client = boto3.client(
        'iot',
        region_name=args.region,
        aws_access_key_id=args.keyid,
        aws_secret_access_key=args.key
    )
    response = client.list_things()
    j = json.loads(str(response).replace("\'", "\""))

    f = open("/mnt/list-things-values.json", "w")
    f.write(json.dumps(j, sort_keys=True, indent=4))
    f.close()
    print(json.dumps(j, sort_keys=True, indent=4))

