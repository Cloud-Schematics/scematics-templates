##############################################################################
# Fetch Secret With External Resource
##############################################################################

data ibm_iam_auth_token tokendata {}

data external cos_hmac_keys {
  program = [
    "bash",
    "${path.module}/config/fetch_hmac_key.sh",
    data.ibm_iam_auth_token.tokendata.iam_access_token,
    element(split(":", ibm_resource_key.access.id),9)
  ]
}

##############################################################################


##############################################################################
# Create IKS Secret for COS Creds
##############################################################################

resource kubernetes_secret cos_write_access {
  metadata {
    name = "cos-write-access"
  }

  data = {
    "access-key" = data.external.cos_hmac_keys.result["access_key_id"]
    "secret-key" = data.external.cos_hmac_keys.result["secret_access_key"]
  }

  type = "ibm/ibmc-s3fs"
}

##############################################################################


##############################################################################
# Kubernetes PVC
##############################################################################

resource kubernetes_persistent_volume_claim cos_pvc {
  metadata {
    name      = "cosfs-pvc"
    namespace = "default"
    annotations = {
      "ibm.io/auto-create-bucket" = "false"
      "ibm.io/auto-delete-bucket" = "false"
      "ibm.io/bucket"             = var.cos_bucket_name
      "ibm.io/endpoint"           = "https://s3.direct.${var.ibm_region}.cloud-object-storage.appdomain.cloud"
      "ibm.io/secret-name"        = kubernetes_secret.cos_write_access.metadata.0.name
    }
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "8Gi"
      }
    }
    storage_class_name = var.storage_class
  }

  depends_on = [ibm_cos_bucket.bucket]
}

##############################################################################
