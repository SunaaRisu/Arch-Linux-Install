ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo KEYMAP=dvorak > /etc/vconsole.conf
read -r -p "Hostname: " hn
echo $hn > /etc/hostname
passwd
useradd -m -G wheel -s /bin/bash sunaa
passwd sunaa
sed -i 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
read -r -p "Disk: /dev/" partDisk
read -r -p "Is the disk encryted? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
  grub-install --efi-directory=/boot /dev/${partDisk}
  grub-mkconfig -o /boot/grub/grub.cfg
else
  sed -i 's/HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems fsck)/HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block encrypt lvm2 filesystems fsck)/' /etc/mkinitcpio.conf
  mkinitcpio -P
  grub-install --efi-directory=/boot /dev/${partDisk}
  if [[ $partDisk == *"nvme"* ]]; then
    partDisk="${partDisk}p"
  fi
  blkid -o value -s UUID /dev/${partDisk}2 >> /etc/default/grub
  blkid -o value -s UUID /dev/mapper/cryptroot >> /etc/default/grub
  
  sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"/GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=${uuidone}:cryptroot root=UUID=${uuidtwo}"/' /etc/default/grub
  nvim /etc/default/grub

  grub-mkconfig -o /boot/grub/grub.cfg
fi
systemctl enable NetworkManager


exit
umount -a
reboot
