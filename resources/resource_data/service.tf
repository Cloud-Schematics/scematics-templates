##############################################################################
# Create Resource Instance
##############################################################################

resource ibm_resource_instance service {
  count             = !var.use_data && var.enable_service ? 1 : 0 
  name              = var.name
  service           = var.service
  plan              = var.plan
  location          = var.ibm_region
  resource_group_id = var.resource_group_id != "" ? var.resource_group_id : null

  parameters = {
    "HMAC"            = var.HMAC ? true : null
    service-endpoints = var.end_points
    key_protect_key   = var.key_protect_key != "" ? var.key_protect_key : null
  }

  tags = var.tags

  timeouts {
    create = "1h"
    update = "1h"
    delete = "1h"
  }

}

##############################################################################


################################################################################
# Resource Instance Data
################################################################################

data ibm_resource_instance service {
  count             = var.use_data && var.enable_service ? 1 : 0
  name              = var.name
  resource_group_id = var.resource_group_id != "" ? var.resource_group_id : null
  service           = var.service
}

################################################################################


################################################################################
# Locals
################################################################################

locals {

  service_id = (
    var.use_data
    ? data.ibm_resource_instance.service.0.id
    : ibm_resource_instance.service.0.id
  )

  service_guid = (
    var.use_data
    ? element(split(":", data.ibm_resource_instance.service.0.id), 7) 
    : ibm_resource_instance.service.0.guid
  )
}

################################################################################


################################################################################
# Output
################################################################################

output id {
  description = "ID of service instance"
  value       = local.service_id
}

output guid {
  description = "ID of service instance"
  value       = local.service_guid
}

################################################################################