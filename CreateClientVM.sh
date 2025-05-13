#!/bin/bash
# Script:                       Create Client VM (Cross-platform: macOS + Ubuntu)
# Author:                       Eveangalina Campos
# Date of latest revision:      05/2025
# Purpose:                      CloudReadyUserProvisioning w Hybrid Join

# Detect OS
OS_TYPE=$(uname)
echo "Detected OS: $OS_TYPE"

# Define base ISO path based on OS
if [[ "$OS_TYPE" == "Darwin" ]]; then
  # macOS
  ISO_PATH="$HOME/Desktop/Sandbox-MSSA/windows_10_consumer_edition_x64.iso"
else
  # Linux (Ubuntu)
  ISO_PATH="$HOME/Desktop/Sandbox-MSSA/windows_10_consumer_edition_x64.iso"
fi

# Define VDI path (same for both OS when using $HOME)
VDI_PATH="$HOME/VirtualBox VMs/Client01/Client01.vdi"

# Safety check: Does VM already exist?
if VBoxManage list vms | grep -q "\"Client01\""; then
  echo "❗ VM 'Client01' already exists. Aborting to prevent duplication."
  exit 1
fi

# Step 1: Create the VM
VBoxManage createvm --name "Client01" --ostype "Windows10_64" --basefolder "$HOME/VirtualBox VMs" --register

# Step 2: Configure memory and CPU
VBoxManage modifyvm "Client01" --memory 4096 --cpus 2

# Step 3: Set networking to NAT
VBoxManage modifyvm "Client01" --nic1 nat

# Step 4: Create virtual hard disk
VBoxManage createhd --filename "$VDI_PATH" --size 40000

# Step 5: Add SATA controller
VBoxManage storagectl "Client01" --name "SATA Controller" --add sata --controller IntelAhci

# Step 6: Attach hard disk
VBoxManage storageattach "Client01" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$VDI_PATH"

# Step 7: Attach ISO (Windows 10 Education)
VBoxManage storageattach "Client01" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ISO_PATH"

# Step 8: Start the VM
VBoxManage startvm "Client01"
