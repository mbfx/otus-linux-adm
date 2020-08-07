output "vm_data" {
  value = ["${proxmox_vm_qemu.vm.*.name}", "${proxmox_vm_qemu.vm.*.ssh_host}"]
}