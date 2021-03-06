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
#      cluster_name_id       = module.k8s_service.cluster_id
#      service_instance_name = ibm_resource_instance.registry.name
#      namespace_id          = var.unique_id
#      resource_group_id     = ibm_resource_group.resource_group.id
#      key                   = ibm_resource_key.registry_key.name
# }
# ######################################################

resource "null_resource" "registry" {
  provisioner "local-exec" {
    command = "ibmcloud login --apikey $IBMCLOUD_API_KEY -a \"https://cloud.ibm.com\" -r $REGION && (echo \"y\" | ibmcloud cr plan-upgrade standard) && ibmcloud target -g $RESOURCE_GROUP && ibmcloud cr namespace-add -g $RESOURCE_GROUP $NAMESPACE_NAME && ibmcloud cr region | grep -E -o \"[^']*\\.icr\\.[^']*\" > /tmp/registryURL"
    interpreter = ["/bin/sh", "-c"]
    environment = {
      IBMCLOUD_API_KEY  = var.ibmcloud_api_key
      REGION            = var.ibm_region
      RESOURCE_GROUP    = var.resource_groups_name
      NAMESPACE_NAME    = "${var.unique_id}-crn"
    }
  }
  
    triggers = {
      always_run = "${timestamp()}"
    }
}

data "local_file" "registry_url" {
    depends_on = [null_resource.registry]

    filename = "/tmp/registryURL"
}

# Pass credentials to K8S
######################################################
# Usage: https://cloud.ibm.com/apidocs/container-registry
# Login: $ docker login -u iamapikey -p <apikey> <registry_url>

resource "kubernetes_secret" "registry_credentials" {

  depends_on = [kubernetes_namespace.prod]
  metadata {
    name      = "registry-credentials"
    namespace = var.unique_id
  }

  data = {
    publicHost  = trimspace(data.local_file.registry_url.content)
    privateHost = "private.${trimspace(data.local_file.registry_url.content)}"
    publicEndpoint    = "https://${trimspace(data.local_file.registry_url.content)}/${var.unique_id}-crn"
    privateEndpoint    = "https://private.${trimspace(data.local_file.registry_url.content)}/${var.unique_id}-crn"
    apikey      = var.ibmcloud_api_key
    # port      = ibm_resource_key.db2_key.credentials["connection.db2.hosts.0.port"]
    # dbname    = ibm_resource_key.db2_key.credentials["connection.db2.database"]
    username  = ""
    password  = ""
    # method    = ibm_resource_key.db2_key.credentials["connection.db2.authentication.method"]
  }
  type = "kubernetes.io/basic-auth"
}
######################################################
