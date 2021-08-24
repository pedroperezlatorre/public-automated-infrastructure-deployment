# Generic K8S Cluster credentials
###############################################################################################
provider "kubernetes" {
  host                   = data.ibm_container_cluster_config.cluster.host
  client_certificate     = data.ibm_container_cluster_config.cluster.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster.ca_certificate
}
###############################################################################################


# # ROKS-VPC Cluster
# ###############################################################################################
# module "roks" {
#   source        = "./roks"
#   unique_id     = var.unique_id
#   rg_id         = ibm_resource_group.resource_group.id
#   ibm_region    = var.ibm_region
#   cos_plan      = "standard"
#   machine_type  = "bx2.4x16"
#   worker_count  = "1"
#   kube_version  = "4.6.38_openshift"
#   cidr_blocks   = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
#   # Additional WorkerPool
#   pool1_size    = 0  # Number of nodes per zone (0: Don't deploy pool)
#   pool1_type    = "bx2.16x64"
# }

# data "ibm_container_cluster_config" "cluster" {
#   cluster_name_id = module.roks.cluster_id
#   admin           = true
# }
# ###############################################################################################



# # IKS-VPC Cluster
# ###############################################################################################
# module "iks_vpc" {
#   source        = "./iks_vpc"
#   unique_id     = var.unique_id
#   rg_id         = ibm_resource_group.resource_group.id
#   ibm_region    = var.ibm_region
#   machine_type  = "bx2.4x16"
#   worker_count  = "1"
#   kube_version  = "1.20.9"
#   cidr_blocks   = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
#   # Additional WorkerPool
#   pool1_size    = 0  # Number of nodes per zone (0: Don't deploy pool)
#   pool1_type    = "bx2.16x64"
# }

# data "ibm_container_cluster_config" "cluster" {
#   cluster_name_id = module.iks_vpc.cluster_id
#   admin           = true
# }
# ###############################################################################################




# IKS-Classic Cluster
###############################################################################################
module "iks_classic" {
  source        = "./iks_vpc"
  unique_id     = var.unique_id
  rg_id         = ibm_resource_group.resource_group.id
  cluster_datacenter = "fra02"
  machine_type  = "bx2.4x16"
  cluster_hardware  = "shared"
  default_pool_size  = "1"
  kube_version  = "1.20.9"
  cidr_blocks   = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
  # Additional WorkerPool
  pool1_size    = 0  # Number of nodes per zone (0: Don't deploy pool)
  pool1_type    = "bx2.16x64"
  cluster_private_vlan  = "3078462"
  cluster_public_vlan   = "3078460"
}

data "ibm_container_cluster_config" "cluster" {
  cluster_name_id = module.iks_classic.cluster_id
  admin           = true
}
###############################################################################################