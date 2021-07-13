resource "ibm_resource_instance" "natural_language_understanding_instance" {
  name              = "${var.unique_id}-natural_language_understanding"
  service           = "natural-language-understanding"
  plan              = var.natural_language_understanding_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
