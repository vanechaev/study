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

