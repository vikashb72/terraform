resource "digitalocean_droplet" "droplet" {
  count    = 1
  image    = "ubuntu-22-04-x64"
  name     = "${var.group_name}-${var.droplet_names[count.index]}"
  ipv6     = true
  region   = "lon1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
    #"43:33:e9:c9:bb:73:fb:ec:13:86:ab:55:0a:32:a3:6a"
  ]

  #  Failed to read ssh private key: password protected keys are
  #  not supported. Please decrypt the key prior to use.
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    #private_key = "${file(var.private_key)}"
    timeout     = "30s"
    agent       = true
  }

  provisioner "file" {
    source      = "docker.install.sh"
    destination = "/tmp/docker.install.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "chmod +x /tmp/docker.install.sh",
        "/tmp/docker.install.sh",
        "rm /tmp/docker.install.sh"
    ]
  }

  #provisioner "remote-exec" {
  #  inline = [
  #    "export PATH=$PATH:/usr/bin",
  #    # install nginx
  #    "sudo apt update",
  #    "sudo apt install -y nginx"
  #  ]
  #}

  #provisioner "local-exec" {
  #  when    = destroy
  #  command = "echo 'Droplet ${self.name} is being destroyed!'"
  #}
}
