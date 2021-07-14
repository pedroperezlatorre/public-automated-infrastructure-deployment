resource "ibm_resource_instance" "openscale_instance" {
  name              = "${var.unique_id}-openscale"
  service           = "aiopenscale"
  plan              = var.openscale_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}