##############################################################################
# Locally define image pull secrets to copy to ibm-observe namespace 
##############################################################################
locals {
  image_pull_secrets = [
    "jp-icr-io", 
    "au-icr-io", 
    "de-icr-io", 
    "uk-icr-io",
    "us-icr-io",
    "icr-io"
  ]
}
##############################################################################


##############################################################################
# Default pull secret
##############################################################################

data kubernetes_secret image_pull_secret {
    count = length(local.image_pull_secrets)
    metadata {
        name = "default-${element(local.image_pull_secrets, count.index)}"
    }
}

##############################################################################


##############################################################################
# Copy Image Pull Secrets to Kube System
##############################################################################

resource kubernetes_secret copy_image_pull_secret {

    count = length(local.image_pull_secrets)

    metadata {
        name      = "kube-system-${element(local.image_pull_secrets, count.index)}"
        namespace = "kube-system"
    }
  
    data      = {
        ".dockerconfigjson" = "${data.kubernetes_secret.image_pull_secret[count.index].data[".dockerconfigjson"]}"
    }

    type = "kubernetes.io/dockerconfigjson"

}

##############################################################################


##############################################################################
# Give tiller service account admin permissions
##############################################################################

resource kubernetes_cluster_role_binding default {
    metadata {
        name = "default-cluster-rule"
    }

    role_ref {
        api_group = "rbac.authorization.k8s.io"
        kind      = "ClusterRole"
        name      = "cluster-admin"
    }

    subject {
        kind      = "ServiceAccount"
        name      = "default"
        namespace = "kube-system"
    }

    subject {
        api_group = ""
        kind      = "ServiceAccount"
        name      = "default"
        namespace = "kube-system"
    }

    depends_on = [kubernetes_secret.copy_image_pull_secret]
}

##############################################################################