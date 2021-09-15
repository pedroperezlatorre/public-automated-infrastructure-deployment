resource "ibm_resource_instance" "w_assistant_instance" {
  name              = "${var.unique_id}-w-assistant"
  service           = "conversation"
  plan              = var.w_assistant_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}



##############################################################################
# Service Credentials
##############################################################################

resource "ibm_resource_key" "w_assistant_key" {
  name                 = "${ibm_resource_instance.w_assistant_instance.name}-key"
  role                 = var.w_assistant_role
  resource_instance_id = ibm_resource_instance.w_assistant_instance.id
}

resource "ibm_container_bind_service" "w_assistant_service_binding" {
  depends_on            = [kubernetes_namespace.prod]
  cluster_name_id       = module.k8s_service.cluster_id
  service_instance_name = ibm_resource_instance.w_assistant_instance.name
  namespace_id          = var.unique_id
  resource_group_id     = ibm_resource_group.resource_group.id
  key                   = ibm_resource_key.w_assistant_key.name
}
##############################################################################
