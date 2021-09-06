resource "ibm_resource_instance" "language_translator_instance" {
  name              = "${var.unique_id}-language_translator"
  service           = "language-translator"
  plan              = var.language_translator_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}


##############################################################################
# Service Credentials
##############################################################################

resource "ibm_resource_key" "language_translator_key" {
  name                 = "${ibm_resource_instance.language_translator_instance.name}-key"
  role                 = var.language_translator_role
  resource_instance_id = ibm_resource_instance.language_translator_instance.id
}

resource "ibm_container_bind_service" "language_translator_service_binding" {
  cluster_name_id       = ibm_container_cluster.name
  service_instance_name = ibm_resource_instance.language_translator_instance.name
  namespace_id          = var.unique_id
  resource_group_id     = var.resource_group_id
  key                   = ibm_resource_key.language_translator_key.name
}
##############################################################################
