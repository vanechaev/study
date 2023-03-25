/*
output "internal_ip_address_platform_yandex_cloud" {
  value = "${yandex_compute_instance.platform.network_interface.0.ip_address}"
}
*/
output "external_ip_address_platform_yandex_cloud" {
  value = "${yandex_compute_instance.platform.network_interface.0.nat_ip_address}"
}
/*
output "internal_ip_address_netology-develop-platform-db_yandex_cloud" {
  value = "${yandex_compute_instance.netology-develop-platform-db.network_interface.0.ip_address}"
}
*/
output "external_ip_address_netology-develop-platform-db_yandex_cloud" {
  value = "${yandex_compute_instance.netology-develop-platform-db.network_interface.0.nat_ip_address}"
}
