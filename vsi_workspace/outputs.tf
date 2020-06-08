##############################################################################
# VSI Outputs
##############################################################################

output vsi {
    description = "Provisioned VSIs IDs, subnets and zones."
    value       = [
        for i in ibm_is_instance.vsi:
        {
            id      = i.id,
            subnet  = lookup(i.primary_network_interface[0], "id") ,
            zone    = i.zone
        }
    ]
}


##############################################################################


