#!/bin/bash
# Script:                       Create Client VM (Ubuntu/macOS Compatible)
# Author:                       Eveangalina Campos
# Date of latest revision:      05/2025
# Purpose:                      CloudReadyUserProvisioning w/ Hybrid Join
# Note: Your ISO is in Sandbox-MSSA on the Desktop of both Mac and Ubuntu

VM_NAME="Client01"
BASE_FOLDER="$HOME/VirtualBox VMs"
VDI_PATH="$BASE_FOLDER/$VM_NAME/$VM_NAME.vdi"
ISO_PATH="$HOME/Desktop/Sandbox-MSSA/windows_10_consumer_edition_x64.iso"

# Clean up any previously failed VM
VBoxManage unregistervm "$VM_NAME" --delete 2>/dev/null
rm -rf "$BASE_FOLDER/$VM_NAME"

# Create the VM
VBoxManage createvm --name "$VM_NAME" --ostype "Windows10_64" --basefolder "$BASE_FOLDER" --register

# Configure VM
VBoxManage modifyvm "$VM_NAME" --memory 4096 --cpus 2 --nic1 nat

# Create virtual hard disk
VBoxManage createhd --filename "$VDI_PATH" --size 40000

# Add SATA controller
VBoxManage storagectl "$VM_NAME" --name "SATA Controller" --add sata --controller IntelAhci

# Attach the hard disk
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VDI_PATH"

# Attach ISO file
VBoxManage storageattach "$VM_NAME" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ISO_PATH"

# Start the VM
VBoxManage startvm "$VM_NAME"
