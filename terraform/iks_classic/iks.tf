##############################################################################
# Provison IKS Classic Cluster
##############################################################################

# resource "ibm_container_vpc_cluster" "cluster" {
#  name              = "${var.unique_id}-iks-vpc"
#  vpc_id            = ibm_is_vpc.vpc.id
#  flavor            = var.machine_type
#  worker_count      = var.worker_count
#  resource_group_id = var.rg_id
#  kube_version      = var.kube_version
 
# # Zone 1
#   zones {
#     subnet_id = ibm_is_subnet.subnet.0.id
#     name      = "${var.ibm_region}-1"
#   }

# # Zone 2
#   zones {
#     subnet_id = ibm_is_subnet.subnet.1.id
#     name      = "${var.ibm_region}-2"
#   }

# # Zone 3
#   zones {
#     subnet_id = ibm_is_subnet.subnet.2.id
#     name      = "${var.ibm_region}-3"
#   }
# }

resource "ibm_container_cluster" "cluster" {
  name               = "${var.unique_id}-iks-classic"
  datacenter         = var.cluster_datacenter
  resource_group_id  = var.rg_id
  machine_type       = var.machine_type
  hardware           = var.cluster_hardware
  kube_version       = var.kube_version
  update_all_workers = true
  gateway_enabled    = false
  private_service_endpoint = true

  default_pool_size = var.default_pool_size

  private_vlan_id = var.cluster_private_vlan
  public_vlan_id  = var.cluster_public_vlan
}

