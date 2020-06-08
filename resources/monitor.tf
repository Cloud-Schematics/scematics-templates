##############################################################################
# Monitoring Instance
##############################################################################

module monitoring {
    source            = "./resource_data"
    enable_service    = var.enable_monitoring
    use_data          = var.bring_your_own_monitoring 
    name              = var.monitor_name 
    service           = "sysdig-monitor"
    plan              = var.monitor_plan
    ibm_region        = var.ibm_region
    end_points        = var.end_points
    tags              = var.tags
    resource_group_id = data.ibm_resource_group.resource_group.id
}

##############################################################################