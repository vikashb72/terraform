variable "do_token" {}
variable "droplet_count" {
  type = number
  default = 1
}
variable "droplet_size" {
  type = string
  default = "s-1vcpu-1gb"
}
variable "environment" {}
variable "droplet_names" {
  type    = list(string)
  default = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
}
