resource "digitalocean_ssh_key" "key" {
  name       = "key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBKgyaOODiQRSu9A5n4S7LlgwMSKs93OK0DfXE8OvGhL"
}
