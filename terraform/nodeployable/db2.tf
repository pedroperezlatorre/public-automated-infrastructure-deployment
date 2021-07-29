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

# Pass Cloudant credentials to K8S
######################################################
resource "kubernetes_secret" "db2_credentials" {
  metadata {
    name = "db2-credentials"
  }

  data = {
    host      = ibm_resource_key.db2_key.credentials["connection.db2.hosts.0.hostname"]
    port      = ibm_resource_key.db2_key.credentials["connection.db2.hosts.0.port"]
    dbname    = ibm_resource_key.db2_key.credentials["connection.db2.database"]
    username  = ibm_resource_key.db2_key.credentials["connection.db2.authentication.username"]
    password  = ibm_resource_key.db2_key.credentials["connection.db2.authentication.password"]
    method    = ibm_resource_key.db2_key.credentials["connection.db2.authentication.method"]
  }

  type = "kubernetes.io/basic-auth"
}
######################################################
