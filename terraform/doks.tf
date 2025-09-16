data "digitalocean_kubernetes_versions" "cluster" {
  version_prefix = "1.33."
}

resource "digitalocean_tag" "cluster" {
  name = "cluster"
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name          = "cluster-x"
  region        = local.do_region
  auto_upgrade  = true
  surge_upgrade = true
  version       = data.digitalocean_kubernetes_versions.cluster.latest_version
  tags          = [digitalocean_tag.cluster.name]

  maintenance_policy {
    start_time = "04:00"
    day        = "sunday"
  }

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 1
    tags       = [digitalocean_tag.cluster.name]
  }

  lifecycle {
    ignore_changes = [
      version,
    ]
  }
}

resource "digitalocean_project_resources" "cluster" {
  project   = digitalocean_project.bbcwqx.id
  resources = [digitalocean_kubernetes_cluster.cluster.urn]
}

output "connect" {
  value = "doctl kubernetes cluster kubeconfig save ${digitalocean_kubernetes_cluster.cluster.id}"
}
