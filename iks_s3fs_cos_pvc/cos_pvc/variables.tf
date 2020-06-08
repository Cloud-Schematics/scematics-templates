##############################################################################
# Helm Variable
##############################################################################

variable helm_status {
    description = "Awaits the completion of the s3fs installation for the creation of COS resources"
}

##############################################################################


##############################################################################
# Account Variables
##############################################################################

variable ibm_region {
    description = "Region where COS buckets will be provisioned"
}

variable resource_group_id {
    description = "ID of resource group where COS will be provisioned"
}

##############################################################################


##############################################################################
# COS Variables
##############################################################################

variable cos_name {
    description = "Name of cos instance to be created"
}

variable bring_your_own_cos {
    description = "Bring your own cos instance. If false, one will be created for you"
    default     = false
}

variable cos_bucket_name {
    description = "Name of cos bucket to be shared by resources"
}

##############################################################################


##############################################################################
# PVC Variables
##############################################################################

variable storage_class {
    description = "Storage class of the PVC to be created"
    default     = "ibmc-s3fs-standard-perf-regional"
}

##############################################################################