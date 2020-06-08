##############################################################################
# This file will create storage resource intances, 
# - creates a cloud object storage instance and a bucket,
##############################################################################


##############################################################################
# Create COS instance 
##############################################################################

module cos {

    source            = "./resource_data"
    enable_service    = var.enable_cos
    use_data          = var.bring_your_own_cos 
    name              = var.cos_name
    service           = "cloud-object-storage"
    plan              = var.cos_plan
    ibm_region        = "global"
    end_points        = var.end_points
    tags              = var.tags
    key_protect_key   = var.enable_kms? ibm_kp_key.root_key.crn : null
    resource_group_id = data.ibm_resource_group.resource_group.id

}

##############################################################################


##############################################################################
# Policy for KMS
##############################################################################

resource ibm_iam_authorization_policy cos_policy {

  count                       = var.enable_cos && var.enable_kms ? 1 : 0

  source_service_name         = "cloud-object-storage"
  source_resource_instance_id = module.cos.id
  target_service_name         = "kms"
  target_resource_instance_id = module.kms.id
  roles                       = ["Reader"]
}

##############################################################################


##############################################################################
# Create COS Bucket (Optional)
##############################################################################

resource ibm_cos_bucket cos_bucket {

  count                 = var.create_cos_bucket && var.enable_cos ? 1 : 0
  
  bucket_name           = var.cos_bucket_name
  resource_instance_id  = module.cos.id
  region_location       = var.ibm_region
  storage_class         = "standard"

  depends_on = [ibm_iam_authorization_policy.cos_policy]
}

##############################################################################