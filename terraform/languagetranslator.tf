resource "ibm_resource_instance" "language_translator_instance" {
  name              = "${var.unique_id}-language_translator"
  service           = "language-translator"
  plan              = var.language_translator_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
