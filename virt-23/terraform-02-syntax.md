## Домашнее задание к занятию 2. «Облачные провайдеры и синтаксис Terraform» - Нечаев Владимир

<details>
<summary>Задача 1 (вариант с AWS). Регистрация в AWS и знакомство с основами (не обязательно, но крайне желательно)</summary>
  
> Остальные задания можно будет выполнять и без этого аккаунта, но с ним можно будет увидеть полный цикл процессов. 
>
> AWS предоставляет много бесплатных ресурсов в первый год после регистрации, подробно описано [здесь](https://aws.amazon.com/free/).
>
> 1. Создайте аккаунт AWS.
> 1. Установите c [aws-cli](https://aws.amazon.com/cli/).
> 1. Выполните первичную [настройку aws-sli](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).
> 1. Создайте IAM-политику для Terraform c правами:
>    * AmazonEC2FullAccess,
>    * AmazonS3FullAccess,
>    * AmazonDynamoDBFullAccess,
>    * AmazonRDSFullAccess,
>    * CloudWatchFullAccess,
>    * IAMFullAccess.
> 1. Добавьте переменные окружения
>    ```
>    export AWS_ACCESS_KEY_ID=(your access key id)
>    export AWS_SECRET_ACCESS_KEY=(your secret access key).
>    ```
>1. Создайте, остановите и удалите ec2-инстанс (любой с пометкой `free tier`) через веб-интерфейс. 
>
> В виде результата задания приложите вывод команды `aws configure list`.
  
</details>

#### Ответ:

Регистрация не доступна

![Регистрация не доступна](https://github.com/vanechaev/study/blob/db809b127bcf6ddf556225156c2cf93820be570a/virt-23/img/aws-block.png)

<details>
<summary>Задача 1 (вариант с Yandex.Cloud). Регистрация в Яндекс Облаке и знакомство с основами (не обязательно, но крайне желательно)</summary>
  
> 1. Подробная инструкция на русском языке лежит [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).
> 2. Обратите внимание на период бесплатного использования после регистрации аккаунта. 
> 3. Используйте раздел «Подготовьте облако к работе» для регистрации аккаунта. Далее раздел «Настройте провайдер» для подготовки
> базового Terraform-конфига.
> 4. Воспользуйтесь [инструкцией](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) на сайте Terraform, чтобы 
> не указывать авторизационный токен в коде, а Terraform-провайдер брал его из переменных окружений.
  
</details>

#### Ответ:

Уже давно сделано и настроено.

![yacloud](https://github.com/vanechaev/study/blob/ac36864f3056da92827c979b5b892f3a9bb0942d/virt-23/img/yandex_account.png)


<details>
<summary>Задача 2. Создание AWS ec2 или yandex _compute _instance через Terraform</summary>
  
> 1. В каталоге `Terraform` вашего основного репозитория, который был создан в начале курсе, создайте файл `main.tf` и `versions.tf`.
> 2. Зарегистрируйте провайдер:
>
>   1. Для [AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs). В файл `main.tf` добавьте
>   блок `provider`, а в `versions.tf` блок `Terraform` с вложенным блоком `required_providers`. Укажите любой выбранный вами регион 
>   внутри блока `provider`.
>
> либо
>
>   2. Для [Yandex.Cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs). Подробную инструкцию можно найти 
>   [здесь](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart).
> 3. Внимание. В git-репозиторий нельзя пушить ваши личные ключи доступа к аккаунту. Поэтому в предыдущем задании мы указывали
> их в виде переменных окружения. 
> 4. В файле `main.tf` воспользуйтесь блоком `data "aws_ami` для поиска ami-образа последнего Ubuntu.  
> 5. В файле `main.tf` создайте ресурс 
>   1. либо [ec2 instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance).
>   Постарайтесь указать как можно больше параметров для его определения. Минимальный набор параметров указан в первом блоке 
>   `Example Usage`, но желательно указать большее количество параметров.
>   2. либо [yandex _compute _image](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_image).
> 6. Также в случае использования AWS:
>   1. Добавьте data-блоки `aws_caller_identity` и `aws_region`.
>   2. В файл `outputs.tf` поместите блоки `output` с данными об используемых в данный момент: 
>       * AWS account ID;
>       * AWS user ID;
>       * AWS регион, который используется сейчас;
>       * Приватный IP ec2-инстансы;
>       * Идентификатор подсети, в которой создан инстанс.  
> 7. Если вы выполнили первый пункт, то добейтесь того, что бы команда `terraform plan` выполнялась без ошибок. 
>
>
> В качестве результата задания предоставьте:
>
> 1. Ответ на вопрос, при помощи какого инструмента из разобранных на прошлом занятии можно создать свой образ ami.
> 1. Ссылку на репозиторий с исходной конфигурацией Terraform.  
  
</details>

#### Ответ:

> 1. Ответ на вопрос, при помощи какого инструмента из разобранных на прошлом занятии можно создать свой образ ami.

- `Packer`

> 1. Ссылку на репозиторий с исходной конфигурацией Terraform.  

[Configuration](https://github.com/vanechaev/study/tree/main/GIT-FOPS-3/Terraform)

<details>

  ```bash
  nva@Lenovo-G50-80:~/terraform/less07-02$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of yandex-cloud/yandex from the dependency lock file
- Using previously-installed yandex-cloud/yandex v0.87.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
nva@Lenovo-G50-80:~/terraform/less07-02$ terraform validate
╷
│ Error: Reference to undeclared resource
│ 
│   on output.tf line 2, in output "internal_ip_address_node01_yandex_cloud":
│    2:   value = "${yandex_compute_instance.node01.network_interface.0.ip_address}"
│ 
│ A managed resource "yandex_compute_instance" "node01" has not been declared in the root module.
╵
╷
│ Error: Reference to undeclared resource
│ 
│   on output.tf line 6, in output "external_ip_address_node01_yandex_cloud":
│    6:   value = "${yandex_compute_instance.node01.network_interface.0.nat_ip_address}"
│ 
│ A managed resource "yandex_compute_instance" "node01" has not been declared in the root module.
╵
nva@Lenovo-G50-80:~/terraform/less07-02$ terraform validate
Success! The configuration is valid.

nva@Lenovo-G50-80:~/terraform/less07-02$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# yandex_compute_instance.vm1 will be created
+ resource "yandex_compute_instance" "vm1" {
+ allow_stopping_for_update = true
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = "vm1.netology.cloud"
+ id                        = (known after apply)
+ metadata                  = {
+ "ssh-keys" = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "vm1"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v3"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = "ru-central1-a"

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8emvfmfoaordspe1jr"
+ name        = "root-node01"
+ size        = 20
+ snapshot_id = (known after apply)
+ type        = "network-nvme"
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
+ memory        = 4
}

+ scheduling_policy {
+ preemptible = (known after apply)
}
}

# yandex_vpc_network.default will be created
+ resource "yandex_vpc_network" "default" {
+ created_at                = (known after apply)
+ default_security_group_id = (known after apply)
+ folder_id                 = (known after apply)
+ id                        = (known after apply)
+ labels                    = (known after apply)
+ name                      = "net"
+ subnet_ids                = (known after apply)
}

# yandex_vpc_subnet.default will be created
+ resource "yandex_vpc_subnet" "default" {
+ created_at     = (known after apply)
+ folder_id      = (known after apply)
+ id             = (known after apply)
+ labels         = (known after apply)
+ name           = "subnet"
+ network_id     = (known after apply)
+ v4_cidr_blocks = [
+ "192.168.88.0/24",
]
+ v6_cidr_blocks = (known after apply)
+ zone           = "ru-central1-a"
}

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
+ external_ip_address_node01_yandex_cloud = (known after apply)
+ internal_ip_address_node01_yandex_cloud = (known after apply)

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run
"terraform apply" now.
nva@Lenovo-G50-80:~/terraform/less07-02$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# yandex_compute_instance.vm1 will be created
+ resource "yandex_compute_instance" "vm1" {
+ allow_stopping_for_update = true
+ created_at                = (known after apply)
+ folder_id                 = (known after apply)
+ fqdn                      = (known after apply)
+ hostname                  = "vm1.netology.cloud"
+ id                        = (known after apply)
+ metadata                  = {
+ "ssh-keys" = <<-EOT
ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
EOT
}
+ name                      = "vm1"
+ network_acceleration_type = "standard"
+ platform_id               = "standard-v3"
+ service_account_id        = (known after apply)
+ status                    = (known after apply)
+ zone                      = "ru-central1-a"

+ boot_disk {
+ auto_delete = true
+ device_name = (known after apply)
+ disk_id     = (known after apply)
+ mode        = (known after apply)

+ initialize_params {
+ block_size  = (known after apply)
+ description = (known after apply)
+ image_id    = "fd8emvfmfoaordspe1jr"
+ name        = "root-node01"
+ size        = 20
+ snapshot_id = (known after apply)
+ type        = "network-nvme"
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
+ memory        = 4
}

+ scheduling_policy {
+ preemptible = (known after apply)
}
}

# yandex_vpc_network.default will be created
+ resource "yandex_vpc_network" "default" {
+ created_at                = (known after apply)
+ default_security_group_id = (known after apply)
+ folder_id                 = (known after apply)
+ id                        = (known after apply)
+ labels                    = (known after apply)
+ name                      = "net"
+ subnet_ids                = (known after apply)
}

# yandex_vpc_subnet.default will be created
+ resource "yandex_vpc_subnet" "default" {
+ created_at     = (known after apply)
+ folder_id      = (known after apply)
+ id             = (known after apply)
+ labels         = (known after apply)
+ name           = "subnet"
+ network_id     = (known after apply)
+ v4_cidr_blocks = [
+ "192.168.88.0/24",
]
+ v6_cidr_blocks = (known after apply)
+ zone           = "ru-central1-a"
}

Plan: 3 to add, 0 to change, 0 to destroy.

Changes to Outputs:
+ external_ip_address_node01_yandex_cloud = (known after apply)
+ internal_ip_address_node01_yandex_cloud = (known after apply)

Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.

Enter a value: yes

yandex_vpc_network.default: Creating...
yandex_vpc_network.default: Creation complete after 2s [id=enpnbmknbgjmpq6v4ohg]
yandex_vpc_subnet.default: Creating...
yandex_vpc_subnet.default: Creation complete after 1s [id=e9blf5mjldt85nnpgbe0]
yandex_compute_instance.vm1: Creating...
yandex_compute_instance.vm1: Still creating... [10s elapsed]
yandex_compute_instance.vm1: Still creating... [20s elapsed]
yandex_compute_instance.vm1: Still creating... [30s elapsed]
yandex_compute_instance.vm1: Still creating... [40s elapsed]
yandex_compute_instance.vm1: Creation complete after 41s [id=fhmvnlqcdpnr5mn9movi]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

Outputs:

external_ip_address_node01_yandex_cloud = "158.160.55.189"
internal_ip_address_node01_yandex_cloud = "192.168.88.30"
nva@Lenovo-G50-80:~/terraform/less07-02$ terraform destroy
  ```
  
  Работающая ВМ
  
  ![Работающая ВМ](https://github.com/vanechaev/study/blob/cc7d81772e8f510af93b4066ee85dd848fd0c04e/GIT-FOPS-3/Terraform/yandex_vm1.png)
  
</details>
