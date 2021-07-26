variable "unique_id" {}
variable "rg_id" {}
variable "cos_id" {}

##############################################################################
# Cluster Variables
##############################################################################
variable "machine_type" {
  description = "Machine type for the ROKS Cluster"
  default     = "bx2.4x16"
}

variable "worker_count" {
  description = "Number of workers per zone"
  default     = "1"
}

variable "kube_version" {
  description = "Version of the ROKS Cluster"
  default     = "4.6.34_openshift"
}
##############################################################################

##############################################################################
# Networking variables
##############################################################################
variable cidr_blocks {
    description = "List of CIDR blocks for subnets" 
    default     = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"] 
}
##############################################################################
