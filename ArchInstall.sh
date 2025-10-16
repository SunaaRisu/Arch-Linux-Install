#!/bin/bash

# Connect to the Internet
ping -c 1 archlinux.org
if [ $? -eq 0 ]; then 
  echo "Connected"
else 
  echo "Try Wifi connection"
  echo -n "SSID: "
  read wifissid
  echo -n "Password: "
  read wifipwd
  iwctl --passphrase $wifipwd station wlan0 connect $wifissid
  ping -c 1 archlinux.org
  if [ $? -eq 0 ]; then
    echo "Connected"
  else
    echo "Connection Error"
    exit 1
  fi
fi

# Update the system clock
timedatectl

# Partition the disks
lsblk
echo "Which disk should be partitioned?"
echo -n "/dev/"
read partDisk
cfdisk /dev/${partDisk}


# Format the Partitions
if [[ $partDisk == *"nvme"* ]]; then
  partDisk="${partDisk}p"
fi

mkfs.ext4 /dev/${partDisk}3
mkswap /dev/${partDisk}2
mkfs.fat -F 32 /dev/${partDisk}1

# Mount the file system
mount /dev/${partDisk}3 /mnt
mount --mkdir /dev/${partDisk}1 /mnt/boot
swapon /dev/${partDisk}2

# Install essential packages
pacstrap -K /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nvim networkmanager man btop fastfetch git

# Generate fstab
genfstab /mnt > /mnt/etc/fstab

# Changing root
arch-chroot /mnt
