output "vm" {
    value = ["${yandex_compute_instance.netology-develop-platform-db.network_interface.0.nat_ip_address} ==> ${yandex_compute_instance.netology-develop-platform-db.name} ==> ${yandex_compute_instance.netology-develop-platform-db.fqdn}", "${yandex_compute_instance.platform.network_interface.0.nat_ip_address} ==> ${yandex_compute_instance.platform.name} ==> ${yandex_compute_instance.platform.fqdn}"]
}



