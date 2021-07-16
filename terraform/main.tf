module "cloudant" {
  source            = "./cloudant"
  unique_id         = var.unique_id
  cloudant_plan     = var.cloudant_plan
  ibm_region        = var.ibm_region
  cloudant_key_role = var.cloudant_key_role
}

module "db2" {
  source            = "./db2"
  unique_id         = var.unique_id
  cloudant_plan     = var.db2_plan
  ibm_region        = var.ibm_region
  cloudant_key_role = var.db2_key_role
}