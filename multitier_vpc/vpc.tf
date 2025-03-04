##############################################################################
# This file creates the VPC, Zones, subnets and public gateway for the VPC
# a separate file sets up the load balancers, listeners, pools and members
##############################################################################


##############################################################################
# Create a VPC
##############################################################################

resource ibm_is_vpc vpc {
  name           = "${var.unique_id}-vpc"
  resource_group = data.ibm_resource_group.resource_group.id
  classic_access = var.classic_access
}

##############################################################################


##############################################################################
# Public Gateways (Optional)
##############################################################################

resource ibm_is_public_gateway multi_tier_gateway {
  count = var.enable_public_gateway ? 3 : 0
  name  = "${var.unique_id}-gateway-${count.index + 1}"
  vpc   = ibm_is_vpc.vpc.id
  zone  = "${var.ibm_region}-${count.index + 1}"
}

##############################################################################


##############################################################################
# Tier 1
##############################################################################

module tier_1_subnets {
  source           = "./module_vpc_tier" 
  ibm_region       = var.ibm_region 
  unique_id        = "${var.unique_id}-tier-1"                      
  acl_id           = ibm_is_network_acl.multizone_acl.id
  cidr_blocks      = var.tier_1_cidr_blocks
  vpc_id           = ibm_is_vpc.vpc.id
  public_gateways  = ibm_is_public_gateway.multi_tier_gateway.*.id
}

##############################################################################


##############################################################################
# Tier 2
##############################################################################

module tier_2_subnets {
  source           = "./module_vpc_tier"
  ibm_region       = var.ibm_region
  unique_id        = "${var.unique_id}-tier-2"
  acl_id           = ibm_is_network_acl.multizone_acl.id
  cidr_blocks      = var.tier_2_cidr_blocks
  vpc_id           = ibm_is_vpc.vpc.id
  public_gateways  = ibm_is_public_gateway.multi_tier_gateway.*.id
}

##############################################################################


##############################################################################
# Tier 3
##############################################################################

module tier_3_subnets {
  source           = "./module_vpc_tier"
  ibm_region       = var.ibm_region
  unique_id        = "${var.unique_id}-tier-3"
  acl_id           = ibm_is_network_acl.multizone_acl.id
  cidr_blocks      = var.tier_3_cidr_blocks
  vpc_id           = ibm_is_vpc.vpc.id
  public_gateways  = ibm_is_public_gateway.multi_tier_gateway.*.id
}

##############################################################################