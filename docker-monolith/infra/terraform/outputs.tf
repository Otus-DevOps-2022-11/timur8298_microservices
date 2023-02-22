output "docker_ip" {
  value = yandex_compute_instance.docker-base[*].network_interface.0.nat_ip_address
}
