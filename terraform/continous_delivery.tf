data "ibm_resource_group" "cd_resource_group" {
  depends_on = [
    ibm_resource_group.resource_group,
  ]
  name = var.pipelines_resource_group_name
}

resource "ibm_resource_instance" "resource_group_resource_instance" {

  name              = "${var.pipelines_resource_group_name}-continuous-delivery"
  service           = "continuous-delivery"
  plan              = var.resource_group_cd_plan
  location          = var.ibm_region
  resource_group_id = data.ibm_resource_group.cd_resource_group.id
  tags              = ["schematics"]
}

resource "ibm_resource_instance" "default_resource_instance" {
  name     = "continuous-delivery"
  service  = "continuous-delivery"
  plan     = var.default_cd_plan
  location = var.ibm_region
  tags     = ["schematics"]
}
