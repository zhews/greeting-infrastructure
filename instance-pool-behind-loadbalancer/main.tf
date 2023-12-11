resource "exoscale_ssh_key" "instance_ssh_key" {
  name       = "${var.name}-instance-ssh-key"
  public_key = var.ssh_public_key
}

resource "exoscale_security_group" "greeters_security_group" {
  name = "${var.name}-greeters-security-group"
}

resource "exoscale_security_group_rule" "greeters_security_group_rule" {
  security_group_id = exoscale_security_group.greeters_security_group.id
  for_each          = var.security_group_allowed_ports
  type              = "INGRESS"
  protocol          = "TCP"
  cidr              = "0.0.0.0/0"
  start_port        = tonumber(each.key)
  end_port          = tonumber(each.key)
}

data "exoscale_template" "ubuntu" {
  name = "Linux Ubuntu 22.04 LTS 64-bit"
  zone = var.zone
}

resource "exoscale_instance_pool" "greeters" {
  name = "${var.name}-greeters"
  zone = var.zone

  template_id        = data.exoscale_template.ubuntu.id
  instance_type      = var.instance_type
  disk_size          = var.instance_disk_size
  size               = var.instance_count
  key_pair           = exoscale_ssh_key.instance_ssh_key.name
  security_group_ids = [exoscale_security_group.greeters_security_group.id]
}

resource "exoscale_nlb" "greeters_nlb" {
  name = "${var.name}-greeters-nlb"
  zone = var.zone
}

resource "exoscale_nlb_service" "greeters_nlb_service" {
  name   = "${var.name}-greeters-nlb-service"
  zone   = exoscale_nlb.greeters_nlb.zone
  nlb_id = exoscale_nlb.greeters_nlb.id

  instance_pool_id = exoscale_instance_pool.greeters.id
  port             = 8080
  target_port      = 8080

  healthcheck {
    port = 8080
    mode = "http"
    uri  = "/"
  }
}
