module "pygreeter" {
  source         = "./instance-pool-behind-loadbalancer"
  name           = "pygreeter"
  ssh_public_key = var.ssh_public_key
}

module "gogreeter" {
  source         = "./instance-pool-behind-loadbalancer"
  name           = "gogreeter"
  ssh_public_key = var.ssh_public_key
}
