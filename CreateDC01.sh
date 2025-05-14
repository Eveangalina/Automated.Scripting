#!/bin/bash
# Script: CreateDC01.sh
# Author: Eveangalina Campos
# Purpose: Provision a Windows Server 2019/2022 VM for Active Directory Domain Controller setup
# Environment: Ubuntu Sandbox

# ────────────────────────────────────────────────────────────────────────
# Configuration
VM_NAME="DC01"
VM_TYPE="Windows2019_64"
VM_ISO="$HOME/Desktop/Sandbox-MSSA/windows_server_2019_x64_dvd.iso"  # Update if needed
VM_FOLDER="$HOME/VirtualBox VMs/$VM_NAME"
VDI_PATH="$VM_FOLDER/$VM_NAME.vdi"

# ────────────────────────────────────────────────────────────────────────
# Create the VM
VBoxManage createvm --name "$VM_NAME" --ostype "$VM_TYPE" \
  --basefolder "$HOME/VirtualBox VMs" --register

# Set memory, CPUs, and network
VBoxManage modifyvm "$VM_NAME" --memory 8192 --cpus 2 --nic1 nat

# Create virtual hard disk
VBoxManage createhd --filename "$VDI_PATH" --size 70000

# Create SATA controller
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci

# Attach hard disk
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" \
  --port 0 --device 0 --type hdd --medium "$VDI_PATH"

# Attach Windows Server ISO
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" \
  --port 1 --device 0 --type dvddrive --medium "$VM_ISO"

# Start VM
VBoxManage startvm "$VM_NAME"
