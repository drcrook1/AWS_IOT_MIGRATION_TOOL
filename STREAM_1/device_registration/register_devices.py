# jq -rc '.things[]' ./list-things-values.json | while IFS='' read thing;do
#     name=$(echo "$thing" | jq .thingName)
#     name="${name%\"}"
#     name="${name#\"}"
#     arn=$(echo "$thing" | jq .thingArn)
#     IOT_HUB_NAME="iot-hub-dev-eastus-08983"
#     az iot hub device-identity create --device-id $name --hub-name $IOT_HUB_NAME
#     iot_conn_str=$(az iot hub device-identity connection-string show --device-id $name --hub-name $IOT_HUB_NAME | jq .connectionString)
#     cecho $iot_conn_str $magenta
#     jq -c ".azure"
# done
import json
import subprocess
import os

with open('./list-things-values.json') as f:
  data = json.load(f)

for thing in data["things"]:
    print(thing["thingName"])
    _ = subprocess.run(["az", "iot", "hub", "device-identity", 
                        "create", "--device-id", thing["thingName"], "--hub-name", os.environ["IOT_HUB_NAME"]], 
        stdout=subprocess.PIPE)
    iot_conn_str = subprocess.run(["az", "iot", "hub", "device-identity", 
                        "connection-string", "show", "--device-id", thing["thingName"], "--hub-name", os.environ["IOT_HUB_NAME"]],
        stdout=subprocess.PIPE).stdout.decode('utf-8')
    iot_conn_str = json.loads(iot_conn_str)["connectionString"]
    thing["azure"] = {}
    thing["azure"]["iotconnstr"] = iot_conn_str

print(data)

with open('/mnt/aws-things-azure-processed.json', 'w') as json_file:
  json.dump(data, json_file)