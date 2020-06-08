##############################################################################
# Await 
##############################################################################

resource null_resource await_helm_install {

    provisioner local-exec {
        command = <<BASH
await_helm_install=${var.helm_status}
echo "Ready for creation"
        BASH
    } 
    
}

##############################################################################


##############################################################################
# Shared COS Storage
##############################################################################

module cos {
  source            = "./resource_data"
  name              = var.cos_name
  use_data          = var.bring_your_own_cos
  resource_group_id = var.resource_group_id
  service           = "cloud-object-storage"
  plan              = "standard"
  ibm_region        = "global"
}

##############################################################################


##############################################################################
# COS Access Key
##############################################################################

resource ibm_resource_key access {
  name                 = "cos_pvc_access_credentials"
  role                 = "Manager"
  resource_instance_id = module.cos.id
  parameters = {
    "HMAC" = true
  }

  depends_on = [null_resource.await_helm_install]
}

##############################################################################


##############################################################################
# COS Filesystem Bucket
##############################################################################

resource ibm_cos_bucket bucket {
  bucket_name          = var.cos_bucket_name
  resource_instance_id = module.cos.id
  region_location      = var.ibm_region
  storage_class        = "standard"
  #key_protect          = "${var.kms_crn}"

  depends_on = [ibm_resource_key.access]
} 

##############################################################################9