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
