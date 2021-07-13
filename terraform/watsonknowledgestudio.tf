resource "ibm_resource_instance" "w_knowledgestudio_instance" {
  name              = "${var.unique_id}-w-knowledgestudio"
  service           = "knowledge-studio"
  plan              = var.w_knowledgestudio_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
