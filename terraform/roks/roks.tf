###################################################################################################
# Creates the IKS Cluster
#
# Requires:
#   See provider.tf
#       variables.tf
#
# Creates: 
#   Creates an IKS cluster (ibm_container_vpc_cluster.cluster) and 
#    
# Outputs: 
#  see outputs.tf
#
# References:
#   IKS/VPC: https://cloud.ibm.com/docs/terraform?topic=terraform-container-resources&-access-data-sources#vpc-cluster
##################################################################################################

##############################################################################
# Provison IKS on VPC Cluster
##############################################################################

resource "ibm_container_vpc_cluster" "cluster" {
 name              = "${var.unique_id}-roks"
 vpc_id            = ibm_is_vpc.vpc.id
 flavor            = var.machine_type
 worker_count      = var.worker_count
 resource_group_id = var.rg_id
 kube_version      = var.kube_version
 
 # OpenShift (OCP)
 entitlement       = "cloud_pak"
 cos_instance_crn  = ibm_resource_instance.cos.id

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
