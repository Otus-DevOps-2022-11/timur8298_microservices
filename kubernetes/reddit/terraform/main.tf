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
resource "yandex_compute_instance" "k8s" {
  count = var.instances
  name  = "k8s-node-${count.index}"

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 40
      type     = "network-ssd"
    }
  }


  network_interface {
    subnet_id = yandex_vpc_subnet.kube-subnet.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}
resource "yandex_vpc_network" "kube-network" {
  name = "kube-network"
}

resource "yandex_vpc_subnet" "kube-subnet" {
  name           = "kube-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.kube-network.id
  v4_cidr_blocks = [var.cidr]
}

resource "local_file" "inventory_tmpl" {
  content = templatefile("../ansible/inventory.tmpl",
    {
      k8s_ex_ip = yandex_compute_instance.k8s[*].network_interface.0.nat_ip_address
      k8s_ip    = yandex_compute_instance.k8s[*].network_interface.0.ip_address
      cidr      = var.cidr
    }
  )
  file_permission = "0644"
  filename        = "../ansible/inventory"
}
