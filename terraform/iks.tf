###################################################################################################
# Creates the IKS Cluster
#
# Depends on:
#    schematics.tf - provides the output data from the 01-groups and 02-vpc Schematics workspaces
#
# Requires:
#   See provider.tf
#       variables.tf
#
# Creates: 
#   Creates an IKS cluster (ibm_container_vpc_cluster.cluster) and 
#   Container Registry ( ibm_resource_instance.docker_registry) in the VPC Cluster
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
 name              = "${var.unique_id}-iks"
 vpc_id            = ibm_is_vpc.vpc.id
 flavor            = var.machine_type
 worker_count      = var.worker_count
 resource_group_id = ibm_resource_group.resource_group.id
 #kube_version      = "1.20.7"
 
 # OpenShift (OCP)
 kube_version      = var.kube_version
 entitlement       = "cloud_pak"
 cos_instance_crn  = ibm_resource_instance.cos.id

 zones {
#  subnet_id = element(data.ibm_schematics_output.vpc_workspace.output_values.subnet_ids, 0)
   subnet_id = ibm_is_subnet.subnet.0.id
   name      = "${var.ibm_region}-1"
 }
 zones {
#   subnet_id = element(data.ibm_schematics_output.vpc_workspace.output_values.subnet_ids, 1)
   subnet_id = ibm_is_subnet.subnet.1.id
   name      = "${var.ibm_region}-2"
 }
#   zones {
# #   subnet_id = element(data.ibm_schematics_output.vpc_workspace.output_values.subnet_ids, 2)
#     subnet_id = ibm_is_subnet.subnet.2.id
#     name      = "${var.ibm_region}-3"
#   }
}