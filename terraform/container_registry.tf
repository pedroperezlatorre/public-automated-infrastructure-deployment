# resource "ibm_resource_instance" "registry" {
#   depends_on = [ibm_resource_group.resource_group]

#    name              = "${var.unique_id}-registry"
#    service           = "container-registry"
#    plan              = var.registry_plan
#    location          = var.ibm_region
#    resource_group_id = ibm_resource_group.resource_group.id
  
#   timeouts {
#     create = "15m"
#     update = "15m"
#     delete = "15m"
#   }
#  }

#  resource "ibm_resource_key" "registry_key" {
#    name                 = "${ibm_resource_instance.registry.name}-key"
#    role                 = var.registry_key_role
#    resource_instance_id = ibm_resource_instance.registry.id
#  }

# # Pass credentials to K8S
# ######################################################
#  resource "ibm_container_bind_service" "registry_service_binding" {
#      depends_on = [kubernetes_namespace.prod]
#      #   count = length(var.environments)
#      cluster_name_id       = module.roks_classic.cluster_id
#      service_instance_name = ibm_resource_instance.registry.name
#      namespace_id          = var.unique_id
#      resource_group_id     = ibm_resource_group.resource_group.id
#      key                   = ibm_resource_key.registry_key.name
# }
# ######################################################

resource "null_resource" "registry" {
  provisioner "local-exec" {
    command = "ibmcloud login --apikey $IBMCLOUD_API_KEY -a \"https://cloud.ibm.com\" -r $REGION && (echo \"y\" | ibmcloud cr plan-upgrade standard)"
    environment = {
      IBMCLOUD_API_KEY = var.ibmcloud_api_key
      REGION           = var.region
    }
  }
}