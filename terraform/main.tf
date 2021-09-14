# # ROKS-VPC Cluster
# ###############################################################################################
# module "k8s_service" {
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
#   cluster_name_id = module.k8s_service.cluster_id
#   admin           = true
# }
# ###############################################################################################



# # IKS-VPC Cluster
# ###############################################################################################
# module "k8s_service" {
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
#   cluster_name_id = module.k8s_service.cluster_id
#   admin           = true
# }
# ###############################################################################################


# K8S-Classic Cluster
###############################################################################################
module "k8s_service" {
  source                  = "./roks_classic"
  unique_id               = var.unique_id
  rg_id                   = ibm_resource_group.resource_group.id
  cluster_datacenter      = var.k8s_classic_location # "dal10"
  cluster_private_vlan    = "3136364"
  cluster_public_vlan     = "3136362"
  pod_subnet              = "172.30.0.0/16"
  service_subnet          = "172.21.0.0/16"
  # worker_num              = 0   # must be greater than 0

  # ROKS or IKS
  kube_version            = "1.20.10" # ROKS or IKS - Command: $ ibmcloud ks versions

  # Default Worker Pool
  machine_type            = "b3c.4x16"  # "b3c.16x64"
  cluster_hardware        = "shared"
  default_pool_size       = 1
  entitlement             = "" # "" or "cloud_pak" : Cloud Pak License: set only when you create the WorkerPool
  disk_encryption          = "true"


  # Additional Worker Pool
  wp_deploy               = false
  wp_worker_pool_name     = "workerpool1"
  wp_size_per_zone        = 1
  wp_machine_type         = "b3c.4x16"
  wp_hardware             = "shared"
  wp_disk_encryption      = "true"
  wp_entitlement          = "cloud_pak" # "" or "cloud_pak" : Cloud Pak License: set only when you create the WorkerPool

}
###############################################################################################


# Generic K8S Cluster credentials
###############################################################################################
provider "kubernetes" {
  host                   = data.ibm_container_cluster_config.cluster.host
  client_certificate     = data.ibm_container_cluster_config.cluster.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster.ca_certificate
}

resource "kubernetes_namespace" "prod" {
  metadata {
    name = var.unique_id
  }
}

data "ibm_container_cluster_config" "cluster" {
  cluster_name_id = module.k8s_service.cluster_id
  admin           = true
}
###############################################################################################


# # CLASSIC INFRA VALUES
# # GERMANY
#   ibm_region              = "eu-de"
#   cluster_datacenter      = "fra02"
#   cluster_private_vlan    = "3132960"
#   cluster_public_vlan     = "3132962"
#
# # US-SOUTH (Dallas)
#   ibm_region              = "us-south"
#   cluster_datacenter      = "dal10"
#   cluster_private_vlan    = "3136364"
#   cluster_public_vlan     = "3136362"

# Pedro
#   cluster_private_vlan    = "3133366"
#   cluster_public_vlan     = "3133364"