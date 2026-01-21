resource "yandex_vpc_network" "network2" {
    name = "network2"
}

resource "yandex_vpc_subnet" "subnet_docker" {
    name           = "subnet_docker"
    zone	   = "ru-central1-a"
    v4_cidr_blocks = ["10.0.10.0/24"]
    network_id     = yandex_vpc_network.network2.id
}
