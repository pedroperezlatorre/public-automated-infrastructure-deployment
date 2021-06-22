resource "ibm_resource_group" "resource_group" {
  count = var.resource_groups_count

  name = var.resource_groups_names[count.index]
}
