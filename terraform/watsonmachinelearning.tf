resource "ibm_resource_instance" "wml_instance" {
  name              = "${var.unique_id}-wml"
  service           = "pm-20"
  plan              = var.wml_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
