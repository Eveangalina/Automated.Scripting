#!/bin/bash
# Script:                       Create Client VM - Compatible w Ubuntu OS
# Author:                       Eveangalina Campos
# Date of latest revision:     05/2025
# Purpose:                      CloudReadyUserProvisioning w Hybrid Join
# Note:                         ISO is located inside "Sandbox-MSSA" folder on the Desktop

# Create the VM and explicitly set the basefolder
VBoxManage createvm --name "Client01" --ostype "Windows10_64" --basefolder "$HOME/VirtualBox VMs" --register

# Configure memory and CPU
VBoxManage modifyvm "Client01" --memory 4096 --cpus 2

# Set networking to NAT
VBoxManage modifyvm "Client01" --nic1 nat

# Create a virtual hard disk
VBoxManage createhd --filename "$HOME/VirtualBox VMs/Client01/Client01.vdi" --size 40000

# Add SATA controller
VBoxManage storagectl "Client01" --name "SATA Controller" --add sata --controller IntelAhci

# Attach the hard disk
VBoxManage storageattach "Client01" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$HOME/VirtualBox VMs/Client01/Client01.vdi"

# Attach the Windows 10 ISO located in the "Sandbox-MSSA" folder on the Desktop
VBoxManage storageattach "Client01" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$HOME/Desktop/Sandbox-MSSA/windows_10_consumer_edition_x64.iso"

# Start the VM
VBoxManage startvm "Client01"
