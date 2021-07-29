resource "ibm_container_worker_pool" "workerpool" {
  worker_pool_name = "worker-pool-1"
  machine_type     = var.pool1_type
  cluster          = ibm_container_vpc_cluster.cluster.name
  size_per_zone    = var.pool1_size
  hardware         = "shared"
  disk_encryption  = "false"
  region           = var.ibm_region

#   labels = {
#     "test" = "test-pool"
#   }

  //User can increase timeouts 
  timeouts {
    update = "180m"
  }
}