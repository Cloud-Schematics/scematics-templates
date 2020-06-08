##############################################################################
# Create Key Protect Instance
##############################################################################

  module kms {

    source            = "./resource_data"
    enable_service    = var.enable_kms
    use_data          = var.bring_your_own_root_key
    name              = var.kms_name 
    service           = "kms"
    plan              = var.kms_plan
    ibm_region        = var.ibm_region
    end_points        = var.end_points
    tags              = var.tags
    resource_group_id = data.ibm_resource_group.resource_group.id

}

##############################################################################


##############################################################################
# Key Protect Root Key
##############################################################################

resource ibm_kp_key root_key {
  key_protect_id  = module.kms.guid
  key_name        = var.kms_root_key_name
  standard_key    = false
  force_delete    = true
}

##############################################################################

