##############################################################################
# Sensitive Account Variables
##############################################################################

variable ibmcloud_api_key {
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
  type        = string
}

##############################################################################


##############################################################################
# Account Variables
##############################################################################

variable generation {
  description = "The IBM Cloud platform Virtual private cloud generation you want. Typically 1 or 2"
  type        = number
  default     = 1
}

variable ibm_region {
  description = "IBM Cloud region where all resources will be deployed"
  type        = string
  default     = "us-south"
}

variable resource_group {
  description = "Name of resource group to provision resources"
  type        = string
  default     = "default"
}

variable tags {
  description = "List of tags for resources"
  type        = list(string)
  default     = ["resources-module"]
}

##############################################################################


##############################################################################
# Resource Service Endpoints
##############################################################################

variable end_points {
  description = "Sets the endpoints for the resources provisioned. Can be `public` or `private`"
  type        = string
  default     = "public"
}

##############################################################################


##############################################################################
# CMS Variables
##############################################################################

variable enable_cms {
  description = "Creates new cms instance if true"
  type        = bool
  default     = true
}

variable bring_your_own_cms {
  description = "Bring your own cms instance. If false, one will be created"
  type        = bool
  default     = false
}

variable cms_name {
  description = "Name of bring your own cms resource"
  type        = string
  default     = "resource-module-cms"
}

variable cms_plan {
  description = "service plan for certificate manager"
  type        = string
  default     = "free"
}

##############################################################################



##############################################################################
# Key Protect Variables
##############################################################################

variable enable_kms {
  description = "Creates new key protect instance if true"
  type        = bool
  default     = true
}

variable bring_your_own_root_key {
  description = "Bring your own key protect instance. If false, one will be created"
  type        = bool
  default     = false
}

variable kms_name {
  description = "Name of bring your own kms resource"
  type        = string
  default     = "resource-module-kms"
}

variable kms_plan {
  description = "the plan to use for provisioning key protect instance"
  type        = string
  default     = "tiered-pricing"  
}

variable kms_root_key_name {
  description = "the plan to use for provisioning key protect instance"
  type        = string
  default     = "root_key"
}


##############################################################################


##############################################################################
# COS Variables
##############################################################################

variable enable_cos {
  description = "Creates new cloud object storage instance if true"
  type        = bool
  default     = true
}

variable bring_your_own_cos {
  description = "Bring your own cloud object storage instance. If false, one will be created"
  type        = bool
  default     = false
}

variable cos_name {
  description = "Name of bring your own cloud object storage resource"
  type        = string
  default     = "resource-module-cos"
}

variable cos_plan {
  description = "cloud object storage plan"
  type        = string
  default     = "standard"
}

variable create_cos_bucket {
  description = "Allows for optional creation of a COS bucket. Can be true or false"
  type        = bool
  default     = true
}

variable cos_bucket_name {
  description = "Bucket name for COS. Must be unique within account"
  type        = string
  default     = "cloud-resources-demo-bucket"
}

variable cos_bucket_storage_class {
  description = "COS bucket storage class. Accepted values: 'standard’, 'vault’, 'cold’, 'flex’"
  type        = string
  default     = "standard"
}

##############################################################################


##############################################################################
# PostgresSQL Variables
##############################################################################

variable enable_postgres {
  description = "Creates new postgres instance if true"
  type        = bool
  default     = true
}

variable bring_your_own_postgres {
  description = "Bring your own postgres instance. If false, one will be created"
  type        = bool
  default     = false
}

variable postgres_name {
  description = "Name of bring your own postgres resource"
  type        = string
  default     = "resource-module-postgres"
}

variable postgres_plan {
  description = "postgresSQL database plan"
  type        = string
  default     = "standard"
}

##############################################################################


##############################################################################
# Logging and Monitoring Variables
##############################################################################

variable enable_activity_tracker {
  description = "Provision activity tracker, true or false"
  type        = bool
  default     = false
}

variable bring_your_own_activity_tracker {
  description = "Bring your own activity tracker instance. If false, one will be created"
  type        = bool
  default     = false
}

variable activity_tracker_name {
  description = "Name of bring your own activity tracker name"
  type        = string
  default     = "resource-module-activity-tracker"
}

variable enable_logging {
  description = "Creates new LogDNA instance if true"
  type        = bool
  default     = true
}

variable bring_your_own_logging {
  description = "Bring your own LogDNA instance. If false, one will be created"
  type        = bool
  default     = false
}

variable logging_name {
  description = "Name of bring your own logging resource"
  type        = string
  default     = "resource-module-logging"
}

variable logging_plan {
  description = "Service plan for LogDNA, Activity Tracker."
  type        = string
  default     = "7-day"
}

variable enable_monitoring {
  description = "Creates new monitoring instance if true"
  type        = bool
  default     = true
}

variable bring_your_own_monitoring {
  description = "Bring your own monitoring instance. If false, one will be created"
  type        = bool
  default     = false
}

variable monitor_name {
  description = "Name of bring your own monitoring resource"
  type        = string
  default     = "resource-module-monitoring"
}


variable monitor_plan {
  description = "service plan for Monitoring"
  type        = string
  default     = "graduated-tier"
}

##############################################################################
