resource "ibm_container_worker_pool_zone_attachment" "workerpool1_zone_attach" {
  count = var.worker_num > 0 ? 1 : 0

  cluster         = ibm_container_cluster.cluster.id
  private_vlan_id = var.cluster_private_vlan
  public_vlan_id  = var.cluster_public_vlan
  worker_pool     = ibm_container_worker_pool.workerpool1[0].id
  zone            = var.cluster_datacenter
}