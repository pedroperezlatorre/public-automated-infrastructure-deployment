resource "ibm_resource_instance" "speechtotext_instance" {
  name              = "${var.unique_id}-speechtotext"
  service           = "speech-to-text"
  plan              = var.speechtotext_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
