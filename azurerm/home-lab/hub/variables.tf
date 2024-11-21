# Required
variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type    = string
}

variable "vnets" {
  type = list(string)
}

variable "snets" {
  type = map(any)
}

variable "storage_account" {
  type = string
}

# Optional
variable "organisation" {
  default = "wherever"
  type    = string
}

variable "department" {
  default = "home"
  type    = string
}

variable "project" {
  default = "lab"
  type    = string
}

variable "region" {
  default = "southafricanorth"
  type    = string
}

variable "region_code" {
  default = "za"
  type    = string
}

variable "instance" {
  default = "01"
  type    = string
}

variable "environment" {
  default = "hub"
  type    = string
}

variable "storage_containers" {
  default = []
  type    = list(any)
}

#variable "kv_key_permissions_full" {
#  type        = list(string)
#  description = "List of full key permissions, must be one or more from the following: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey."
#  default     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"]
#}
#
#variable "kv_secret_permissions_full" {
#  type        = list(string)
#  description = "List of full secret permissions, must be one or more from the following: backup, delete, get, list, purge, recover, restore and set"
#  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
#
#}
#
#variable "kv_certificate_permissions_full" {
#  type        = list(string)
#  description = "List of full certificate permissions, must be one or more from the following: backup, create, delete, deleteissuers, get, getissuers, import, list, listissuers, managecontacts, manageissuers, purge, recover, restore, setissuers and update"
#  default     = ["Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import", "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore", "SetIssuers", "Update"]
#}
#
#variable "kv_storage_permissions_full" {
#  type        = list(string)
#  description = "List of full storage permissions, must be one or more from the following: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update"
#  default     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update", ]
#}
