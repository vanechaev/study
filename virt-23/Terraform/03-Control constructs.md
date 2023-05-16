## Домашнее задание к занятию "Управляющие конструкции в коде Terraform" - Нечаев Владимир

<details>
<summary>Задание 1</summary>

1. Изучите проект.
2. Заполните файл personal.auto.tfvars
3. Инициализируйте проект, выполните код (он выполнится даже если доступа к preview нет).

Примечание: Если у вас не активирован preview доступ к функционалу "Группы безопасности" в Yandex Cloud - запросите доступ у поддержки облачного провайдера. Обычно его выдают в течении 24-х часов.

Приложите скриншот входящих правил "Группы безопасности" в ЛК Yandex Cloud  или скриншот отказа в предоставлении доступа к preview версии.

------
  
</details>

#### Ответ:

<details>
  
```terraform
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/03/src$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
+ create

Terraform will perform the following actions:

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

# yandex_vpc_security_group.example will be created
+ resource "yandex_vpc_security_group" "example" {
+ created_at = (known after apply)
+ folder_id  = "b1g012f6rgs30ucfn1kd"
+ id         = (known after apply)
+ labels     = (known after apply)
+ name       = "example_dynamic"
+ network_id = (known after apply)
+ status     = (known after apply)

+ egress {
+ description    = "разрешить весь исходящий трафик"
+ from_port      = 0
+ id             = (known after apply)
+ labels         = (known after apply)
+ port           = -1
+ protocol       = "TCP"
+ to_port        = 65365
+ v4_cidr_blocks = [
+ "0.0.0.0/0",
]
+ v6_cidr_blocks = []
}

+ ingress {
+ description    = "разрешить входящий  http"
+ from_port      = -1
+ id             = (known after apply)
+ labels         = (known after apply)
+ port           = 80
+ protocol       = "TCP"
+ to_port        = -1
+ v4_cidr_blocks = [
+ "0.0.0.0/0",
]
+ v6_cidr_blocks = []
}
+ ingress {
+ description    = "разрешить входящий https"
+ from_port      = -1
+ id             = (known after apply)
+ labels         = (known after apply)
+ port           = 443
+ protocol       = "TCP"
+ to_port        = -1
+ v4_cidr_blocks = [
+ "0.0.0.0/0",
]
+ v6_cidr_blocks = []
}
+ ingress {
+ description    = "разрешить входящий ssh"
+ from_port      = -1
+ id             = (known after apply)
+ labels         = (known after apply)
+ port           = 22
+ protocol       = "TCP"
+ to_port        = -1
+ v4_cidr_blocks = [
+ "0.0.0.0/0",
]
+ v6_cidr_blocks = []
}
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

Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.

Enter a value: yes

yandex_vpc_network.develop: Creating...
yandex_vpc_network.develop: Creation complete after 1s [id=enpic5261sookhe72u09]
yandex_vpc_subnet.develop: Creating...
yandex_vpc_security_group.example: Creating...
yandex_vpc_subnet.develop: Creation complete after 1s [id=e9bbj8iahv11l47gbdt9]
yandex_vpc_security_group.example: Creation complete after 1s [id=enp1hk143kfs1duiv56r]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

 </details>

![](https://github.com/vanechaev/study/blob/terraform-03/virt-23/Terraform/img/zadanie_3-1.png)  
  
<details>
<summary>Задание 2</summary>

1. Создайте файл count-vm.tf. Опишите в нем создание двух **одинаковых** виртуальных машин с минимальными параметрами, используя мета-аргумент **count loop**.
2. Создайте файл for_each-vm.tf. Опишите в нем создание 2 **разных** по cpu/ram/disk виртуальных машин, используя мета-аргумент **for_each loop**. Используйте переменную типа list(object({ vm_name=string, cpu=number, ram=number, disk=number  })). При желании внесите в переменную все возможные параметры.
3. ВМ из пункта 2.2 должны создаваться после создания ВМ из пункта 2.1.
4. Используйте функцию file в local переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ №2.
5. Инициализируйте проект, выполните код.

------
  
</details>

#### Ответ:

count-vm.tf

```terraform
resource "yandex_compute_instance" "example" {
  name        = "netology-develop-platform-web-${count.index}"
  platform_id = "standard-v1"

  count = 2

  resources {
    cores  = 2
    memory = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = 5
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}
```

for_each-vm.tf

```terraform
resource "yandex_compute_instance" "vm" {
  for_each = {for vm in var.vm: vm.name => vm}

  name = "${each.value.name}"
  platform_id = "standard-v1"

  resources {
    cores  = "${each.value.cpu}"
    memory = "${each.value.ram}"
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = "${each.value.disk}"
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key)}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}
```

![](https://github.com/vanechaev/study/blob/terraform-03/virt-23/Terraform/img/zadanie_3-2.png)

<details>
<summary>Задание 3</summary>

1. Создайте 3 одинаковых виртуальных диска, размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count.
2. Создайте одну **любую** ВМ. Используйте блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных вами дополнительных дисков.
3. Назначьте ВМ созданную в 1-м задании группу безопасности.

------

</details>

#### Ответ:

![](https://github.com/vanechaev/study/blob/terraform-03/virt-23/img/task3-3.png)

<details>
  
  ```terraform
  [nva@localhost dz]$ terraform apply 
data.yandex_compute_image.ubuntu: Reading...
yandex_vpc_network.develop: Refreshing state... [id=enpmt84j4vh0ev8928d0]
data.yandex_compute_image.ubuntu: Read complete after 0s [id=fd8gfg42q4551cvt340b]
yandex_vpc_subnet.develop: Refreshing state... [id=e9bbopkdj9l0u1si18a5]
yandex_vpc_security_group.example: Refreshing state... [id=enp47ekpe500b0e5abgo]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # yandex_compute_disk.virtual_disk[0] will be created
  + resource "yandex_compute_disk" "virtual_disk" {
      + block_size  = 4096
      + created_at  = (known after apply)
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + name        = "virtual-disk0"
      + product_ids = (known after apply)
      + size        = 1
      + status      = (known after apply)
      + type        = "network-hdd"
      + zone        = (known after apply)
    }

  # yandex_compute_disk.virtual_disk[1] will be created
  + resource "yandex_compute_disk" "virtual_disk" {
      + block_size  = 4096
      + created_at  = (known after apply)
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + name        = "virtual-disk1"
      + product_ids = (known after apply)
      + size        = 1
      + status      = (known after apply)
      + type        = "network-hdd"
      + zone        = (known after apply)
    }

  # yandex_compute_disk.virtual_disk[2] will be created
  + resource "yandex_compute_disk" "virtual_disk" {
      + block_size  = 4096
      + created_at  = (known after apply)
      + folder_id   = (known after apply)
      + id          = (known after apply)
      + name        = "virtual-disk2"
      + product_ids = (known after apply)
      + size        = 1
      + status      = (known after apply)
      + type        = "network-hdd"
      + zone        = (known after apply)
    }

  # yandex_compute_instance.example[0] will be created
  + resource "yandex_compute_instance" "example" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + gpu_cluster_id            = (known after apply)
      + hostname                  = (known after apply)
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDM0Vr4rfdR+ttUJjTS+OoAp6exahkQ+9V+BQCL5/+tG0WLWZL4PKPFKTOl7STftoqYmXE3xGDj3T+tAZKtdPLhrYPxDjd7S/qoIRmEWbxMkSFRolJoyxMnzpPCYgRIr5RENpcaKWsY5Ty/cH5GNRw1Wxuqg5bSzMMmW7a51reKtSCQ/PhqxXgxgnEgSlf5rxnBekJo/Z9APtAq1WFG2IMg0eE2T9mibrn7LxBIasKMKf15K7+evDhTTG+1jRSBfqnJzErLNmgcpmv6hvxbFtGIDn/O+VQeA4s5XfGSLU3uiBXdjrKeC8N5QZA0Q3VSOYuhKTM3XkZD1Oo0F3v3gEntXyG6SiZqcDuSATms4UprbgZLI0KYTgVT0fXq6k6fMOP69AY400s/zIIoncKUSX1Za+s//n0hfenxfndz4xJyAgctmDZ9JBDTa3fkaKZ43Mpz4QTIIE/Zh7jpxKr1gaefteWhE8L1vpbNtUZLYZpMFXdB9ul7NDywTcD8YPMWWPE= nva@Lenovo-G50-80
            EOT
        }
      + name                      = "netology-develop-platform-web-0"
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
              + image_id    = "fd8gfg42q4551cvt340b"
              + name        = "first"
              + size        = 5
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
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
          + subnet_id          = "e9bbopkdj9l0u1si18a5"
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

      + scheduling_policy {
          + preemptible = true
        }

      + secondary_disk {
          + auto_delete = false
          + device_name = "virtual-disk0"
          + disk_id     = (known after apply)
          + mode        = "READ_WRITE"
        }
      + secondary_disk {
          + auto_delete = false
          + device_name = "virtual-disk1"
          + disk_id     = (known after apply)
          + mode        = "READ_WRITE"
        }
      + secondary_disk {
          + auto_delete = false
          + device_name = "virtual-disk2"
          + disk_id     = (known after apply)
          + mode        = "READ_WRITE"
        }
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_compute_disk.virtual_disk[2]: Creating...
yandex_compute_disk.virtual_disk[0]: Creating...
yandex_compute_disk.virtual_disk[1]: Creating...
yandex_compute_disk.virtual_disk[1]: Creation complete after 7s [id=fhm8fs2kuodiav2uk65m]
yandex_compute_disk.virtual_disk[2]: Creation complete after 9s [id=fhmtfdjqtifvnnkn2rfb]
yandex_compute_disk.virtual_disk[0]: Creation complete after 10s [id=fhmqj2a1nssa1m5mrh5k]
yandex_compute_instance.example[0]: Creating...
yandex_compute_instance.example[0]: Still creating... [10s elapsed]
yandex_compute_instance.example[0]: Still creating... [20s elapsed]
yandex_compute_instance.example[0]: Still creating... [30s elapsed]
yandex_compute_instance.example[0]: Creation complete after 34s [id=fhm55vl9o2s1tk39o62b]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed
```
</details>

3. Назначьте ВМ созданную в 1-м задании группу безопасности.
```bash
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
```

<details>
<summary>Задание 4</summary>

1. Создайте inventory-файл для ansible.
Используйте функцию tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
Готовый код возьмите из демонстрации к лекции [**demonstration2**](https://github.com/netology-code/ter-homeworks/tree/main/demonstration2).
Передайте в него в качестве переменных имена и внешние ip-адреса ВМ из задания 2.1 и 2.2.
2. Выполните код. Приложите скриншот получившегося файла.
  
</details>

#### Ответ:

1. Сам код:

```terraform
resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers  = yandex_compute_instance.example
      webservers1 = yandex_compute_instance.vm
    }
  )
  filename = "${abspath(path.module)}/hosts.cfg"
}
```
2. Вывод файла:

```bash
...
Apply complete! Resources: 10 added, 0 changed, 0 destroyed.
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/03/src$ cat hosts.cfg 
[webservers]

netology-develop-platform-web-0   ansible_host=62.84.116.253
vm1   ansible_host=158.160.53.114
vm2   ansible_host=51.250.8.103
```
