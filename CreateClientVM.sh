#!/bin/bash

# Script:         Create Windows 10 Client VM for Cloud-Ready Provisioning
# Author:         Eveangalina Campos
# Date:           05/2025
# Purpose:        Automate VirtualBox VM creation with required specs
# Compatibility:  Ubuntu host

# ---------------------------- Configuration ----------------------------
VM_NAME="Client01"
VM_PATH="$HOME/VirtualBox VMs/$VM_NAME"
VHD_PATH="$VM_PATH/$VM_NAME.vdi"
ISO_PATH="/home/eve/Desktop/Sandbox-MSSA/windows_10_consumer_editions_version_22h2_x64.iso"
MEMORY_MB=8192
CPUS=2
DISK_SIZE_MB=61440
# -----------------------------------------------------------------------

# Step 1: Unregister and delete the VM if it already exists
VBoxManage unregistervm "$VM_NAME" --delete 2>/dev/null

# Step 2: Create the new VM
VBoxManage createvm --name "$VM_NAME" --ostype "Windows10_64" --basefolder "$HOME/VirtualBox VMs" --register

# Step 3: Configure memory and CPU
VBoxManage modifyvm "$VM_NAME" --memory "$MEMORY_MB" --cpus "$CPUS"

# Step 4: Set networking to NAT
VBoxManage modifyvm "$VM_NAME" --nic1 nat

# Step 5: Create a virtual hard disk
VBoxManage createhd --filename "$VHD_PATH" --size "$DISK_SIZE_MB"

# Step 6: Add SATA controller
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci

# Step 7: Attach the virtual hard disk
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VHD_PATH"

# Step 8: Attach the Windows ISO
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ISO_PATH"

# Step 9: Start the VM
VBoxManage startvm "$VM_NAME"
