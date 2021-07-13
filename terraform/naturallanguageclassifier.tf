resource "ibm_resource_instance" "natural_language_classifier_instance" {
  name              = "${var.unique_id}-natural_language_classifier"
  service           = "natural_language_classifier"
  plan              = var.natural_language_classifier_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
