terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}
resource "yandex_compute_instance" "docker-base" {
  count = var.instances
  name  = "docker-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 10
    }
  }


  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
resource "local_file" "inventory_tmpl" {
  content = templatefile("../ansible/inventory.tmpl",
    {
      docker_ip = yandex_compute_instance.docker-base[*].network_interface.0.nat_ip_address
    }
  )
  file_permission = "0644"
  filename        = "../ansible/inventory"
}
