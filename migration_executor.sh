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

cecho "Please log in to azure with your credentials" $blue
az login

cecho "Analyzing AWS IoT Environment..." $blue
cd Stream0/aws_env_reader
cecho "mapping registered things..." $cyan
python3 list-things.py
cecho "mapping policies..." $cyan
python3 list-policies.py
cd /app

cecho "Building Azure IoT Environment..." $blue
cd STREAM_1
/bin/bash az_deploy.sh
cd /app

cecho "Upgrading All Devices Firmware to Azure..." $blue