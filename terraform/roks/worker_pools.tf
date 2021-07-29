# resource "ibm_container_worker_pool" "workerpool" {
#   worker_pool_name = "worker-pool-1"
#   machine_type     = var.pool1_type
#   cluster          = ibm_container_vpc_cluster.cluster.name
#   size_per_zone    = var.pool1_size
#   hardware         = "shared"
#   disk_encryption  = "false"
# #   region           = var.ibm_region

# #   labels = {
# #     "test" = "test-pool"
# #   }

#   //User can increase timeouts 
#   timeouts {
#     update = "180m"
#   }
# }

resource "ibm_container_vpc_worker_pool" "workerpool" {
  cluster          = ibm_container_vpc_cluster.cluster.name
  worker_pool_name = "worker-pool-1"
  flavor           = var.pool1_type
  vpc_id           = ibm_is_vpc.vpc.id
  worker_count     = var.pool1_size
  
# Zone 1
  zones {
    subnet_id = ibm_is_subnet.subnet.0.id
    name      = "${var.ibm_region}-1"
  }

# Zone 2
  zones {
    subnet_id = ibm_is_subnet.subnet.1.id
    name      = "${var.ibm_region}-2"
  }

# Zone 3
  zones {
    subnet_id = ibm_is_subnet.subnet.2.id
    name      = "${var.ibm_region}-3"
  }
}