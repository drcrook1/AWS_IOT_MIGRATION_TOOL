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
source /mnt/env.sh
cecho $IOT_HUB_NAME $cyan
cecho $DAVID_VAR $cyan

# Read .json file

jq -rc '.things[]' ../device_registration/sample_aws.json | while IFS='' read thing;do
    name=$(echo "$thing" | jq .thingName)
    name="${name%\"}"
    name="${name#\"}"
    arn=$(echo "$thing" | jq .thingArn)
    cecho "$name" $magenta
    cecho "$arn" $magenta
    az iot hub device-identity create --device-id $name --hub-name $IOT_HUB_NAME
done

cecho "Registered All Devices in File" $green