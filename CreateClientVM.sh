#!/bin/bash
# Script:          Create Client VM - Ubuntu VirtualBox
# Author:          Eveangalina Campos
# Date:            05/2025
# Purpose:         Cloud-Ready User Provisioning - Auto VM Creation

# ===== CONFIGURATION =====
VM_NAME="Client01"
VM_TYPE="Windows10_64"
VM_FOLDER="$HOME/VirtualBox VMs/$VM_NAME"
VHD_FILE="$VM_FOLDER/$VM_NAME.vdi"
ISO_PATH="$HOME/Desktop/Sandbox-MSSA/windows_10_consumer_editions_version_22h2_x64.iso"

# ===== CLEANUP (if exists) =====
echo "[+] Cleaning up old VM and disk if they exist..."
VBoxManage unregistervm "$VM_NAME" --delete 2>/dev/null
rm -rf "$VM_FOLDER"

# ===== CREATE VM =====
echo "[+] Creating new VM: $VM_NAME"
VBoxManage createvm --name "$VM_NAME" --ostype "$VM_TYPE" --register

# ===== MODIFY VM SETTINGS =====
echo "[+] Configuring CPU, memory, and networking..."
VBoxManage modifyvm "$VM_NAME" \
  --cpus 2 \
  --memory 8192 \
  --nic1 nat

# ===== CREATE VIRTUAL DISK =====
echo "[+] Creating virtual hard disk (60GB)..."
VBoxManage createhd --filename "$VHD_FILE" --size 61440

# ===== ADD STORAGE CONTROLLER =====
echo "[+] Adding SATA controller..."
VBoxManage storagectl "$VM_NAME" \
  --name "SATA Controller" \
  --add sata \
  --controller IntelAhci

# ===== ATTACH DISK & ISO =====
echo "[+] Attaching virtual disk..."
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 0 --device 0 \
  --type hdd \
  --medium "$VHD_FILE"

echo "[+] Attaching Windows ISO..."
VBoxManage storageattach "$VM_NAME" \
  --storagectl "SATA Controller" \
  --port 1 --device 0 \
  --type dvddrive \
  --medium "$ISO_PATH"

# ===== START VM =====
echo "[+] Launching the VM..."
VBoxManage startvm "$VM_NAME"
