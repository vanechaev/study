###cloud vars
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
  description = "VPC network & subnet name"
}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "compute image"
}

variable "vm_web_instance" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "compute instance"
}

variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "compute image"
}

variable "vm_db_instance" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "compute instance"
}

variable "platform_id" {
  type        = string
  default     = "standard-v1"
  description = "compute platform"
}

variable "spe" {
  type        = bool
  default     = "1"
  description = "serial-port-enable"
}

variable "env" {
  default = "develop"
}

variable "project"  {
  default = "platform"
}

variable "role" {
  default = "web"
}

variable "role2" {
  default = "db"
} 


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_resources" {
  type            = map(number)
  default         = {
    cores         = "2"
    memory        = "1"
    core_fraction = "5"
  }
}

variable "vm_db_resources" {
  type             = map(number)
  default          = {
     "cores"         = "2"
     "memory"        = "2"
     "core_fraction" = "20"
  }
}
