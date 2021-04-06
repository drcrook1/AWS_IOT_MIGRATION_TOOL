#common

variable "service_name" {
  description = "Name of the application, service, or workload the resource group is housing."
  type        = string
  default     = "iot"
}

variable "name_prefix" {
  description = "A short pre-defined text to identify the resource type"
  type        = string
  default     = "iot-hub"
}

variable "environment" {
  description = "Development environment for resource; prod, non-prod, shared-services"
  type        = string
}

variable "region" {
  description = "Geographic Region resource will be deployed into"
  type        = string
}

variable "random_string_result" {
  description = "The generated random string."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The Name of this Resource Group."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(any)
  default     = {}
}

#iot hub

variable "hub_sku_name" {
  description = "(Required) The name of the sku. Possible values are B1, B2, B3, F1, S1, S2, and S3."
  type        = string
  default     = "S1"
}

variable "hub_sku_capacity" {
  description = "(Required) The number of provisioned IoT Hub units."
  type        = string
  default     = 1
}

#iot dps

variable "dps_sku_name" {
  description = "(Required) The name of the sku. Currently can only be set to S1."
  type        = string
  default     = "S1"
}

variable "dps_sku_capacity" {
  description = " (Required) The number of provisioned IoT Device Provisioning Service units."
  type        = string
  default     = 1
}