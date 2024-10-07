variable "do_token" {}
#variable "private_key" {}
variable "group_name" {}
variable "droplet_names" {
   type    = list(string)
   default = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
}
