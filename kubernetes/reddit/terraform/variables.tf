variable "cloud_id" {
  description = "Cloud"
}
variable "folder_id" {
  description = "Folder"
}
variable "zone" {
  description = "Zone"
  default     = "ru-central1-a"
}
variable "region_id" {
  description = "region"
  default     = "ru-central1"
}
variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "image_id" {
  description = "Disk image"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "service_account_key_file" {
  description = "key.json"
}
variable "private_key_path" {
  description = "path to private key"
}
variable "k8s_account_id" {
  description = "k8s_account_id"
}
variable "network_id" {
  description = "network id"
}
