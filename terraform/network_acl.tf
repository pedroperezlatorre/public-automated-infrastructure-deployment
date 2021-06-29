#*****************************************************************************
# IBM Terraform Provider Documentation Block References
#   Netowork ACLs: https://cloud.ibm.com/docs/terraform?topic=terraform-vpc-gen2-resources&-access-data-sources#network-acl
#*****************************************************************************

##############################################################################
# Create an ACL for ingress/egress used by  all subnets in VPC
##############################################################################

resource ibm_is_network_acl network_acl {
  name = "${var.unique_id}-acl"
  vpc  = ibm_is_vpc.vpc.id
  rules {
      name   = "egress"
      action = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "outbound"
  }
  rules {
      name   = "ingress"
      action = "allow"
      source      = "0.0.0.0/0"
      destination = "0.0.0.0/0"
      direction   = "inbound"
  }
}

##############################################################################
