resource "ibm_resource_instance" "speechtotext_instance" {
  name              = "${var.unique_id}-speechtotext"
  service           = "speech-to-text"
  plan              = var.speechtotext_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}


##############################################################################
# Service Credentials
##############################################################################

resource "ibm_resource_key" "speechtotext_key" {
  name                 = "${ibm_resource_instance.speechtotext_instance.name}-key"
  role                 = var.speechtotext_role
  resource_instance_id = ibm_resource_instance.speechtotext_instance.id
}

resource "ibm_container_bind_service" "speechtotext_service_binding" {
  cluster_name_id       = module.k8s_service.cluster_id
  service_instance_name = ibm_resource_instance.speechtotext_instance.name
  namespace_id          = var.unique_id
  resource_group_id     = ibm_resource_group.resource_group.id
  key                   = ibm_resource_key.speechtotext_key.name
}
##############################################################################
