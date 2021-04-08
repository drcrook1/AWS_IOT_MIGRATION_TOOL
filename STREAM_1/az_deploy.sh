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

#Deploy baseline infrastructure
cecho "Deploying Azure Infrastructure...." $cyan
cd terraform
/bin/bash terraform_deploy.sh
cd ..
cecho "Azure Infrastructure Deployed" $green

#Register Devices found in AWS Discovery Step
cecho "Registering AWS things as Azure Devices..." $cyan
cd device_registration
/bin/bash register_devices.sh
cd ..
cecho "Finished Device Registration" $green