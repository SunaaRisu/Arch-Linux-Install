# Arch Install

[Encrypted Install](https://gist.github.com/mjnaderi/28264ce68f87f52f2cabb823a503e673)
</br>
[Comfy Install](https://www.youtube.com/watch?v=68z11VAYMS8)
</br>
[Arch Installation Guid](https://wiki.archlinux.org/title/Installation_guide)

## Change Keyboard layout

```bash
loadkeys dvorak
```

## Connect to WiFi

```bash
iwctl device list
iwctl station DEVICE scan
iwctl station DEVICE get-networks
iwctl station DEVICE connect SSID
ping sunaarisu.de
```

## Partitioning with cfdisk

```bash
cfdisk /dev/<Your-Disk>
```

Personal suggestion:

Make 3 Partitions
- boot (100M)
- swap (8G)
- root (the rest of the disk space)

Write changes and quit.

```bash
lsblk
```

## Format the Partitions 

```bash
mkfs.ext4 /dev/<Your-root-Partition>
mkswap /dev/<Your-swap-Pratition>
mkfs.fat -F 32 /dev/<Your-boot-Partition>
```

## Mount the file systems

```bash
mount /dev/<Your-root-Partition> /mnt
mount --mkdir /dev/<Your-boot-Partition> /mnt/boot
swapon /dev/<Your-swap-Pratition>
```

## Install essential packages

```bash
pacstrap -K /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nvim networkmanager
```

## Generate fstab

```bash
genfstab /mnt > /mnt/etc/fstab
```

## Changing root

```bash
arch-chroot /mnt
```

## Timezone

```bash
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
```

## Localization

```bash
hwclock --systohc
```

Edit /etc/locale.gen and delet the # from en_US.UTF-8 UTF-8.

```bash
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
```

## Keymap

```bash
echo KEYMAP=dvorak > /etc/vconsole.conf
```

## Hostname

```bash
echo <Your-Host-Name> > /etc/hostname
```

## Root password

```bash
passwd
```

## Adding User

```bash
useradd -m -G wheel -s /bin/bash <Your-User-Name>
passwd <Your-User-Name>
```

## sudo setup

```bash
EDITOR=nvim visudo
```

Uncommend %wheel ALL=(ALL:ALL) ALL

## enabel services

```bash
systemctl enable NetworkManager
```

## Grub config

```bash
grub-install /dev/<Your-Disk>
grub-mkconfig -o /boot/grub/grub.cfg
```

## Exit the Archiso

```bash
exit
umount -a
reboot
```

# ArchPostInstall
## Install DM, WM and basic packages
sudo pacman -S xorg-server ly awesome alacritty firefox git neofetch ttf-jetbrains-mono-nerd
sudo systemctl enable --now ly

git clone git@github.com:SunaaRisu/ArchPostInstall.git

## make awesome usable
1. Copy rc.lua to /home/YourUser/.config/awesome

2. Copy all files from Xorg/ to /etc/X11/xorg.conf.d

    00.keyboard.conf                    // changes keyboard layout to Dvorak (change if needed)
    10.monitors.conf                    // changes monitor layout (change if needed (use xrandr and arandr (ui)))


3. Copy all files from scripts/ to /bin

    set-refresh-rate.sh                 // sets refresh rate of DP-3 to 120Hz (change if needed)


4. Copy all background images from images/backgrounds/ to /usr/share/backgrounds
   Install nitrogen
   Add /usr/share/backgrounds to the paths


## make awesome beautiful
1. Insall rofi and change theme to gruvbox dark

2. install gtk-engine-murrine sassc
   git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git
   ./Gruvbox-GTK-Theme/themes/install.sh
   sudo rm -r Gruvbox-GTK-Theme
   gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Dark
   
   change both themes in /usr/share/gtk-3.0 to Gruvbox-Dark


## make nvim beautiful
1. Copy all nvim/ to /home/YourUser/.config
