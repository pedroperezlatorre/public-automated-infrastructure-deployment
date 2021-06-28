resource "ibm_resource_instance" "db2_instance" {
  name              = "${var.unique_id}-db2"
  service           = "dashdb-for-transactions"
  plan              = var.db2_plan
  location          = var.ibm_region
  resource_group_id = ibm_resource_group.resource_group.id
}

resource "ibm_resource_key" "db2_key" {
  name                 = "${ibm_resource_instance.db2_instance.name}-key"
  role                 = var.db2_key_role
  resource_instance_id = ibm_resource_instance.db2_instance.id
}
