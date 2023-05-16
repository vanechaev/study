# cloud vars
 variable "token" {
   type        = string
   description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
 }

 variable "cloud_id" {
   type        = string
   description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
 }

 variable "folder_id" {
   type        = string
   description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
 }

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "compute image"
}

variable "public_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "ssh-keygen -t ed25519"
}

variable "instance_count" {
    type = number
    default = 3
}
/*
variable "secondary_disk" {
	type = number
    default = 1
}

variable "volumes" {
  default = [
    {
      "type" : "network-hdd"
    },
    {
      "type" : "network-hdd"
    },
    {
      "type" : "network-hdd"
    }
  ]
}
*/
variable "vm" {
  description = "List of VMs with specified parameters"
  type = list(object({
    name = string,
    cpu  = number,
    ram  = number,
    disk = number
  }))
  default = [
     {
    name = "vm1"
    cpu  = 2
    ram  = 1
    disk = 5
  },
  {
    name = "vm2"
    cpu  = 4
    ram  = 2
    disk = 6
  }
]
}
