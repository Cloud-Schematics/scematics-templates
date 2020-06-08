##############################################################################
# Create certificate manager 
##############################################################################

module cms {
  
    source            = "./resource_data"
    enable_service    = var.enable_cms
    use_data          = var.bring_your_own_cms 
    name              = var.cms_name
    service           = "cloudcerts"
    plan              = var.cms_plan
    ibm_region        = var.ibm_region
    end_points        = var.end_points
    tags              = var.tags
    resource_group_id = data.ibm_resource_group.resource_group.id

}

##############################################################################