## Домашнее задание к занятию "Основы Terraform. Yandex Cloud" - Нечаев Владимир

<details>
<summary>Задание 1</summary>
  
1. Изучите проект. В файле variables.tf объявлены переменные для yandex provider.
2. Переименуйте файл personal.auto.tfvars_example в personal.auto.tfvars. Заполните переменные (идентификаторы облака, токен доступа). Благодаря .gitignore этот файл не попадет в публичный репозиторий. **Вы можете выбрать иной способ безопасно передать секретные данные в terraform.**
3. Сгенерируйте или используйте свой текущий ssh ключ. Запишите его открытую часть в переменную **vms_ssh_root_key**.
4. Инициализируйте проект, выполните код. Исправьте возникшую ошибку. Ответьте в чем заключается ее суть?
5. Ответьте, что означает ```preemptible = true``` и ```core_fraction``` в параметрах ВМ? Как это может пригодится в процессе обучения? Ответ в документации Yandex cloud.

В качестве решения приложите:
- скриншот ЛК Yandex Cloud с созданной ВМ,
- скриншот успешного подключения к консоли ВМ через ssh,
- ответы на вопросы.

</details>

#### Ответ:
    
> 4. Инициализируйте проект, выполните код. Исправьте возникшую ошибку. Ответьте в чем заключается ее суть?

Суть заключалось в неправильном подборе ядер при заданной платформе.

![img](https://github.com/vanechaev/study/blob/05e65e8978b0cdd54e4b8c20157b8a317e2cbba2/virt-23/Terraform/img/ya-ter-stand-1.png)

> 5. Ответьте, что означает ```preemptible = true``` и ```core_fraction``` в параметрах ВМ? Как это может пригодится в процессе обучения?

```preemptible = true``` - прерываемая ВМ

```core_fraction``` - уровни [производительности vCPU](https://cloud.yandex.ru/docs/compute/concepts/performance-levels)

Значение этих параметров влияет на цену аренды ВМ.

- скриншот ЛК Yandex Cloud с созданной ВМ

![](https://github.com/vanechaev/study/blob/05e65e8978b0cdd54e4b8c20157b8a317e2cbba2/virt-23/Terraform/img/ya-ter-vm-cloud.png)

- скриншот успешного подключения к консоли ВМ через ssh

![](- скриншот успешного подключения к консоли ВМ через ssh)

<details>
<summary>Задание 2</summary>

1. Изучите файлы проекта.
2. Замените все "хардкод" **значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan (изменений быть не должно). 
  
</details>

#### Ответ:

Изменения в main.tf

```terraform

data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}
resource "yandex_compute_instance" "platform" {
  name        = var.vm_web_instance
  platform_id = "standard-v1"
```

Изменения в variables.tf

```terraform
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
```
terraform plan без изменений

<details>

```terraform
va@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/02/src$ terraform plan
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 1s [id=fd8snjpoq85qqv0mk9gi]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# yandex_compute_instance.platform will be created
+ resource "yandex_compute_instance" "platform" {
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = (known after apply)
+ id                        = (known after apply)
+ metadata                  = {
+ "serial-port-enable" = "1"
+ "ssh-keys"           = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "netology-develop-platform-web"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v1"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = (known after apply)

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8snjpoq85qqv0mk9gi"
+ name        = (known after apply)
+ size        = (known after apply)
+ snapshot_id = (known after apply)
+ type        = "network-hdd"
}
}

+ metadata_options {
+ aws_v1_http_endpoint = (known after apply)
+ aws_v1_http_token    = (known after apply)
+ gce_http_endpoint    = (known after apply)
+ gce_http_token       = (known after apply)
}

+ network_interface {
+ index              = (known after apply)
+ ip_address         = (known after apply)
+ ipv4               = true
+ ipv6               = (known after apply)
+ ipv6_address       = (known after apply)
+ mac_address        = (known after apply)
+ nat                = true
+ nat_ip_address     = (known after apply)
+ nat_ip_version     = (known after apply)
+ security_group_ids = (known after apply)
+ subnet_id          = (known after apply)
}

+ placement_policy {
+ host_affinity_rules = (known after apply)
+ placement_group_id  = (known after apply)
}

+ resources {
+ core_fraction = 5
+ cores         = 2
+ memory        = 1
}

+ scheduling_policy {
+ preemptible = true
}
}

# yandex_vpc_network.develop will be created
+ resource "yandex_vpc_network" "develop" {
+ created_at                = (known after apply)
+ default_security_group_id = (known after apply)
+ folder_id                 = (known after apply)
+ id                        = (known after apply)
+ labels                    = (known after apply)
+ name                      = "develop"
+ subnet_ids                = (known after apply)
}

# yandex_vpc_subnet.develop will be created
+ resource "yandex_vpc_subnet" "develop" {
+ created_at     = (known after apply)
+ folder_id      = (known after apply)
+ id             = (known after apply)
+ labels         = (known after apply)
+ name           = "develop"
+ network_id     = (known after apply)
+ v4_cidr_blocks = [
+ "10.0.1.0/24",
]
+ v6_cidr_blocks = (known after apply)
+ zone           = "ru-central1-a"
}

Plan: 3 to add, 0 to change, 0 to destroy.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run
"terraform apply" now.
```

</details>
  
 <details>
<summary>Задание 3</summary>

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ: **"netology-develop-platform-db"** ,  cores  = 2, memory = 2, core_fraction = 20. 
  Объявите ее переменные с префиксом **vm_db_** в том же файле.
3. Примените изменения.
  
</details>

#### Ответ:

<details>

```terraform
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/02/src$ terraform plan
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 0s [id=fd8snjpoq85qqv0mk9gi]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# yandex_compute_instance.netology-develop-platform-db will be created
+ resource "yandex_compute_instance" "netology-develop-platform-db" {
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = (known after apply)
+ id                        = (known after apply)
+ metadata                  = {
+ "serial-port-enable" = "1"
+ "ssh-keys"           = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "netology-develop-platform-db"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v1"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = (known after apply)

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8snjpoq85qqv0mk9gi"
+ name        = (known after apply)
+ size        = (known after apply)
+ snapshot_id = (known after apply)
+ type        = "network-hdd"
}
}

+ metadata_options {
+ aws_v1_http_endpoint = (known after apply)
+ aws_v1_http_token    = (known after apply)
+ gce_http_endpoint    = (known after apply)
+ gce_http_token       = (known after apply)
}

+ network_interface {
+ index              = (known after apply)
+ ip_address         = (known after apply)
+ ipv4               = true
+ ipv6               = (known after apply)
+ ipv6_address       = (known after apply)
+ mac_address        = (known after apply)
+ nat                = true
+ nat_ip_address     = (known after apply)
+ nat_ip_version     = (known after apply)
+ security_group_ids = (known after apply)
+ subnet_id          = (known after apply)
}

+ placement_policy {
+ host_affinity_rules = (known after apply)
+ placement_group_id  = (known after apply)
}

+ resources {
+ core_fraction = 20
+ cores         = 2
+ memory        = 2
}

+ scheduling_policy {
+ preemptible = true
}
}

# yandex_compute_instance.platform will be created
+ resource "yandex_compute_instance" "platform" {
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = (known after apply)
+ id                        = (known after apply)
+ metadata                  = {
+ "serial-port-enable" = "1"
+ "ssh-keys"           = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "netology-develop-platform-web"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v1"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = (known after apply)

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8snjpoq85qqv0mk9gi"
+ name        = (known after apply)
+ size        = (known after apply)
+ snapshot_id = (known after apply)
+ type        = "network-hdd"
}
}

+ metadata_options {
+ aws_v1_http_endpoint = (known after apply)
+ aws_v1_http_token    = (known after apply)
+ gce_http_endpoint    = (known after apply)
+ gce_http_token       = (known after apply)
}

+ network_interface {
+ index              = (known after apply)
+ ip_address         = (known after apply)
+ ipv4               = true
+ ipv6               = (known after apply)
+ ipv6_address       = (known after apply)
+ mac_address        = (known after apply)
+ nat                = true
+ nat_ip_address     = (known after apply)
+ nat_ip_version     = (known after apply)
+ security_group_ids = (known after apply)
+ subnet_id          = (known after apply)
}

+ placement_policy {
+ host_affinity_rules = (known after apply)
+ placement_group_id  = (known after apply)
}

+ resources {
+ core_fraction = 5
+ cores         = 2
+ memory        = 1
}

+ scheduling_policy {
+ preemptible = true
}
}

# yandex_vpc_network.develop will be created
+ resource "yandex_vpc_network" "develop" {
+ created_at                = (known after apply)
+ default_security_group_id = (known after apply)
+ folder_id                 = (known after apply)
+ id                        = (known after apply)
+ labels                    = (known after apply)
+ name                      = "develop"
+ subnet_ids                = (known after apply)
}

# yandex_vpc_subnet.develop will be created
+ resource "yandex_vpc_subnet" "develop" {
+ created_at     = (known after apply)
+ folder_id      = (known after apply)
+ id             = (known after apply)
+ labels         = (known after apply)
+ name           = "develop"
+ network_id     = (known after apply)
+ v4_cidr_blocks = [
+ "10.0.1.0/24",
]
+ v6_cidr_blocks = (known after apply)
+ zone           = "ru-central1-a"
}

Plan: 4 to add, 0 to change, 0 to destroy.
```

</details>

<details>
<summary>Задание 4</summary>

1. Объявите в файле outputs.tf отдельные output, для каждой из ВМ с ее внешним IP адресом.
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```
  
</details>

#### Ответ:

```terraform
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/02/src$ terraform output
external_ip_address_netology-develop-platform-db_yandex_cloud = "158.160.55.187"
external_ip_address_platform_yandex_cloud = "51.250.70.247"
```

<details>
<summary>Задание 5</summary>

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию по примеру из лекции.
2. Замените переменные с именами ВМ из файла variables.tf на созданные вами local переменные.
3. Примените изменения.
  
</details>

#### Ответ:

<details>

```terraform
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/02/src$ terraform plan
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 0s [id=fd8snjpoq85qqv0mk9gi]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# yandex_compute_instance.netology-develop-platform-db will be created
+ resource "yandex_compute_instance" "netology-develop-platform-db" {
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = (known after apply)
+ id                        = (known after apply)
+ metadata                  = {
+ "serial-port-enable" = "1"
+ "ssh-keys"           = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "netology-develop-platform-db"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v1"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = (known after apply)

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8snjpoq85qqv0mk9gi"
+ name        = (known after apply)
+ size        = (known after apply)
+ snapshot_id = (known after apply)
+ type        = "network-hdd"
}
}

+ metadata_options {
+ aws_v1_http_endpoint = (known after apply)
+ aws_v1_http_token    = (known after apply)
+ gce_http_endpoint    = (known after apply)
+ gce_http_token       = (known after apply)
}

+ network_interface {
+ index              = (known after apply)
+ ip_address         = (known after apply)
+ ipv4               = true
+ ipv6               = (known after apply)
+ ipv6_address       = (known after apply)
+ mac_address        = (known after apply)
+ nat                = true
+ nat_ip_address     = (known after apply)
+ nat_ip_version     = (known after apply)
+ security_group_ids = (known after apply)
+ subnet_id          = (known after apply)
}

+ placement_policy {
+ host_affinity_rules = (known after apply)
+ placement_group_id  = (known after apply)
}

+ resources {
+ core_fraction = 20
+ cores         = 2
+ memory        = 2
}

+ scheduling_policy {
+ preemptible = true
}
}

# yandex_compute_instance.platform will be created
+ resource "yandex_compute_instance" "platform" {
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = (known after apply)
+ id                        = (known after apply)
+ metadata                  = {
+ "serial-port-enable" = "1"
+ "ssh-keys"           = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "netology-develop-platform-web"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v1"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = (known after apply)

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8snjpoq85qqv0mk9gi"
+ name        = (known after apply)
+ size        = (known after apply)
+ snapshot_id = (known after apply)
+ type        = "network-hdd"
}
}

+ metadata_options {
+ aws_v1_http_endpoint = (known after apply)
+ aws_v1_http_token    = (known after apply)
+ gce_http_endpoint    = (known after apply)
+ gce_http_token       = (known after apply)
}

+ network_interface {
+ index              = (known after apply)
+ ip_address         = (known after apply)
+ ipv4               = true
+ ipv6               = (known after apply)
+ ipv6_address       = (known after apply)
+ mac_address        = (known after apply)
+ nat                = true
+ nat_ip_address     = (known after apply)
+ nat_ip_version     = (known after apply)
+ security_group_ids = (known after apply)
+ subnet_id          = (known after apply)
}

+ placement_policy {
+ host_affinity_rules = (known after apply)
+ placement_group_id  = (known after apply)
}

+ resources {
+ core_fraction = 5
+ cores         = 2
+ memory        = 1
}

+ scheduling_policy {
+ preemptible = true
}
}

# yandex_vpc_network.develop will be created
+ resource "yandex_vpc_network" "develop" {
+ created_at                = (known after apply)
+ default_security_group_id = (known after apply)
+ folder_id                 = (known after apply)
+ id                        = (known after apply)
+ labels                    = (known after apply)
+ name                      = "develop"
+ subnet_ids                = (known after apply)
}

# yandex_vpc_subnet.develop will be created
+ resource "yandex_vpc_subnet" "develop" {
+ created_at     = (known after apply)
+ folder_id      = (known after apply)
+ id             = (known after apply)
+ labels         = (known after apply)
+ name           = "develop"
+ network_id     = (known after apply)
+ v4_cidr_blocks = [
+ "10.0.1.0/24",
]
+ v6_cidr_blocks = (known after apply)
+ zone           = "ru-central1-a"
}

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
+ external_ip_address_netology-develop-platform-db_yandex_cloud = (known after apply)
+ external_ip_address_platform_yandex_cloud                     = (known after apply)
```

</details>

<details>
<summary>Задание 6</summary>

1. Вместо использования 3-х переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедените их в переменные типа **map** с именами "vm_web_resources" и "vm_db_resources".
2. Так же поступите с блоком **metadata {serial-port-enable, ssh-keys}**, эта переменная должна быть общая для всех ваших ВМ.
3. Найдите и удалите все более не используемые переменные проекта.
4. Проверьте terraform plan (изменений быть не должно).
  
</details>

#### Ответ:

<details>
  
```terraform
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/02/src$ terraform plan
data.yandex_compute_image.ubuntu: Reading...
data.yandex_compute_image.ubuntu: Read complete after 0s [id=fd8snjpoq85qqv0mk9gi]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# yandex_compute_instance.netology-develop-platform-db will be created
+ resource "yandex_compute_instance" "netology-develop-platform-db" {
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = (known after apply)
+ id                        = (known after apply)
+ metadata                  = {
+ "serial-port-enable" = "true"
+ "ssh-keys"           = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "netology-develop-platform-db"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v1"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = (known after apply)

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8snjpoq85qqv0mk9gi"
+ name        = (known after apply)
+ size        = (known after apply)
+ snapshot_id = (known after apply)
+ type        = "network-hdd"
}
}

+ metadata_options {
+ aws_v1_http_endpoint = (known after apply)
+ aws_v1_http_token    = (known after apply)
+ gce_http_endpoint    = (known after apply)
+ gce_http_token       = (known after apply)
}

+ network_interface {
+ index              = (known after apply)
+ ip_address         = (known after apply)
+ ipv4               = true
+ ipv6               = (known after apply)
+ ipv6_address       = (known after apply)
+ mac_address        = (known after apply)
+ nat                = true
+ nat_ip_address     = (known after apply)
+ nat_ip_version     = (known after apply)
+ security_group_ids = (known after apply)
+ subnet_id          = (known after apply)
}

+ placement_policy {
+ host_affinity_rules = (known after apply)
+ placement_group_id  = (known after apply)
}

+ resources {
+ core_fraction = 20
+ cores         = 2
+ memory        = 2
}

+ scheduling_policy {
+ preemptible = true
}
}

# yandex_compute_instance.platform will be created
+ resource "yandex_compute_instance" "platform" {
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = (known after apply)
+ id                        = (known after apply)
+ metadata                  = {
+ "serial-port-enable" = "true"
+ "ssh-keys"           = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "netology-develop-platform-web"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v1"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = (known after apply)

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8snjpoq85qqv0mk9gi"
+ name        = (known after apply)
+ size        = (known after apply)
+ snapshot_id = (known after apply)
+ type        = "network-hdd"
}
}

+ metadata_options {
+ aws_v1_http_endpoint = (known after apply)
+ aws_v1_http_token    = (known after apply)
+ gce_http_endpoint    = (known after apply)
+ gce_http_token       = (known after apply)
}

+ network_interface {
+ index              = (known after apply)
+ ip_address         = (known after apply)
+ ipv4               = true
+ ipv6               = (known after apply)
+ ipv6_address       = (known after apply)
+ mac_address        = (known after apply)
+ nat                = true
+ nat_ip_address     = (known after apply)
+ nat_ip_version     = (known after apply)
+ security_group_ids = (known after apply)
+ subnet_id          = (known after apply)
}

+ placement_policy {
+ host_affinity_rules = (known after apply)
+ placement_group_id  = (known after apply)
}

+ resources {
+ core_fraction = 5
+ cores         = 2
+ memory        = 1
}

+ scheduling_policy {
+ preemptible = true
}
}

# yandex_vpc_network.develop will be created
+ resource "yandex_vpc_network" "develop" {
+ created_at                = (known after apply)
+ default_security_group_id = (known after apply)
+ folder_id                 = (known after apply)
+ id                        = (known after apply)
+ labels                    = (known after apply)
+ name                      = "develop"
+ subnet_ids                = (known after apply)
}

# yandex_vpc_subnet.develop will be created
+ resource "yandex_vpc_subnet" "develop" {
+ created_at     = (known after apply)
+ folder_id      = (known after apply)
+ id             = (known after apply)
+ labels         = (known after apply)
+ name           = "develop"
+ network_id     = (known after apply)
+ v4_cidr_blocks = [
+ "10.0.1.0/24",
]
+ v6_cidr_blocks = (known after apply)
+ zone           = "ru-central1-a"
}

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
+ external_ip_address_netology-develop-platform-db_yandex_cloud = (known after apply)
+ external_ip_address_platform_yandex_cloud                     = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run
"terraform apply" now.
```
</details>

<details>
<summary>Задание 7*</summary>

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list?
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map ?
4. Напишите interpolation выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

В качестве решения предоставьте необходимые команды и их вывод.
  
</details>

#### Ответ:

1.
  
```terraform
  > local.test_list[1]
"staging"
```
2.
  
```terraform
  > length(local.test_list)
3
```
  
 3. 

```terraform
 > local.test_map.admin
"John"
>
```
  
4.
  
```terraform
 > local.test_map.admin
"John"
>
```
  
5. 
  
```terraform
> "${local.test_map.admin} is admin for ${local.test_list[2]} based on OS ${local.servers.stage.image} with ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks"
> "John is admin for production based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 virtual disks"
```
  
[Файлы домашнего задания](https://github.com/vanechaev/study/tree/main/virt-23/Terraform/files/02)
