resource "ibm_resource_instance" "appid" {
  depends_on = [ibm_resource_group.resource_group]

   name              = "${var.unique_id}-appid"
   service           = "appid"
   plan              = var.appid_plan
   location          = var.ibm_region
   resource_group_id = ibm_resource_group.resource_group.id
  
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
 }

 resource "ibm_resource_key" "appid_key" {
   name                 = "${ibm_resource_instance.appid.name}-key"
   role                 = va.appid_key_role
   resource_instance_id = ibm_resource_instance.appid.id
 }

# Pass credentials to K8S
######################################################
 resource "ibm_container_bind_service" "appid_service_binding" {
     depends_on = [ibm_container_cluster.openshift_cluster, ibm_resource_key.appid_key]
     #   count = length(var.environments)
     cluster_name_id       = module.roks_classic.cluster_id
     service_instance_name = ibm_resource_instance.appid.name
     namespace_id          = var.unique_id
     resource_group_id     = ibm_resource_group.resource_group.id
     key                   = ibm_resource_key.appid_key.name
}
######################################################
