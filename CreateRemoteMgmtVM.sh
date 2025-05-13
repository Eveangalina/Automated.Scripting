#!/bin/bash
# Script: CreateRemoteMgmtVM.sh
# Author: Eveangalina Campos ✅ Working VM Created, finalized and saved
# Purpose: Provision a Remote Management Windows 10 VM in VirtualBox on Ubuntu
# Target Config: Windows 10 Education (22H2), 2 CPUs, 4 GB RAM, 40 GB SSD, NAT DHCP

# Set variables
VM_NAME="RemoteMgmt01"
VM_TYPE="Windows10_64"
VM_ISO="/home/eve/Desktop/Sandbox-MSSA/windows_10_consumer_editions_version_22h2_x64.iso"
VM_FOLDER="$HOME/VirtualBox VMs/$VM_NAME"
VDI_PATH="$VM_FOLDER/$VM_NAME.vdi"

# Create the VM
VBoxManage createvm --name "$VM_NAME" --ostype "$VM_TYPE" --basefolder "$HOME/VirtualBox VMs" --register

# Set memory, CPU, and networking
VBoxManage modifyvm "$VM_NAME" --memory 4096 --cpus 2 --nic1 nat

# Create virtual hard disk
VBoxManage createhd --filename "$VDI_PATH" --size 40000

# Add SATA controller
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci

# Attach the hard disk
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 0 --device 0 --type hdd --medium "$VDI_PATH"

# Attach the ISO
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 1 --device 0 --type dvddrive --medium "$VM_ISO"

# Start the VM
VBoxManage startvm "$VM_NAME"
