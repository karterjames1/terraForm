

variable "vpn_ip" {
  type        = string
  default     = "0.0.0.0/0"
  description = "Whitelisted IP"
}

variable "cidr" {
  type = string
  default = "10.0.0.0/20"
}

variable "subx_cidr1" {
  type = string
  default = "10.0.1.0/24"
}

variable "subx_cidr2" {
  type = string
  default = "10.0.2.0/24"
}

variable "subx_cidr3" {
  type = string
  default = "10.0.3.0/24"
}

variable "secret_key" {}
variable "access_key" {}
variable "region" {
  default = "us-east-1"
}

variable "azs" {
  type = list
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "type" {
  type = map
  default = {
    subnet1 = "az1"
    subnet2 = "az2"
    subnet3 = "az3"
  }
}
