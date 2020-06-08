##############################################################################
# Install IBM Charts
##############################################################################

data helm_repository ibm_charts {
  name = "ibm-charts"
  url  = "https://icr.io/helm/ibm-charts"
}

resource helm_release s3fs {
  name       = "ibm-cos-plugin"
  chart      = "${path.module}/charts/ibm-object-storage-plugin"
  depends_on = [kubernetes_cluster_role_binding.default]
}

output status {
  value = helm_release.s3fs.status
}

##############################################################################