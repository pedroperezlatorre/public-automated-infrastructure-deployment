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
resource "kubernetes_secret" "registry_credentials" {
  metadata {
    name = "registry_credentials"
  }

  data = {
    host        = data.local_file.registry_url.content
    # port      = ibm_resource_key.db2_key.credentials["connection.db2.hosts.0.port"]
    # dbname    = ibm_resource_key.db2_key.credentials["connection.db2.database"]
    # username  = ibm_resource_key.db2_key.credentials["connection.db2.authentication.username"]
    # password  = ibm_resource_key.db2_key.credentials["connection.db2.authentication.password"]
    # method    = ibm_resource_key.db2_key.credentials["connection.db2.authentication.method"]
  }
  type = "kubernetes.io/basic-auth"
}
######################################################
