##############################################################################
# Variables
##############################################################################

variable enable_service {
  description = "Enable this service"
  type        = bool
  default     = true
}

variable use_data {
    description = "Use data block to get resource ID"
    type        = bool
    default     = false
}

variable name {
    description = "Name of resource. Needed for both data and resource"
    type        = string
}

variable resource_group_id {
    description = "id of resource group for service. Needed for both data and resource"
    type        = string
    default     = ""
}

variable service {
    description = "Name of service. Needed for both data and resource. (ex. cloudcerts)"
    type        = string
}

variable key_protect_key {
    description = "Optional id of key protect key of which to encrypt service instance"
    type        = string
    default     = ""
}

variable key_protect_id {
    description = "Optional id of key protect instance where the key is provisioned. Used to give service read access."
    type        = string
    default     = ""
}


##############################################################################


##############################################################################
# Resource Creation Variables (Optional)
##############################################################################

variable ibm_region {
  description = "IBM Cloud region where resource will be deployed"
  type        = string
  default     = "us-south"
}

variable end_points {
  description = "Sets the endpoints for the resource provisioned. Can be `public` or `private`"
  type        = string
  default     = "public"
}

variable plan {
  description = "service plan for resource. Depends on type of service created"
  type        = string
}

variable HMAC {
    description = "Add HMAC parameters to service. May not be supported by all services"
    type        = string
    default     = false
}

variable tags {
  description = "List of tags for created resource"
  type        = list
  default     = []
}

##############################################################################

