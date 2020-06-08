##############################################################################
# Account variables
##############################################################################

variable ibmcloud_api_key {
    description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
}

variable generation {
    description = "Generation of VPC. Can be 1 or 2"
    default     = 1
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    default     = "eu-gb"
}

variable resource_group {
    description = "Name for IBM Cloud Resource Group"
    default     = "asset-development"
}

variable cluster_name {
    description = "Name of the cluster where resources will be deployed"
}

##############################################################################


##############################################################################
# COS Variables
##############################################################################

variable bring_your_own_cos {
    description = "Bring your own cos instance. If false, one will be created for you"
    default     = false
}

variable cos_name {
    description = "Name of cos instance to be created"
    default     = "asset-s3fs-cos"
}

variable cos_bucket_name {
    description = "Name of cos bucket to create"
    default     = "test-bucket-for-tests"
}

variable storage_class {
    description = "Storage class of the PVC to be created"
    default     = "ibmc-s3fs-standard-perf-regional"
}

##############################################################################