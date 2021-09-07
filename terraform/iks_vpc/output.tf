output "cluster_id" {
  value       = ibm_container_vpc_cluster.cluster.id
  description = "ID of the IKS cluster"
}