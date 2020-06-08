##############################################################################
# Provider
##############################################################################

provider ibm {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.ibm_region
  generation       = var.generation
  ibmcloud_timeout = 60
}

##############################################################################


##############################################################################
# Resource Group
##############################################################################

data ibm_resource_group group {
  name = var.resource_group
}

##############################################################################


##############################################################################
# Cluster Data
##############################################################################

data ibm_container_cluster_config cluster {
  cluster_name_id   = var.cluster_name
  resource_group_id = data.ibm_resource_group.group.id
  admin             = true
}

##############################################################################


##############################################################################
# Kubernetes Provider
##############################################################################

provider kubernetes {
  load_config_file       = false
  host                   = data.ibm_container_cluster_config.cluster.host
  client_certificate     = data.ibm_container_cluster_config.cluster.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster.ca_certificate
}

##############################################################################


##############################################################################
# Kubernetes Provider
##############################################################################

provider helm {
  kubernetes {
    load_config_file       = false
    host                   = data.ibm_container_cluster_config.cluster.host
    client_certificate     = data.ibm_container_cluster_config.cluster.admin_certificate
    client_key             = data.ibm_container_cluster_config.cluster.admin_key
    cluster_ca_certificate = data.ibm_container_cluster_config.cluster.ca_certificate
  }
}

##############################################################################


##############################################################################
# S3FS Setup
##############################################################################

module s3fs {
  source = "./s3fs_install"
}

##############################################################################


##############################################################################
# PVC 
##############################################################################

module pvc {
  source             = "./cos_pvc"
  helm_status        = module.s3fs.status
  ibm_region         = var.ibm_region
  resource_group_id  = data.ibm_resource_group.group.id
  bring_your_own_cos = var.bring_your_own_cos
  cos_name           = var.cos_name
  cos_bucket_name    = var.cos_bucket_name
  storage_class      = var.storage_class
}

##############################################################################