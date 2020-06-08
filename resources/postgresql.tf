##############################################################################
# This file creates the PostgresSQL Database, creates a user with Postgres
# rbac, assign IAM policies
##############################################################################

##############################################################################
# Create Postgresql database
##############################################################################

module postgresql {

    source            = "./resource_data"
    enable_service    = var.enable_postgres
    use_data          = var.bring_your_own_postgres 
    name              = var.postgres_name
    service           = "databases-for-postgresql"
    plan              = var.postgres_plan
    ibm_region        = var.ibm_region
    end_points        = var.end_points
    tags              = var.tags
    key_protect_key   = var.enable_kms? ibm_kp_key.root_key.crn : null
    resource_group_id = data.ibm_resource_group.resource_group.id

}

##############################################################################


##############################################################################
# Policy for KMS
##############################################################################

resource ibm_iam_authorization_policy psql_policy {
  source_service_name         = "databases-for-postgresql"
  source_resource_instance_id = module.postgresql.id
  target_service_name         = "kms"
  target_resource_instance_id = module.kms.id
  roles                       = ["Reader"]
}

##############################################################################