#!/bin/bash
# Script: CreateUbuntuHostVM.sh
# Author: Eveangalina Campos
# Purpose: Provision an Ubuntu 22.04 Desktop VM in VirtualBox on macOS host
# Use Case: Create a compatible host environment for VMs that cannot run directly in macOS VirtualBox (e.g., Windows Server VMs)
# VM Config: Ubuntu 22.04 Desktop, 2 CPUs, 4 GB RAM, 40 GB SSD, NAT
# Notes: Automatically registers the VM and starts it after setup. Ensures VM files are stored in the default VirtualBox directory.

# Set variables
VM_NAME="UbuntuHostVM"
VM_TYPE="Ubuntu_64"
VM_ISO="$HOME/Desktop/Sandbox-MSSA/ubuntu-22.04.5-desktop-amd64.iso"
VM_FOLDER="$HOME/VirtualBox VMs/$VM_NAME"
VDI_PATH="$VM_FOLDER/$VM_NAME.vdi"

# Create the VM and register it
VBoxManage createvm --name "$VM_NAME" --ostype "$VM_TYPE" --basefolder "$HOME/VirtualBox VMs" --register

# Set memory, CPU, and network settings
VBoxManage modifyvm "$VM_NAME" \
  --memory 4096 \
  --cpus 2 \
  --nic1 nat

# Create virtual hard disk
VBoxManage createhd --filename "$VDI_PATH" --size 40000

# Add SATA controller
VBoxManage storagectl "$VM_NAME" \
  --name "SATA Controller" \
  --add sata \
  --controller IntelAhci

# Attach virtual hard disk
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 0 \
  --device 0 \
  --type hdd \
  --medium "$VDI_PATH"

# Attach Ubuntu ISO
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 1 \
  --device 0 \
  --type dvddrive \
  --medium "$VM_ISO"

# Start the VM
VBoxManage startvm "$VM_NAME"
