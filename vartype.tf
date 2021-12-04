variable "subs"{
    type = string
}
variable "location"{
    type = string
}
variable "rgname"{
    type = string
}
variable "vm1"{
    type = string
}
# variable "vm2"{
#     type = string
# }
# variable "vm3"{
#     type = string
# }
# variable "vm4"{
#     type = string
# }
variable "vn"{
    type = string
}
variable "sn"{
    type = string
}
variable "vm_username" {
  description = "Database administrator username"
  type        = string
}

variable "vm_password" {
  description = "Database administrator password"
  type        = string
  sensitive   = true
}