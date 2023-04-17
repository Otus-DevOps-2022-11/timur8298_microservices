output "k8s_ex_ip" {
  value = yandex_compute_instance.k8s[*].network_interface.0.nat_ip_address
}
output "k8s_ip" {
  value = yandex_compute_instance.k8s[*].network_interface.0.ip_address
}
