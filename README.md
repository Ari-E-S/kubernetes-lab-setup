# Laboratory for Kubernetes learning

Set up a disposable lab to play with Kubernetes, from VM provisioning to deployed cluster.

DISCLAMER: This is a WORK IN PROGRESS and not warranteed to work for you.

## Execution environment

Required software in the execution environment:
* Terraform
* Multipass
* Ansible
* Helm

### OS

This setup has been tested on Windows 11 with Hyper-V virtualization and WSL using NAT networking mode as the execution environment.
This setup requires that IP forwarding be enabled between the WSL interface and the Ethernet vSwitch used by the VMs (see [Networking in WSL](#Networking in WSL) )

#### Networking in WSL


Make sure of the following:

Networking mode for WSL is set to `NAT` in `$HOME\.wslconfig`.
Routing between the virtual Ethernet switches for WSL and the VMs is enabled:
```pwsh
Get-NetIPInterface | `
  where {$_.InterfaceAlias -eq 'vEthernet (WSL (Hyper-V firewall))' -or $_.InterfaceAlias -eq 'vEthernet (Default Switch)'} | `
  Set-NetIPInterface -Forwarding Enabled
```

### Ansible Requirements

The following modules need to be installed from Ansible Galaxy:
* ansible.posix
* ansible.builtin.modprobe
* kubernetes.core

The way to install these modules is
```
ansible-galaxy collection install <MODULE>
```

## Virtualization stack

Requires:
* Multipass
* Hyper-V
