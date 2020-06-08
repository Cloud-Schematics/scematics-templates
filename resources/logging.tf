##############################################################################
# Create Activity Tracker
##############################################################################
resource ibm_resource_instance activity_tracker {
  count             = var.enable_activity_tracker ? 1 : 0
  name              = var.activity_tracker_name
  service           = "logdnaat"
  plan              = var.logging_plan
  location          = var.ibm_region
  resource_group_id = data.ibm_resource_group.resource_group.id
  parameters = {
    service-endpoints = var.end_points
  }
  tags = var.tags
}
##############################################################################


##############################################################################
# create LogDNA instance
##############################################################################

module logdna {

    source            = "./resource_data"
    enable_service    = var.enable_logging
    use_data          = var.bring_your_own_logging 
    name              = var.logging_name
    service           = "logdna"
    plan              = var.logging_plan
    ibm_region        = var.ibm_region
    end_points        = var.end_points
    tags              = var.tags
    resource_group_id = data.ibm_resource_group.resource_group.id
  
}

##############################################################################