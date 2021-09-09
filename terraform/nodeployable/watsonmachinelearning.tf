resource "ibm_resource_instance" "wml_instance" {
  name              = "${var.unique_id}-wml"
  service           = "pm-20"
  plan              = var.wml_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}


## TO BE REVIEWED ##

##############################################################################
# Service Credentials
##############################################################################

# resource "ibm_resource_key" "wml_key" {
#   name                 = "${ibm_resource_instance.wml_instance.name}-key"
#   role                 = var.wml_role
#   resource_instance_id = ibm_resource_instance.wml_instance.id
# }

# resource "ibm_container_bind_service" "wml_service_binding" {
#   cluster_name_id       = module.roks_classic.cluster_id
#   service_instance_name = ibm_resource_instance.wml_instance.name
#   namespace_id          = var.unique_id
#   resource_group_id     = ibm_resource_group.resource_group.id
#   key                   = ibm_resource_key.wml_key.name
# }
##############################################################################
