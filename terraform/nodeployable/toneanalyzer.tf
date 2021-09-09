resource "ibm_resource_instance" "toneanalyzer_instance" {
  name              = "${var.unique_id}-toneanalyzer"
  service           = "tone-analyzer"
  plan              = var.toneanalyzer_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}


##############################################################################
# Service Credentials
##############################################################################

resource "ibm_resource_key" "toneanalyzer_key" {
  name                 = "${ibm_resource_instance.toneanalyzer_instance.name}-key"
  role                 = var.toneanalyzer_role
  resource_instance_id = ibm_resource_instance.toneanalyzer_instance.id
}

resource "ibm_container_bind_service" "toneanalyzer_service_binding" {
  cluster_name_id       = module.roks_classic.cluster_id
  service_instance_name = ibm_resource_instance.toneanalyzer_instance.name
  namespace_id          = var.unique_id
  resource_group_id     = ibm_resource_group.resource_group.id
  key                   = ibm_resource_key.toneanalyzer_key.name
}
##############################################################################
