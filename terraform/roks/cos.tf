##############################################################################
# Create COS instance 
##############################################################################

resource ibm_resource_instance cos {
  name              = "${var.unique_id}-roks-cos"
  service           = "cloud-object-storage"
  plan              = var.cos_plan
  location          = "global"
  resource_group_id = var.rg_id
  tags              = ["roks-on-vpc"]

  //User can increase timeouts 
  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

##############################################################################


# ##############################################################################
# # Policy for KMS
# ##############################################################################

# resource ibm_iam_authorization_policy cos_policy {
#   source_service_name         = "cloud-object-storage"
#   source_resource_instance_id = "${ibm_resource_instance.cos.id}"
#   target_service_name         = "kms"
#   target_resource_instance_id = "${data.ibm_schematics_output.key_workspace.output_values.kms_id}"
#   roles                       = ["Reader"]
# }

# ##############################################################################