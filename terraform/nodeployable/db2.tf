resource "ibm_resource_instance" "db2_instance" {
  name              = "${var.unique_id}-db2"
  service           = "dashdb-for-transactions"
  plan              = var.db2_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id

  timeouts {
    create = "30m"
    update = "15m"
    delete = "15m"
  }
}

resource "ibm_resource_key" "db2_key" {
  name                 = "${ibm_resource_instance.db2_instance.name}-key"
  role                 = var.db2_key_role
  resource_instance_id = ibm_resource_instance.db2_instance.id
}

# Pass credentials to K8S
######################################################
 resource "ibm_container_bind_service" "db2_service_binding" {
     depends_on = [kubernetes_namespace.prod]
     #   count = length(var.environments)
     cluster_name_id       = module.roks_classic.cluster_id
     service_instance_name = ibm_resource_instance.db2_instance.name
     namespace_id          = var.unique_id
     resource_group_id     = ibm_resource_group.resource_group.id
     key                   = ibm_resource_key.db2_key.name
}
######################################################
