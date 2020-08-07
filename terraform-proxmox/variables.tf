variable "pm_api_url" {
  description = "Proxmox API URL"
}

variable "pm_user" {
  description = "Proxmox API username"
}

variable "pm_password" {
  description = "Proxmox API password"
}

variable "pm_tls_insecure" {
  description = "Proxmox API TLS verification"
  default     = false
}

variable "pm_parallel" {
  description = "Allowed simultaneous Proxmox processes"
  default     = 4
}

variable "pm_target_node_name" {
  description = "Proxmox node name"
}

variable "vm_count" {
  description = "Count of VM"
  default     = 1
}

variable "vm_template" {
  description = "Template for cloning"
}

variable "vm_prefix" {
  description = "Prefix for VM name"
  default     = "prefix"
}

variable "vm_bridge" {
  description = "Bridge for network"
}

variable "ci_user" {
  description = "Cloud-init user"
}

variable "ci_ssh_public_keys_file" {
  description = "Keys for cloud-init"
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_ip_network" {
  description = "Unchangable part of IP address"
}

variable "vm_ip_cidr" {
  description = "Network CIDR mask"
}

variable "vm_ip_network_start" {
  description = "First address for VM's range"
}

variable "vm_ip_gateway" {
  description = "VM's default gateway"
}

variable "vm_searchdomain" {
  description = "DNS default searchdomain"
  default     = "invalid"
}

variable "vm_ip_dns" {
  description = "DNS server IP address"
}
