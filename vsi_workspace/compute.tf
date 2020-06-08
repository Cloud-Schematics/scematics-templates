##############################################################################
# SSH key for creating VSI
##############################################################################

resource ibm_is_ssh_key ssh_key {
  name       = "${var.unique_id}-ssh-key"
  public_key = var.ssh_public_key
}

##############################################################################


##############################################################################
# Image Data Block
##############################################################################

data ibm_is_image image {
    name = var.image
}

##############################################################################


##############################################################################
# Provision VSI
##############################################################################

resource ibm_is_instance vsi {
  count   = var.vsi_per_subnet * length(local.subnet_ids)

  name           = "${var.unique_id}-vsi-${count.index + 1}"
  image          = data.ibm_is_image.image.id
  profile        = var.machine_type
  resource_group = data.ibm_resource_group.group.id
  primary_network_interface {
    subnet   = element(local.subnet_ids, (count.index / var.vsi_per_subnet))
  }  

  user_data  = file("${path.module}/config/install_nginx.sh")
                 
  vpc        = data.ibm_is_vpc.vpc.id
  zone       = element(
      data.ibm_is_subnet.subnet.*.zone,
      index(
        local.subnet_ids, 
        element(local.subnet_ids, (count.index / var.vsi_per_subnet))
      )
  )

  
  keys       = [ibm_is_ssh_key.ssh_key.id]
}

##############################################################################


##############################################################################
# Provision Floating IPs for Subnets
##############################################################################

resource ibm_is_floating_ip vsi_fip {
  count  = var.enable_fip ? var.vsi_per_subnet * length(local.subnet_ids) : 0
  name   = "${var.unique_id}-fip-${count.index + 1}"
  target = element(ibm_is_instance.vsi.*.primary_network_interface.0.id, count.index)
}

##############################################################################