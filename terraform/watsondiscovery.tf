resource "ibm_resource_instance" "w_discovery_instance" {
  name              = "${var.unique_id}-w-discovery"
  service           = "discovery"
  plan              = var.w_discovery_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}