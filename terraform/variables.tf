##############################################################################
# Account Variables
##############################################################################

variable ibm_region {
    default = "us-south"
    description = "IBM Cloud region where all resources will be deployed"
}

variable ibmcloud_api_key {
    description = "IBM Cloud access credentials"
    type        = string
}

##############################################################################
# Unique variables
##############################################################################
variable unique_id {
    description = "The unique identifier"
}
##############################################################################

variable "resource_groups_count" {
  description = "number of resource groups to be created"
  type        = string
}

variable "resource_groups_name" {
  description = "The name of the resource groups to be created"
  type        = string
}

# variable "pipelines_resource_group_name" {
#   description = " the name of the cd resource group"
#   type        = string
# }

variable "resource_group_cd_plan" {
  description = "the continuous delivery plan of the cd resource group to be created"
  type        = string
}

variable "default_cd_plan" {
  description = "continuous delivery plan of the default resource group"
  type        = string
}

##############################################################################
# COS Variables
##############################################################################

variable cos_plan {
  description = "ibm cloud object storage plan"
  default     = "standard"
}

##############################################################################
