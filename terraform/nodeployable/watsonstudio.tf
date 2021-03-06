resource "ibm_resource_instance" "w_studio_instance" {
  name              = "${var.unique_id}-w-studio"
  service           = "data-science-experience"
  plan              = var.w_studio_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
