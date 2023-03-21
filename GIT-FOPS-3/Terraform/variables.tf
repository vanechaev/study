# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1grubm3o3lpb9lh25up"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1g012f6rgs30ucfn1kd"
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "ubuntu" {
  default = "fd8emvfmfoaordspe1jr"
}
