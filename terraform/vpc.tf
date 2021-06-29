########################################################################################
# 02-vpc  Creates the VPC network 
#
# Depends on:
#    schematics.tf - provides the output data from the 01-groups Schematics workspace
#
# Requires:
#   See provider.tf
#       variables.tf
#
# Creates: 
#   This file create a VPC (ibm_is_vpc.vpc) Zones, subnets (ibm_is_subnet.subnet) and 
#   public gateway (ibm_is_public_gateway.gateway) for the VPC.  In separate file sets up the 
#   load balancers, listeners, pools and members
#
#
# Outputs: 
#  see outputs.tf
#
# References:
#   IBM VPC: https://cloud.ibm.com/docs/terraform?topic=terraform-vpc-gen2-resources&-access-data-sources#provider-vps
########################################################################################


##############################################################################
# Create a VPC
##############################################################################

resource ibm_is_vpc vpc {
  name           = "${var.unique_id}-vpc"
  #resource_group = "${data.ibm_schematics_output.groups_output.output_values.resource_group_id}"
  resource_group = ibm_resource_group.resource_group.id
  tags           = ["iks-on-vpc"]
}

##############################################################################


##############################################################################
# Prefixes and subnets for zone 1
##############################################################################

resource ibm_is_vpc_address_prefix subnet_prefix {
  count = "3"

  name  = "${var.unique_id}-prefix-zone-${count.index + 1}"
  zone  = "${var.ibm_region}-${(count.index % 3) + 1}"
  vpc   = ibm_is_vpc.vpc.id
  cidr  = element(var.cidr_blocks, count.index)
}

##############################################################################


##############################################################################
# Adds the public gateway for the VPC
# To remove public gateways remove this block and comment out line 65
##############################################################################


resource ibm_is_public_gateway gateway {
  count = "3"

  name  = "${var.unique_id}-gateway-zone-${count.index+1}"
  vpc   = ibm_is_vpc.vpc.id
  zone  = "${var.ibm_region}-${count.index+1}"
}


##############################################################################


##############################################################################
# Create Subnets
##############################################################################

resource ibm_is_subnet subnet {
  count           = "3"

  name            = "${var.unique_id}-subnet-${count.index + 1}"
  vpc             = ibm_is_vpc.vpc.id
  zone            = "${var.ibm_region}-${count.index + 1}"
  #resource_group  = "${data.ibm_schematics_output.groups_output.output_values.resource_group_id}"
  resource_group  = ibm_resource_group.resource_group.id
  ipv4_cidr_block = element(ibm_is_vpc_address_prefix.subnet_prefix.*.cidr, count.index)
  public_gateway  = element(ibm_is_public_gateway.gateway.*.id, count.index)
  network_acl     = ibm_is_network_acl.network_acl.id
}

##############################################################################
