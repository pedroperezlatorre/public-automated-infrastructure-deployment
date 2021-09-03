##############################################################################
# Provison ROKS Classic Cluster
##############################################################################

resource "ibm_container_cluster" "cluster" {
  name                     = "${var.unique_id}-roks-classic"
  resource_group_id        = var.rg_id

  # Region
  # region                   = var.ibm_region
  datacenter               = var.cluster_datacenter

  # Resources
  default_pool_size        = var.default_pool_size
  # worker_num               = var.worker_num   # must be greater than 0
  hardware                 = var.cluster_hardware
  machine_type             = var.machine_type
  disk_encryption          = var.disk_encryption

  # VLAN
  private_vlan_id          = var.cluster_private_vlan
  public_vlan_id           = var.cluster_public_vlan
  private_service_endpoint = "false"
  public_service_endpoint  = "true"

  # K8s items
  kube_version             = var.kube_version
  pod_subnet               = var.pod_subnet
  service_subnet           = var.service_subnet
  tags                     = ["test"]

  # Cloud Pak
  entitlement              = var.entitlement

  # workers_info {
  #   id      = "kube-c4jj6jtd043g7q56rt6g-ikstestusa-default-00000128"
  #   version = "1.20.9"
  # }
}

# resource "ibm_container_cluster" "tfer--mycluster-002D-dal10-002D-b3c-002E-4x16" {
#   datacenter               = "dal10"
#   default_pool_size        = "1"
#   disk_encryption          = "true"
#   hardware                 = "shared"
#   kube_version             = "4.6.42_openshift"
#   machine_type             = "b3c.4x16"
#   name                     = "mycluster-dal10-b3c.4x16"
#   pod_subnet               = "172.30.0.0/16"
#   private_service_endpoint = "false"
#   private_vlan_id          = "3133474"
#   public_service_endpoint  = "true"
#   public_vlan_id           = "3133472"
#   region                   = "us-south"
#   resource_group_id        = "6a0e6d1e3cce4f92a116d3f5e7d095bd"
#   service_subnet           = "172.21.0.0/16"
#   worker_num               = "0"

#   workers_info {
#     id      = "kube-c4k9kcod0qole64sju2g-myclusterda-default-0000018f"
#     version = "4.6.42"
#   }
# }