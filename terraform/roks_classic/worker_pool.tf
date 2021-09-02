resource "ibm_container_worker_pool" "workerpool1" {
  count = var.wp_deploy ? 1 : 0

  worker_pool_name = var.wp_worker_pool_name
  cluster          = ibm_container_cluster.cluster.id
#   depends_on       = ["ibm_container_cluster.tfer--guilletest-002D-roks-002D-classic"]
  disk_encryption  = var.wp_disk_encryption
  hardware         = var.wp_hardware
  machine_type     = var.wp_machine_type
  size_per_zone    = var.wp_size_per_zone
}