##############################################################################
# Account Variables
##############################################################################

variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
}

variable vpc_name {
  description = "Name of VPC"
  type        = string
}

variable ibm_region {
  description = "IBM Cloud region where all resources will be deployed"
  type        = string
  default     = "us-south"
}

variable resource_group {
  description = "Name of resource group to create VPC"
  type        = string
  default     = "asset-development"
}

variable unique_id {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
  default     = "asset-module-vsi"
}

##############################################################################


##############################################################################
# VPC Variables
##############################################################################

variable generation {
  description = "Generation of VPC"
  # type      = number Currently IBM Schematics does not support `number` variables. Uncomment when updated
  default     = 2
}

variable enable_fip {
  description = "Enable floating IP. Can be true or false"
  # type        = number Currently IBM Schematics does not support `bool` variables. Uncomment when updated
  default     = true
}

variable subnet_names {
  description = "A list of subnet names where VSI will be deployed"
  default     = ["turbo-build-1","turbo-build-2","turbo-build-3"]
}


##############################################################################


##############################################################################
# VSI Variables
##############################################################################

variable image {
  description = "Image name used for VSI. Run 'ibmcloud is images' to find available images in a region"
  type        = string
  default     = "ibm-centos-7-6-minimal-amd64-2"
}

variable ssh_public_key {
  description = "ssh public key to use for vsi"
  type        = string
}

variable machine_type {
  description = "VSI machine type. Run 'ibmcloud is instance-profiles' to get a list of regional profiles"
  type        =  string
  default     = "bx2-2x8"
}

variable vsi_per_subnet {
    description = "Number of VSI instances for each subnet"
    # type        = number Currently IBM Schematics does not support `number` variables. Uncomment when updated
    default     = 1
}

##############################################################################