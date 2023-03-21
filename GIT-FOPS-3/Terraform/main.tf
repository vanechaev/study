provider "yandex" {
  service_account_key_file = "key.json"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
}

resource "yandex_compute_instance" "vm1" {
  name                      = "vm1"
  zone                      = "ru-central1-a"
  hostname                  = "vm1.netology.cloud"
  platform_id = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.ubuntu}"
      name        = "root-node01"
      type        = "network-nvme"
      size        = "20"
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/home/nva/.ssh/id_rsa.pub")}"
  }
}
