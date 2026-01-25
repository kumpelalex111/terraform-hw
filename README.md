# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»: - Хрипун Алексей

### Задание 1

В файле main.tf допущено несколько ошибок:
* Т.к. в проекте используется версия Terraform 14.3, запись required_version = "~>1.12.0" былв изменена на required_version = "=>1.12.0"
* Platform "standart-v4" not found. В платформе standard-v3 можжно использовать corefraction минимум 20%, поэтому тоже не подходит. Кроме того, нужно минимум 2 ядра. Выбираем между standard-v2.

Прерываемые виртуальные машины (preemptible = true) могут быть принудительно остановлены, если с момента запуска ВМ прошло 24 часа.
Это может помочь не расходовать средства, если после тестов или выполнения ДЗ забыл задестроить проект. Кроме того, такие ВМ дешевле.

Уровень производительности (corefraction=5%) может пригодиться для удешевления ВМ. Но лучше использовать corefraction=20%, т.к. при 5% может подтормаживать даже ssh.


![yc](img/1_1.png)


![yc](img/1_2.png)

### Задание 2

Переменные в код добавлены, команда *terraform plan* изменений не показала.

### Задание 3

Создана вторая ВМ с именем *netology-develop-platform-db*, работает в зоне ru-central1-b

![vm](img/3_1.png)

![vm](img/3_2.png)

### Задание 4

![output](img/4.png)

### Задание 5
В файле locals.tf с помощью интерпояции переменных были описаны имена каждой ВМ:
```
locals {
vm_web = "${ var.vm_company }-${ var.vpc_name }-${ var.label_web }"
vm_db = "${ var.vm_company }-${ var.vpc_name }-${ var.label_db }"
}
```
Для этого задания были введены дополнительно переменные vm_company, label_web и label_db.

![vm_name](img/5.png) 

Внутри ресурса ВМ переменные были заменены на созданные local-переменные.


### Задание 6

Для описания ресурсов ВМ была создана переменная map(object) vms_resources:
```
variable "vms_resources" {
  type = map(object({
    cores  = number
        memory = number
        core_fraction = number
        }))
  default = {
    "web" ={
      cores=2
      memory=1
      core_fraction=5
  },
    "db" = {
      cores=2
      memory=2
      core_fraction=20
    }
  }
}
```
Эта переменная используется в коде для описания ресурсов виртуальных машин.
Для описания metadata также была объявлена map(object) переменная:
```
variable "vms_metadada" {
  type = map(object({
    serial-port-enable = number
    ssh-keys = string
    }))
  default = {
    "ubuntu" = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAD4NWSjViP3GwlG6xvTlNt8LihsJauyRG/JXSSop+Vy alex@test3"
    }
  }
}
```
Эта переменная используется для проброса ssh-ключа на обе ВМ.
После замены переменных команда *terraform plan* изменений не показала.

![plan](img/6.png)

### Задание 7

1. Второй элемент списка test_list:
```
local.test_list.1
```
![console](img/7_1.png)

2. Длина списка test_list
```
length(local.test_list)
```
![console](img/7_2.png)

3. Значение ключа admin из map test_map:
```
local.test_map.admin
```
![console](img/7_3.png)

4. Выражение *"John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks"*, составленное из переменных:
```
"${local.test_map.admin} is ${keys(local.test_map)[0]} for ${local.test_list[2]} server based on OS ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks"
```
![console](img/7_4.png)
