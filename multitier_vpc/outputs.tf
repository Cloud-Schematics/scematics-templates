##############################################################################
# VPC GUID
##############################################################################

output vpc_id {
  description = "ID of VPC created"
  value       = ibm_is_vpc.vpc.id
}

##############################################################################


##############################################################################
# List of subnet IDs
##############################################################################

output tier_1_subnet_ids {
  description = "List of subnet ids in tier 1"
  value       = module.tier_1_subnets.subnet_ids
}

output tier_2_subnet_ids {
  description = "List of subnet ids in tier 2"
  value       = module.tier_2_subnets.subnet_ids
}

output tier_3_subnet_ids {
  description = "List of subnet ids in tier 3"
  value       = module.tier_3_subnets.subnet_ids
}

##############################################################################


##############################################################################
# ACL ID
##############################################################################

output acl_id {
  description = "ID of ACL created"
  value       = ibm_is_network_acl.multizone_acl.id
}

##############################################################################