##############################################################################
# IBM Cloud Provider. Use this block to set the IBM Cloud as a provider
# Documentation Block References
# https://cloud.ibm.com/docs/terraform?topic=terraform-provider-reference&-access-data-sources
##############################################################################

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "~> 1.26.0"
    }
  }
}

provider "ibm" {
  region             = var.ibm_region
  #generation         = 2
  ibmcloud_timeout   = 60
  ibmcloud_api_key   = var.ibmcloud_api_key
}
