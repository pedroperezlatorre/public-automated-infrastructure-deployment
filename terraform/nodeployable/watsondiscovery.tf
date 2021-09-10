resource "ibm_resource_instance" "w_discovery_instance" {
  name              = "${var.unique_id}-w-discovery"
  service           = "discovery"
  plan              = var.w_discovery_plan
  location          = var.ibm_region
  # location          = "eu-gb"  --> check lite plan region availability 
  resource_group_id = ibm_resource_group.resource_group.id
}



##############################################################################
# Service Credentials
##############################################################################

resource "ibm_resource_key" "w_discovery_key" {
  name                 = "${ibm_resource_instance.w_discovery_instance.name}-key"
  role                 = var.w_discovery_role
  resource_instance_id = ibm_resource_instance.w_discovery_instance.id
}

resource "ibm_container_bind_service" "w_discovery_service_binding" {
  cluster_name_id       = module.roks_classic.cluster_id
  service_instance_name = ibm_resource_instance.w_discovery_instance.name
  namespace_id          = var.unique_id
  resource_group_id     = ibm_resource_group.resource_group.id
  key                   = ibm_resource_key.w_discovery_key.name
}
##############################################################################
