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

#
# This is the simplest way to set it up, not secure or whatever, but works for an open sourced example.
#
terraform init

cecho "Starting Terraform Plan..." $magenta
# terraform plan -state=/mnt/tfstate/terraform.tfstate -out=tfplan.out
terraform plan -out=tfplan.out
cecho "Completed Terraform Plan..." $green

cecho "Starting Terraform Apply..." $magenta
# terraform apply -state=/mnt/tfstate/terraform.tfstate -auto-approve "tfplan.out"
terraform apply -auto-approve "tfplan.out"
cecho "Completed Terraform Apply..." $green

cecho "$(terraform output iothub_name)" $cyan

IOT_HUB_NAME="$(terraform output -raw iothub_name)"
DAVID_VAR="MY_VARIABLE"

cecho $IOT_HUB_NAME $cyan

printf "export IOT_HUB_NAME=\'$IOT_HUB_NAME'\nexport DAVID_VAR=\'$DAVID_VAR'" >/mnt/env.sh