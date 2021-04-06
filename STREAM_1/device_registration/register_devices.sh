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
IOT_HUB_NAME=$(terraform output iothub_name)
# Read .json file

for device in $(jq .things.thingName sample_aws.json)
do
    cecho device $green
    az iot hub device-identity create --device-id [device id] --hub-name $IOT_HUB_NAME
done
