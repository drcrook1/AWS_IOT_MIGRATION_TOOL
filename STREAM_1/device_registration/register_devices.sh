#!/bin/bash

red=$'\e[1;31m'
green=$'\e[1;32m'
blue=$'\e[1;34m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
white=$'\e[0m'

cecho ()                     # Color-echo.
                             # Argument $1 = message
                             # Argument $2 = color
{

  message=${1}   # Defaults to default message.
  color=${2}           # Defaults to black, if not specified.

  echo $color "$message" $white

  return
}

# collect terraform outputs for keys & iot hub name
# source /mnt/env.sh
# cecho $IOT_HUB_NAME $cyan
# cecho $DAVID_VAR $cyan

# Read .json file

jq -rc '.things[]' ./list-things-values.json | while IFS='' read thing;do
    name=$(echo "$thing" | jq .thingName)
    name="${name%\"}"
    name="${name#\"}"
    arn=$(echo "$thing" | jq .thingArn)
    # cecho "$name" $magenta
    # cecho "$arn" $magenta
    $IOT_HUB_NAME="rg-aws-az-iot-dev-eastus-08983"
    primary_key=$(az iot hub device-identity create --device-id $name --hub-name $IOT_HUB_NAME | jq .authentication.symmetricKey.primaryKey)
    cecho $primary_key $red
    $HOST_NAME=$IOT_HUB_NAME+".azure-devices.net"
    iot_conn_str="HostName=$HOST_NAME;DeviceId=$name;SharedAccessKey=$primary_key"
    cecho $iot_conn_str $red
done
