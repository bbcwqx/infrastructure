data "github_repository" "flux" {
  full_name = local.github_repository
}

resource "tls_private_key" "flux" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "github_repository_deploy_key" "flux" {
  title      = "Flux"
  repository = data.github_repository.flux.name
  key        = tls_private_key.flux.public_key_openssh
  read_only  = "false"
}

resource "flux_bootstrap_git" "flux" {
  depends_on = [github_repository_deploy_key.flux]

  embedded_manifests = true
  path               = "cluster"
}
