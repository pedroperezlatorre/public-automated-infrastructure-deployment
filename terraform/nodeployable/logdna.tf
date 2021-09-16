resource "ibm_resource_instance" "logdna" {
  depends_on = [ibm_resource_group.resource_group]

   name              = "${var.unique_id}-logdna"
   service           = "logdna"
   plan              = var.logdna_plan
   location          = var.ibm_region
   resource_group_id = ibm_resource_group.resource_group.id
  
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
 }

#  resource "ibm_resource_key" "logdna_key" {
#    name                 = "${ibm_resource_instance.logdna.name}-key"
#    role                 = var.logdna_key_role
#    resource_instance_id = ibm_resource_instance.logdna.id
#  }

# # Pass credentials to K8S
# ######################################################
#  resource "ibm_container_bind_service" "logdna_service_binding" {
#      depends_on = [kubernetes_namespace.prod]
#      #   count = length(var.environments)
#      cluster_name_id       = module.k8s_service.cluster_id
#      service_instance_name = ibm_resource_instance.logdna.name
#      namespace_id          = var.unique_id
#      resource_group_id     = ibm_resource_group.resource_group.id
#      key                   = ibm_resource_key.logdna_key.name
# }
# ######################################################
