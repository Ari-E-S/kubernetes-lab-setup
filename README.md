# Laboratory for Kubernetes learning

Set up a disposable lab to play with Kubernetes, from VM provisioning to deployed cluster.

DISCLAMER: This is a WORK IN PROGRESS and not warranteed to work for you.

## Execution environment

Required software in the execution environment:
* Terraform
* Multipass
* Ansible
* Helm
* WSL

### OS

This setup has been tested on Windows 11 with Hyper-V virtualization and WSL as the execution environment.
WSL is required as ansible cannot run on Windows.

#### Networking

Networking is one of the most involved parts of this setup.

Some considerations to keep in mind:
* `kubeadm` uses the default gateway to select the IP address for the node and the services
* You can can change the binding address for the API server but changing it for the other services is not recommended
* Kubernetes needs static IPs to work
* Hyper-V and Multipass set up an interface for management that changes IP on restart
* The address needs to be routable, so link-local or multicast addresses will not work

Before starting, setup Windows and WSL networking by following these instructions.

##### Networking for WSL

1. Open `WSL Settings`
1. Select the `Networking` tab
1. Make sure these are the values:
  * `Networking mode` = `NAT`
  * `Hyper-V Firewall enabled` = `On`
  * `Enable localhost forwarding` = `On`
  * `Host Address Loopback` = `Off`
  * `Auto Proxy enabled` = `On`
  * `DNS Proxy enabled` = `On`
  * `DNS Tunneling enabled` = `On`
  * `Use best effort DNS parsing` = `Off`

##### Networking for Hyper-V

Open an administrator Powershell console.

Create an `Internal` vSwitch named `multipass`.
```pwsh
New-VMSwitch -Name "multipass" -SwitchType Internal
```
You may change the name but it must be kept consistent for the reminder of the procedure.

Add an IP address and NAT capabilities to the new switch.
```pwsh
New-NetIPAddress -IPAddress 192.168.50.1 -PrefixLength 24 -InterfaceAlias "vEthernet (multipass)"
New-NetNat -Name multipass -InternalIPInterfaceAddressPrefix 192.168.50.0/24
```
A different CIDR can be used but make sure it is a private range from RFC1918 and not used anywhere else in the setup.
This CIDR will be assigned to the VMs' second network interface and will become the default gateway and the IP addresses for the Kubernetes nodes.
More in depth info can be found the [Microsoft's docs](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/setup-nat-network)

Disable DHCP on the new switch
```pwsh
Set-NetIPInterface -InterfaceAlias "vEthernet (multipass)" -Dhcp Disabled
```

Enable forwarding on all vSwitches to ensure connectivity between the host, WSL and the VMs across all interfaces.
```pwsh
Get-NetIPInterface | `
  where {$_.InterfaceAlias -eq 'vEthernet (WSL (Hyper-V firewall))' -or $_.InterfaceAlias -eq 'vEthernet (Default Switch)' -or $_.InterfaceAlias -eq "vEthernet (multipass)"} | `
  Set-NetIPInterface -Forwarding Enabled
```

### Ansible Requirements

The following modules need to be installed from Ansible Galaxy:
* ansible.posix
* community.general
* kubernetes.core

The way to install these modules is
```
ansible-galaxy collection install -r 02-ansible/requirements.yaml
```

## Virtualization stack

Requires:
* Multipass
* Hyper-V

## Creating the stack

### Infrastructure

Once the networking and all the requirements are set, you can create a `terraform.tfvars` file in the `01-terraform` directory based on the provided example.
The values of the variables within the file must be set according to your environment.
Once the variables are updated and changing to the `01-terraform` directory, the usual `terraform init` and `terraform apply` can be used to spin up the VMs.

#### APT Cache (optional)

Before creating the infrastructure, you can spin up a VM to act as APT cache by following these instructions: [How to Create a Local Ubuntu Package Cache with Apt-Cacher-NG](https://www.tecmint.com/apt-cache-server-in-ubuntu/)
After setting up the cache, setting the variable `apt_cacher_url` to the URL of the service makes the VMs use the cache when updating.

The following command will spin up the VM with the service installed and enabled:
```sh
multipass launch --name apt-cacher --disk 15G --timeout 600 --cloud-init user_data-apt_cacher.yaml noble
```

### Configuration

The terraform run should result in the instances in the up and running state although pending a reboot.
Ansible will take care of the final configurations prior to setting up the cluster and joining the nodes.

Terraform creates an inventory in `02-ansible/inventory/hosts.yaml` that needs to be checked and, sometimes, tweaked.
It also creates an SSH private key in `02-ansible/keys/ed25519-key-ubuntu` and publishes the private key in the ubuntu user of the VMs.

Switch to the `02-ansible` directory.
Make sure the VMs are reachable by using the following command:

```sh
ansible -i inventory/hosts.yaml -m ping all
```

If successful, the configuration can be applied by running the following:
```sh
ansible-playbook -i inventory/hosts.yaml main.yaml
```
