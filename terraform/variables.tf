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

##############################################################################
# DB2 Variables
##############################################################################
variable db2_plan {
  description = "DB2 plan"
  default     = "standard"
}

variable db2_key_role {
  description = "DB2 Key Role"
  default     = "Manager"
}
##############################################################################

##############################################################################
# Cloudant Variables
##############################################################################
variable cloudant_plan {
  description = "Cloudant plan"
  default     = "standard"
}

variable cloudant_key_role {
  description = "Cloudant Key Role"
  default     = "Manager"
}
##############################################################################

##############################################################################
# Watson Studio Variables
##############################################################################
variable w_studio_plan {
  description = "Watson Studio plan"
  default     = "free-v1"
}
##############################################################################

##############################################################################
# Watson Machine Learning Variables
##############################################################################
variable wml_plan {
  description = "Watson Machine Learning plan"
  default     = "lite"
}
##############################################################################

##############################################################################
# Network variables
##############################################################################

variable cidr_blocks {
    description = "List of CIDR blocks for subnets" 
    default     = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"] 
}

##############################################################################

##############################################################################
# Cluster Variables
##############################################################################

variable "machine_type" {
  description = "Machine type for the IKS Cluster"
  default     = "bx2.2x8"
}

variable "worker_count" {
  description = "Number of workers per zone"
  default     = 1
}

variable "kube_version" {
  description = "Version of the IKS Cluster"
  default     = "1.20.8"
}
##############################################################################

##############################################################################
# Watson Assistant Variables
##############################################################################
variable w_assistant_plan {
  description = "Watson Assistant plan"
  default     = "free"
}
##############################################################################

##############################################################################
# Watson Knowledge Catalog Variables
##############################################################################
variable w_knowledgecatalog_plan {
  description = "Watson Knowledge Catalog plan"
  default     = "lite"
}
##############################################################################

##############################################################################
# Watson Knowledge Studio Variables
##############################################################################
variable w_knowledgestudio_plan {
  description = "Watson Knowledge Studio plan"
  default     = "free"
}
##############################################################################

##############################################################################
# Language Translator Variables
##############################################################################
variable language_translator_plan {
  description = "Language Translator plan"
  default     = "lite"
}
##############################################################################

##############################################################################
# Natural Language Understanding Variables
##############################################################################
variable natural_language_understanding_plan {
  description = "Natural Language Understanding plan"
  default     = "free"
}
##############################################################################


##############################################################################
# Natural Language Classifier Variables
##############################################################################
variable natural_language_classifier_plan {
  description = "Natural Language Classifier plan"
  default     = "standard"
}
##############################################################################

##############################################################################
# Speech To Text Variables
##############################################################################
variable speechtotext_plan {
  description = "Speech To Text plan"
  default     = "lite"
}
##############################################################################

##############################################################################
# Text To Speech Variables
##############################################################################
variable texttospeech_plan {
  description = "Text To Speech plan"
  default     = "lite"
}
##############################################################################

##############################################################################
# Tone Analyzer Variables
##############################################################################
variable toneanalyzer_plan {
  description = "Tone Analyzer plan"
  default     = "lite"
}
##############################################################################

##############################################################################
# Watson Discovery Variables
##############################################################################
variable w_discovery_plan {
  description = "Watson Discovery plan"
  default     = "lite"
}
##############################################################################
