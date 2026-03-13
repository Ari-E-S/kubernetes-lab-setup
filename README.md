# Laboratory for Kubernetes learning

# Terraform

Requires:
* Multipass
* Hyper-V
* WSL

## Networking in WSL


Make sure of the following:

Networking mode for WSL is set to `NAT` in `$HOME\.wslconfig`.
Routing between the virtual Ethernet switches for WSL and the VMs is enabled:
```pwsh
Get-NetIPInterface | where {$_.InterfaceAlias -eq 'vEthernet (WSL (Hyper-V firewall))' -or $_.InterfaceAlias -eq 'vEthernet (Default Switch)'}  | Set-NetIPInterface -Forwarding Enabled
```

## Ansible Requirements

The following modules need to be installed from Ansible Galaxy:
* ansible.posix
* ansible.builtin.modprobe
