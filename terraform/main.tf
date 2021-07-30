module "roks" {
  source        = "./roks"
  unique_id     = var.unique_id
  rg_id         = ibm_resource_group.resource_group.id
  ibm_region    = var.ibm_region
  cos_plan      = "standard"
  machine_type  = "bx2.4x16"
  worker_count  = "1"
  kube_version  = "4.6.38_openshift"
  cidr_blocks   = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
  # Additional WorkerPool
  pool1_size    = 0  # Number of nodes per zone (0: Don't deploy pool)
  pool1_type    = "bx2.16x64"
}

# Access to K8S cluster
###############################################################################################
data "ibm_container_cluster_config" "cluster" {
  cluster_name_id = module.roks.cluster_id
  admin           = true
}

provider "kubernetes" {
  host                   = data.ibm_container_cluster_config.cluster.host
  client_certificate     = data.ibm_container_cluster_config.cluster.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster.ca_certificate
}
###############################################################################################


# module "cos" {
#   source    = "./cos"
#   unique_id = var.unique_id
#   cos_plan  = var.cos_plan
#   rg_id     = ibm_resource_group.resource_group.id
# }

# module "cloudant" {
#   source            = "./cloudant"
#   unique_id         = var.unique_id
#   cloudant_plan     = var.cloudant_plan
#   ibm_region        = var.ibm_region
#   cloudant_key_role = var.cloudant_key_role
#   rg_id             = ibm_resource_group.resource_group.id
#   k8s_present       = var.k8s_present != null ? true : false
# }

# module "db2" {
#   source            = "./db2"
#   unique_id         = var.unique_id
#   cloudant_plan     = var.db2_plan
#   ibm_region        = var.ibm_region
#   cloudant_key_role = var.db2_key_role
# }