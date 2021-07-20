resource "ibm_resource_instance" "texttospeech_instance" {
  name              = "${var.unique_id}-texttospeech"
  service           = "text-to-speech"
  plan              = var.texttospeech_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}
