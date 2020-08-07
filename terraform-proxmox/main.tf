terraform {
  required_version = ">= 0.12"
}

provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = var.pm_tls_insecure
  pm_parallel     = var.pm_parallel
}

resource "proxmox_vm_qemu" "vm" {
  count       = var.vm_count
  name        = "${var.vm_prefix}-${count.index}"
  desc        = "VM ${var.vm_prefix}-${count.index}"
  target_node = var.pm_target_node_name

  kvm = true

  clone    = var.vm_template
  cpu      = "host"
  numa     = false
  cores    = 1
  sockets  = 1
  memory   = 1024
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"
  network {
    id        = 0
    model     = "virtio"
    bridge    = var.vm_bridge
    firewall  = true
    link_down = false
  }

  force_create = false
  full_clone   = false

  os_type = "cloud-init"
  ciuser  = var.ci_user
  sshkeys = file(var.ci_ssh_public_keys_file)

  nameserver   = var.vm_ip_dns
  searchdomain = var.vm_searchdomain
  ipconfig0    = "ip=${var.vm_ip_network}${count.index + var.vm_ip_network_start}/${var.vm_ip_cidr},gw=${var.vm_ip_gateway}"

  agent   = 1
  balloon = 0
  onboot  = false

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}
