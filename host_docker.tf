data "yandex_compute_image" "ubuntu_2404_lts" {
    family = "ubuntu-2404-lts"
}

resource "yandex_compute_instance" "docker" {
    name        = "docker"
    hostname    = "docker"
    platform_id = "standard-v1"
    zone        =  "ru-central1-a"
    resources {
        cores  = 2
        memory = 2
        core_fraction = 20
    }
    boot_disk {
        initialize_params {
            image_id = data.yandex_compute_image.ubuntu_2404_lts.image_id
            type = "network-hdd"
            size = 10
        }
    }
    network_interface {
        subnet_id = yandex_vpc_subnet.subnet_docker.id
        nat       = true
    }

    metadata = {
        user-data = file("./cloud-init.yml")
        serial-port-enable = 1
    }
    scheduling_policy { preemptible = true }
}

resource "local_file" "inventory" {
    content = <<-EOT
    [docker]
    ${yandex_compute_instance.docker.network_interface.0.nat_ip_address}

    EOT
    filename = "/home/alex/ansible/hosts.ini"
    file_permission = "0644"
}

