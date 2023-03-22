## Домашнее задание к занятию "Введение в Terraform" - Нечаев Владимир

<details>
<summary>Задание 1</summary>

> 1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). 
  Скачайте все необходимые зависимости, использованные в проекте. 
> 2. Изучите файл **.gitignore**. В каком terraform файле допустимо сохранить личную, секретную информацию?
> 3. Выполните код проекта. Найдите  в State-файле секретное содержимое созданного ресурса **random_password**. Пришлите его в качестве ответа.
> 4. Раскомментируйте блок кода, примерно расположенный на строчках 29-42 файла **main.tf**.
> Выполните команду ```terraform -validate```. Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.
> 5. Выполните код. В качестве ответа приложите вывод команды ```docker ps```
> 6. Замените имя docker-контейнера в блоке кода на ```hello_world```, выполните команду ```terraform apply -auto-approve```.
> Объясните своими словами, в чем может быть опасность применения ключа  ```-auto-approve``` ? 
> 7. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
> 8. Объясните, почему при этом не был удален docker образ **nginx:latest** ?(Ответ найдите в коде проекта или документации)
  
  </details>

#### Ответ:

> 2. Изучите файл **.gitignore**. В каком terraform файле допустимо сохранить личную, секретную информацию?

`*.auto.tfvars` — позволяет именовать файлы с переменными (в том числе секретными). Если именно **.gitignore** то - `personal.auto.tfvars`

> 3. Выполните код проекта. Найдите  в State-файле секретное содержимое созданного ресурса **random_password**. Пришлите его в качестве ответа.

`"GHfrUAseEymbIB1v"`

> 4. ... Объясните в чем заключаются намеренно допущенные ошибки? Исправьте их.

1. не было образа
2. не было имени `resource "docker_image"`
3. неправильное имя `resource "docker_container"`

<details>

```bash
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ terraform validate
╷
│ Error: Missing name for resource
│ 
│   on main.tf line 24, in resource "docker_image":
│   24: resource "docker_image" {
│ 
│ All resource blocks must have 2 labels (type, name).
╵
╷
│ Error: Invalid resource name
│ 
│   on main.tf line 29, in resource "docker_container" "1nginx":
│   29: resource "docker_container" "1nginx" {
│ 
│ A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.
╵
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ docker images
REPOSITORY                   TAG       IMAGE ID       CREATED         SIZE
vanechaev/elastic8_cntos_7   3.0.3     3e81978af46b   2 days ago      2.84GB
vanechaev/elastic8_centos7   0.1       41d0e6b972cd   2 days ago      2.64GB
vanechaev/elastic8_centos7   0.4       41d0e6b972cd   2 days ago      2.64GB
vanechaev/elastic8_centos7   0.3       fd4a732d8540   2 days ago      2.64GB
vanechaev/elastic8_centos7   0.2       7aeb1ec04658   2 days ago      2.64GB
vanechaev/elastic8_cntos_7   3.0.2     172a44df4943   2 days ago      2.84GB
vanechaev/elastic8_cntos_7   3.0.1     dfcb6272cc63   2 days ago      2.84GB
postgres                     13        6a3d8bd95dca   5 weeks ago     374MB
debian                       latest    5c8936e57a38   2 months ago    124MB
alpine                       3.14      dd53f409bf0b   7 months ago    5.61MB
hello-world                  latest    feb5d9fea6a5   18 months ago   13.3kB
centos                       7         eeb6ee3f44bd   18 months ago   204MB
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ docker pull nginx
Using default tag: latest
latest: Pulling from library/nginx
3f9582a2cbe7: Pull complete 
9a8c6f286718: Pull complete 
e81b85700bc2: Pull complete 
73ae4d451120: Pull complete 
6058e3569a68: Pull complete 
3a1b8f201356: Pull complete 
Digest: sha256:aa0afebbb3cfa473099a62c4b32e9b3fb73ed23f2a75a65ce1d4b4f55a5c2ef2
Status: Downloaded newer image for nginx:latest
docker.io/library/nginx:latest
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ terraform validate
╷
│ Error: Missing name for resource
│ 
│   on main.tf line 24, in resource "docker_image":
│   24: resource "docker_image" {
│ 
│ All resource blocks must have 2 labels (type, name).
╵
╷
│ Error: Invalid resource name
│ 
│   on main.tf line 29, in resource "docker_container" "1nginx":
│   29: resource "docker_container" "1nginx" {
│ 
│ A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.
╵
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ terraform init
There are some problems with the configuration, described below.

The Terraform configuration must be valid before initialization so that
Terraform can determine which modules and providers need to be installed.
╷
│ Error: Missing name for resource
│ 
│ On main.tf line 24: All resource blocks must have 2 labels (type, name).
╵

nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ docker images
REPOSITORY                   TAG       IMAGE ID       CREATED         SIZE
vanechaev/elastic8_cntos_7   3.0.3     3e81978af46b   2 days ago      2.84GB
vanechaev/elastic8_centos7   0.1       41d0e6b972cd   2 days ago      2.64GB
vanechaev/elastic8_centos7   0.4       41d0e6b972cd   2 days ago      2.64GB
vanechaev/elastic8_centos7   0.3       fd4a732d8540   2 days ago      2.64GB
vanechaev/elastic8_centos7   0.2       7aeb1ec04658   2 days ago      2.64GB
vanechaev/elastic8_cntos_7   3.0.2     172a44df4943   2 days ago      2.84GB
vanechaev/elastic8_cntos_7   3.0.1     dfcb6272cc63   2 days ago      2.84GB
nginx                        latest    904b8cb13b93   2 weeks ago     142MB
postgres                     13        6a3d8bd95dca   5 weeks ago     374MB
debian                       latest    5c8936e57a38   2 months ago    124MB
alpine                       3.14      dd53f409bf0b   7 months ago    5.61MB
hello-world                  latest    feb5d9fea6a5   18 months ago   13.3kB
centos                       7         eeb6ee3f44bd   18 months ago   204MB
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ ^C
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ terraform init
There are some problems with the configuration, described below.

The Terraform configuration must be valid before initialization so that
Terraform can determine which modules and providers need to be installed.
╷
│ Error: Invalid resource name
│
│   on main.tf line 29, in resource "docker_container" "1nginx":
│   29: resource "docker_container" "1nginx" {
│
│ A name must start with a letter or underscore and may contain only letters, digits, underscores, and dashes.
╵

nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ terraform init

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of kreuzwerker/docker from the dependency lock file
- Reusing previous version of hashicorp/random from the dependency lock file
- Using previously-installed kreuzwerker/docker v3.0.2
- Using previously-installed hashicorp/random v3.4.3

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ terraform validate
Success! The configuration is valid.
```

</details>
 
> 5. Выполните код. В качестве ответа приложите вывод команды ```docker ps```

```bash
docker_image.nginx: Creating...
random_password.random_string: Creating...
docker_image.nginx: Creation complete after 0s [id=sha256:904b8cb13b932e23230836850610fa45dce9eb0650d5618c2b1487c2a4f577b8nginx:latest]
random_password.random_string: Creation complete after 0s [id=none]
docker_container.nginx: Creating...
docker_container.nginx: Creation complete after 1s [id=1739c283d4c9e7d66eb14c8cb9446345a15d9cad109f6984d78d4e12bb860faa]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS         PORTS                  NAMES
1739c283d4c9   904b8cb13b93   "/docker-entrypoint.…"   11 seconds ago   Up 9 seconds   0.0.0.0:8000->80/tcp   example_yJKvRrfEiyfkX5z2
```

> 6. ... Объясните своими словами, в чем может быть опасность применения ключа  ```-auto-approve``` ? 

`-auto-approve` - пропускает интерактивное одобрение перед удалением. Соответственно мы никак не можем повлиять на выполнение, в отличии от обычного `terraform apply`

> 7. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 

```terraform
{
  "version": 4,
  "terraform_version": "1.3.7",
  "serial": 17,
  "lineage": "5031ef30-dcd2-f7c7-7c5d-867d3f190e93",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

> 8. Объясните, почему при этом не был удален docker образ **nginx:latest** ?(Ответ найдите в коде проекта или документации)

Так я же его сам скачивал, терраформ ругался что нет образа и сам его не закачивал, соответственно и не удалил. )))

***Дополнение:*** Потому-что описан параметр `keep_locally = true`

<details>
<summary>Задание 2*</summary>
  
> 1. Изучите в документации provider [**Virtualbox**](https://registry.tfpla.net/providers/shekeriev/virtualbox/latest/docs/overview/index) от 
> shekeriev.
> 2. Создайте с его помощью любую виртуальную машину.
>
> В качестве ответа приложите plan для создаваемого ресурса.

  
  </details>

#### Ответ:

```bash
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src/vb$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the
following symbols:
+ create

Terraform will perform the following actions:

# virtualbox_vm.vm1 will be created
+ resource "virtualbox_vm" "vm1" {
+ cpus   = 1
+ id     = (known after apply)
+ image  = "https://app.vagrantup.com/shekeriev/boxes/debian-11/versions/0.2/providers/virtualbox.box"
+ memory = "512 mib"
+ name   = "debian-11"
+ status = "running"

+ network_adapter {
+ device                 = "IntelPro1000MTDesktop"
+ host_interface         = "vboxnet1"
+ ipv4_address           = (known after apply)
+ ipv4_address_available = (known after apply)
+ mac_address            = (known after apply)
+ status                 = (known after apply)
+ type                   = "hostonly"
}
}

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
+ IPAddress = (known after apply)

Do you want to perform these actions?
Terraform will perform the actions described above.
Only 'yes' will be accepted to approve.

Enter a value: yes

virtualbox_vm.vm1: Creating...
virtualbox_vm.vm1: Still creating... [10s elapsed]
virtualbox_vm.vm1: Still creating... [20s elapsed]
virtualbox_vm.vm1: Still creating... [30s elapsed]
virtualbox_vm.vm1: Still creating... [40s elapsed]
virtualbox_vm.vm1: Still creating... [50s elapsed]
virtualbox_vm.vm1: Still creating... [1m0s elapsed]
virtualbox_vm.vm1: Still creating... [1m10s elapsed]
virtualbox_vm.vm1: Still creating... [1m20s elapsed]
virtualbox_vm.vm1: Still creating... [1m30s elapsed]
virtualbox_vm.vm1: Still creating... [1m40s elapsed]
virtualbox_vm.vm1: Still creating... [1m50s elapsed]
virtualbox_vm.vm1: Still creating... [2m0s elapsed]
virtualbox_vm.vm1: Still creating... [2m10s elapsed]
╷
│ Error: unable to start VM: exit status 1
│
│   with virtualbox_vm.vm1,
│   on main.tf line 15, in resource "virtualbox_vm" "vm1":
│   15: resource "virtualbox_vm" "vm1" {
│
╵
nva@Lenovo-G50-80:~/terraform/virt-23/ter-homeworks/01/src/vb$ VBoxManage list vms
"kali-linux-2022.4-virtualbox-amd64" {1b908152-38ed-4fa3-8e81-c60adf3e1102}
"server1.netology" {5885ac4f-9281-43aa-a41a-1ad3c5f8ffe5}
"debian-11" {cbfc7669-2a2c-44d1-88b6-8cb7cf661213}
```
