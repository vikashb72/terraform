resource "digitalocean_droplet" "droplet" {
  count    = var.droplet_count
  image    = "ubuntu-22-04-x64"
  name     = "${var.environment}-${var.droplet_names[count.index]}"
  ipv6     = true
  region   = "lon1"
  size     = "${var.droplet_size}"
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]

  #  Failed to read ssh private key: password protected keys are
  #  not supported. Please decrypt the key prior to use.
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    timeout     = "90s"
    agent       = true
  }

  provisioner "remote-exec" {
    inline = [
        "mkdir -p /tmp/installation"
    ]
  }

  provisioner "file" {
    source      = "installation/"
    destination = "/tmp/installation"
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/installation/installer.sh",
        "/tmp/installation/installer.sh",
        "rm -rf /tmp/installation"
    ]
  }
}
