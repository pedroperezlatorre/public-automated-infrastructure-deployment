variable "unique_id" {}
variable "rg_id" {}
variable "ibm_region" {}

##############################################################################
# Cluster Variables
##############################################################################
variable "machine_type" {
  description = "Machine type for the IKS Cluster"
  default     = "bx2.4x16"
}

variable "default_pool_size" {
  description = "Number of workers per zone"
  default     = "1"
}

variable "worker_num" {
  description = "Number of workers per zone"
  default     = "0"
}

variable "kube_version" {
  description = "Version of the IKS Cluster"
  default     = "1.20.9"
}

variable "cluster_datacenter" {
  default     = "fra02"
  description = "The datacenter where the cluster will be deployed"
  type        = string
}

variable "cluster_hardware" {
  default     = "shared"
  description = "dedicated or shared"
  type        = string
}

variable "pool1_type" {
  description = "machine_type for Worker Pool 1"
  default     = "bx2.4x16"
}

variable "pool1_size" {
  description = "size_per_zone for Worker Pool 1"
  default     = 0
}
##############################################################################

##############################################################################
# Networking variables
##############################################################################
variable cidr_blocks {
    description = "List of CIDR blocks for subnets" 
    default     = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"] 
}

variable "cluster_private_vlan" {
  description = "the private vlan id"
  type        = string
}

variable "cluster_public_vlan" {
  description = "the public vlan id"
  type        = string
}

variable "pod_subnet" {
  default     = "172.30.0.0/16"
  description = "Subnet for K8s Pods"
  type        = string
}

variable "service_subnet" {
  default     = "172.21.0.0/16"
  description = "Subnet for K8s SVCs"
  type        = string
}
##############################################################################
