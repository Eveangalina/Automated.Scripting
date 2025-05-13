#!/bin/bash
# Script: CreateClientVM.sh
# Author: Eveangalina Campos
# Purpose: Create a Cloud-Ready Windows 10 Client VM in VirtualBox on Ubuntu
# Target Config: Windows 10/11 Education (22H2), 2 CPUs, 8 GB RAM, 60 GB SSD, NAT DHCP

# Set variables
VM_NAME="Client01"
VM_TYPE="Windows10_64"
VM_ISO="/home/eve/Desktop/Sandbox-MSSA/windows_10_consumer_editions_version_22h2_x64.iso"
VM_FOLDER="$HOME/VirtualBox VMs/$VM_NAME"
VDI_PATH="$VM_FOLDER/$VM_NAME.vdi"

# Create the VM
<<<<<<< HEAD
VBoxManage createvm --name "$VM_NAME" --ostype "$VM_TYPE" --register
=======
VBoxManage createvm --name "Client01" --ostype "Windows10_64" --basefolder "$HOME/VirtualBox VMs" --register
>>>>>>> 12bfe7b (Fix and finalize CreateClientVM.sh for Windows 10 provisioning)

# Set memory, CPU, and networking
VBoxManage modifyvm "$VM_NAME" --memory 8192 --cpus 2 --nic1 nat

# Create virtual hard disk
VBoxManage createhd --filename "$VDI_PATH" --size 60000

# Add SATA controller
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci

# Attach the hard disk
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 0 --device 0 --type hdd --medium "$VDI_PATH"

<<<<<<< HEAD
# Attach the ISO
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 1 --device 0 --type dvddrive --medium "$VM_ISO"
=======
# Attach the Windows 10 Education ISO
VBoxManage storageattach "Client01" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "/home/eve/Desktop/Sandbox-MSSA/windows_10_consumer_editions_version_22h2_x64.iso"
>>>>>>> 12bfe7b (Fix and finalize CreateClientVM.sh for Windows 10 provisioning)

# Start the VM
VBoxManage startvm "$VM_NAME"
