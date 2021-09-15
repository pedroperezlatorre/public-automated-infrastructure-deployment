resource "ibm_resource_instance" "language_translator_instance" {
  name              = "${var.unique_id}-language-translator"
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
     depends_on = [kubernetes_namespace.prod]
  cluster_name_id       = module.k8s_service.cluster_id
  service_instance_name = ibm_resource_instance.language_translator_instance.name
  namespace_id          = var.unique_id
  resource_group_id     = ibm_resource_group.resource_group.id
  key                   = ibm_resource_key.language_translator_key.name
}
##############################################################################
