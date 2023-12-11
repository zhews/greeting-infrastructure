output "nlb_ip_address" {
  value = exoscale_nlb.greeters_nlb.ip_address
}

output "instance_ip_addresses" {
  value = exoscale_instance_pool.greeters.instances[*].public_ip_address
}
