## Deployment with Terraform on Proxmox

- Tested on CentOS 7.
- Adapted for terraform v13.

1. Install a third-party plugin for Proxmox environment. Take it from [here](https://github.com/Telmate/terraform-provider-proxmox). Follow the [instructions](https://github.com/Telmate/terraform-provider-proxmox/blob/master/docs/installation.md).

2. You need to place custom provider files into folder **~/.terraform.d/plugins/mycorp.io/mycorp/proxmox/1/linux_amd64/**.
This is a workaround until this provider is added to the HashiCorp Terraform Provider Registry.

3. Create special user for provisioning on Proxmox. It needs to have the following rights:
```
Datastore.AllocateSpace
Datastore.Audit
VM.Allocate
VM.Audit
VM.Clone
VM.Monitor
VM.Config.CDROM
VM.Config.CPU
VM.Config.Disk
VM.Config.HWType
VM.Config.Memory
VM.Config.Network
VM.Config.Options
VM.Migrate
VM.PowerMgmt
```

4. Create linux OS template with cloud-init on Proxmox;

5. Create your own file **terraform.tfvars** and put it into current folder. Example [here](terraform.tfvars.example);

6. Create your own file **public_keys** and put it into current folder, or use default from **~/.ssh/id_rsa.pub**. Example [here](public_keys.example);

7. Add additional configuration block (like that) into **main.tf** if you need additional disk storage. Documentation is [here](https://github.com/Telmate/terraform-provider-proxmox/blob/master/docs/resource_vm_qemu.md);
```
disk {
        id = 4
        size = 1
        type = "virtio"
        storage = "ssd-lvm"
        storage_type = "lvmthin"
        iothread = true
        discard = "ignore"
    }
```

8. Run the following commands:
```bash
terraform init
terraform validate
terraform plan
terraform apply
```
