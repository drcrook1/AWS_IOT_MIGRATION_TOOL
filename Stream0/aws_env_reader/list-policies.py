# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0.

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
    response = client.list_policies()
    foo = str(response)
    j = json.loads("{" + foo[foo.find("\'policies\'"):].replace("\'", "\""))

    dumped = eval(json.dumps(j))

    policy_set = set()
    for value in dumped['policies']:
        policy_set.add(value['policyName'])

    # Make a new dict based on the policies
    final_dict = dict.fromkeys(policy_set)
    policies_details = "{\n    \"policies\": ["
    k = 0

    for key in final_dict:
        response = client.get_policy(policyName=key)
        if k == 0:
            foo = ""
            bar = ""
            policies_details += "\n {" + str(response)[str(response).find("\'policyName\'"):].replace("\'", "\"")
            policies_details = policies_details[:policies_details.find("\"defaultVersionId")-3]
            bar = policies_details[policies_details.rfind("\"Version"):]
            foo = policies_details[:policies_details.rfind("\"Version")]
            bar = bar.replace("\"", "\\\"")
            policies_details = foo + bar + "\"}"
            k = 1
        else:
            foo = ""
            bar = ""
            policies_details += ",\n {" + str(response)[str(response).find("\'policyName\'"):].replace("\'", "\"")
            policies_details = policies_details[:policies_details.find("\"defaultVersionId") - 3]
            bar = policies_details[policies_details.rfind("\"Version"):]
            foo = policies_details[:policies_details.rfind("\"Version")]
            bar = bar.replace("\"", "\\\"")
            policies_details = foo + bar + "\"}"
            
    policies_details += "\n    ]\n}"

    k = json.loads(policies_details)

    f = open("/mnt/list-policies-values.json", "w")
    f.write(json.dumps(k, indent=4))
    f.close()
    
