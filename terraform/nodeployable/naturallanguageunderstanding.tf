resource "ibm_resource_instance" "natural_language_understanding_instance" {
  name              = "${var.unique_id}-natural-language-understanding"
  service           = "natural-language-understanding"
  plan              = var.natural_language_understanding_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}


##############################################################################
# Service Credentials
##############################################################################

resource "ibm_resource_key" "natural_language_understanding_key" {
  name                 = "${ibm_resource_instance.natural_language_understanding_instance.name}-key"
  role                 = var.natural_language_understanding_role
  resource_instance_id = ibm_resource_instance.natural_language_understanding_instance.id
}

resource "ibm_container_bind_service" "natural_language_understanding_service_binding" {
  cluster_name_id       = module.k8s_service.cluster_id
  service_instance_name = ibm_resource_instance.natural_language_understanding_instance.name
  namespace_id          = var.unique_id
  resource_group_id     = ibm_resource_group.resource_group.id
  key                   = ibm_resource_key.natural_language_understanding_key.name
}
##############################################################################
