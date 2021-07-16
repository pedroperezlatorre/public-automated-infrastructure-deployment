module "cloudant" {
  source            = "./cloudant"
  unique_id         = var.unique_id
  cloudant_plan     = var.cloudant_plan
  ibm_region        = var.ibm_region
  cloudant_key_role = var.cloudant_key_role
}