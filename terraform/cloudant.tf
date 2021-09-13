resource "ibm_resource_instance" "cloudant_instance" {
  name              = "${var.unique_id}-cloudant"
  service           = "cloudantnosqldb"
  plan              = var.cloudant_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
  
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_resource_key" "cloudant_key" {
  name                 = "${ibm_resource_instance.cloudant_instance.name}-key"
  role                 = var.cloudant_key_role
  resource_instance_id = ibm_resource_instance.cloudant_instance.id
}

# Pass credentials to K8S
######################################################
 resource "ibm_container_bind_service" "appid_service_binding" {
     depends_on = [kubernetes_namespace.prod]
     #   count = length(var.environments)
     cluster_name_id       = module.roks_classic.cluster_id
     service_instance_name = ibm_resource_instance.cloudant_instance.name
     namespace_id          = var.unique_id
     resource_group_id     = ibm_resource_group.resource_group.id
     key                   = ibm_resource_key.cloudant_key.name
}
######################################################
