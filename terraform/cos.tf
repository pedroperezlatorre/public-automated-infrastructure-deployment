##############################################################################
# Create COS instance 
##############################################################################

resource ibm_resource_instance cos {
  name              = "${var.unique_id}-cos"
  service           = "cloud-object-storage"
  plan              = var.cos_plan
  location          = "global"
  resource_group_id = ibm_resource_group.resource_group.id
  tags              = ["iks-on-vpc"]

  #parameters = {
  #  service-endpoints = "${var.end_points}"
  #  key_protect_key   = "${data.ibm_schematics_output.key_workspace.output_values.kms_key_id}"
  #}

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