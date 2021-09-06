resource "ibm_container_worker_pool_zone_attachment" "workerpool1_zone_attach" {
  count = var.wp_deploy ? 1 : 0

  cluster         = ibm_container_cluster.cluster.id
  private_vlan_id = var.cluster_private_vlan
  public_vlan_id  = var.cluster_public_vlan
  worker_pool     = element(split("/", ibm_container_worker_pool.workerpool1[0].id), 1)
  zone            = var.cluster_datacenter

  timeouts {
    create = "90m"
    update = "3h"
    delete = "30m"
  }
}

resource "ibm_container_alb" "disable_public_alb2" {
  count = var.wp_deploy ? 1 : 0

  depends_on = [
    ibm_container_cluster.cluster,
    ibm_container_worker_pool_zone_attachment.zone
  ]

  alb_id = [
    for alb in ibm_container_cluster.cluster.albs:
      alb.id if alb.alb_type == "public" && length(regexall("alb2", alb.id)) > 0
  ][0]
  disable_deployment = true
}