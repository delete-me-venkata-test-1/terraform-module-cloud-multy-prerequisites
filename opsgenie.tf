module "opsgenie_teams" {
  source               = "./modules/opsgenie/0.2.0"
  users                = var.opsgenie_emails
  tenant_key           = var.tenant_key
  cluster_environments = local.opsgenie_enabled_cluster_environments
}
