output "ip_addresses" {
  value = {
    for instance in digitalocean_droplet.droplet:
    instance.name => instance.ipv4_address
  }
  # value = digitalocean_droplet.droplet[*].ipv4_address
}

#output "lb_ip" {
#  value = digitalocean_loadbalancer.lb.ip
#}
