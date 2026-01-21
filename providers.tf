terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"

    }
    docker = {
      source  = "kreuzwerker/docker"
    }
  }
  required_version = ">=1.12.0"
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  #zone      =  "ru-central1-d"
  service_account_key_file = file("~/.authorized_key.json")
}

provider "docker" {
  host    = "ssh://alex@${yandex_compute_instance.docker.network_interface.0.nat_ip_address}"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}
