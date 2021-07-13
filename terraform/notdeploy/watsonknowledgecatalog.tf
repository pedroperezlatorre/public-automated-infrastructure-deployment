resource "ibm_resource_instance" "w_knowledgecatalog_instance" {
  name              = "${var.unique_id}-w-knowledgecatalog"
  service           = "datacatalog"
  plan              = var.w_knowledgecatalog_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
