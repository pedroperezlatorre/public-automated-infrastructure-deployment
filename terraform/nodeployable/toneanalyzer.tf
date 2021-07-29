resource "ibm_resource_instance" "toneanalyzer_instance" {
  name              = "${var.unique_id}-toneanalyzer"
  service           = "tone-analyzer"
  plan              = var.toneanalyzer_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}