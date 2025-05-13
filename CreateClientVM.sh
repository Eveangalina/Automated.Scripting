#!/bin/bash
# Script:                       Create Client VM (Ubuntu-Compatible)
# Author:                       Eveangalina Campos (9:15AM 5-13-25)
# Date of latest revision:      05/2025
# Purpose:                      CloudReadyUserProvisioning w/ Hybrid Join
# Note:                         ISO is stored in ~/Desktop/Sandbox-MSSA on both Mac and Ubuntu

VM_NAME="Client01"
VBOX_FOLDER="$HOME/VirtualBox VMs/$VM_NAME"
VDI_PATH="$VBOX_FOLDER/$VM_NAME.vdi"
ISO_PATH="$HOME/Desktop/Sandbox-MSSA/windows_10_consumer_edition_x64.iso"

# Step 1: If the VM exists, unregister and delete it
if VBoxManage list vms | grep -q "$VM_NAME"; then
    echo "[INFO] Existing VM '$VM_NAME' found. Unregistering and deleting it."
    VBoxManage unregistervm "$VM_NAME" --delete
    sleep 2
fi

# Step 2: If the VDI exists, close and delete it
if VBoxManage list hdds | grep -q "$VDI_PATH"; then
    echo "[INFO] Existing VDI found at $VDI_PATH. Closing and deleting it."
    VBoxManage closemedium disk "$VDI_PATH" --delete
fi

# Step 3: Clean up directory if it still exists
if [ -d "$VBOX_FOLDER" ]; then
    echo "[INFO] Removing leftover VM directory."
    rm -rf "$VBOX_FOLDER"
fi

# Step 4: Create the VM
VBoxManage createvm \
  --name "$VM_NAME" \
  --ostype "Windows10_64" \
  --basefolder "$HOME/VirtualBox VMs" \
  --register

# Step 5: Configure memory and CPU
VBoxManage modifyvm "$VM_NAME" \
  --memory 4096 \
  --cpus 2

# Step 6: Set networking to NAT
VBoxManage modifyvm "$VM_NAME" --nic1 nat

# Step 7: Create virtual hard disk
VBoxManage createhd --filename "$VDI_PATH" --size 40000

# Step 8: Add SATA controller
VBoxManage storagectl "$VM_NAME" \
  --name "SATA Controller" \
  --add sata \
  --controller IntelAhci

# Step 9: Attach the hard disk
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 0 \
  --device 0 \
  --type hdd \
  --medium "$VDI_PATH"

# Step 10: Attach ISO for installation
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 1 \
  --device 0 \
  --type dvddrive \
  --medium "$ISO_PATH"

# Step 11: Launch the VM
VBoxManage startvm "$VM_NAME"
