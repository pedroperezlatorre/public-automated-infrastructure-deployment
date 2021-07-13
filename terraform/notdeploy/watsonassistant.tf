resource "ibm_resource_instance" "w_assistant_instance" {
  name              = "${var.unique_id}-w-assistant"
  service           = "conversation"
  plan              = var.w_assistant_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
