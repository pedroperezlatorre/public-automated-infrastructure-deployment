resource "ibm_resource_instance" "cloudant_instance" {
  name              = "${var.unique_id}-cloudant"
  service           = "cloudantnosqldb"
  plan              = var.cloudant_plan
  location          = var.ibm_region
  resource_group_id = var.rg_id
  
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

# Pass Cloudant credentials to K8S
######################################################
resource "kubernetes_secret" "cloudant_credentials" {
  metadata {
    name = "cloudant-credentials"
  }

  data = {
    host      = ibm_resource_key.cloudant_key.credentials.host
    port      = ibm_resource_key.cloudant_key.credentials.port
    url       = ibm_resource_key.cloudant_key.credentials.url
    username  = ibm_resource_key.cloudant_key.credentials.username
    password  = ibm_resource_key.cloudant_key.credentials.password

  }

  type = "kubernetes.io/basic-auth"
}
######################################################
