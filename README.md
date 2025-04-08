# Arch Install

[Arch Installation Guid (Text)](https://wiki.archlinux.org/title/Installation_guide)
</br>
[Comfy Install (Video)](https://www.youtube.com/watch?v=68z11VAYMS8)


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
nano /etc/pacman.conf
```

Uncommend ParallelDownloads and set it to the number of threads your PC has. (2 * Cores)

```bash
pacstrap -K /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nvim networkmanager man
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


# Arch Install (Encrypted)

[Encrypted Install (Text)](https://gist.github.com/mjnaderi/28264ce68f87f52f2cabb823a503e673)
</br>
[Encrypted Install (Video)](https://www.youtube.com/watch?v=kXqk91R4RwU)


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
- boot (512M)
- root (the rest of the disk space)

Write changes and quit.

```bash
lsblk
```


## Format the Partitions 

```bash
mkfs.fat -F 32 /dev/<Your-boot-Partition>
cryptsetup luksFormat /dev/<Your-root-Partition>
cryptsetup open /dev/<Your-root-Partition> cryptroot
mkfs.ext4 /dev/mapper/cryptroot
```


## Mount the file systems

```bash
mount /dev/mapper/cryptroot /mnt
mount --mkdir /dev/<Your-boot-Partition> /mnt/boot
```


## Install essential packages

```bash
nano /etc/pacman.conf
```

Uncommend ParallelDownloads and set it to the number of threads your PC has. (2 * Cores)

```bash
pacstrap -K /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nvim networkmanager man lvm2 cryptsetup
```


## Generate fstab

```bash
genfstab -U /mnt > /mnt/etc/fstab
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


## edit initcpio

```bash
nvim /etc/mkinitcpio.conf
```

Add encrypt and lvm2 after block to the HOOKS variable.

```bash
mkinitcpio -P
```


## Grub config

```bash
grub-install --efi-directory=/boot /dev/<Your-Disk>
blkid -o value -s UUID /dev/<Your-root-Partition> >> /etc/default/grub
blkid -o value -s UUID /dev/mapper/cryptroot >> /etc/default/grub
nvim /etc/default/grub
```

Put both UUIDs from the bottom of the file behind "loglevel=3 quiet <Paste here>" on the top of the file.
Add cryptdevice=UUID=<The first UUID>:cryptroot to the first UUID.
Add root=UUID=<The second UUID> to the second UUID.

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```


## enabel services

```bash
systemctl enable NetworkManager
```


## Exit the Archiso

```bash
exit
umount -a
reboot
```








# Post-installation (Hyprland [Laptop])

## Install and setup ly

```bash
sudo pacman -S ly
sudo systemctl enable --now ly.service
sudo systemctl start ly.service
```

Set Options in /etc/ly/config.ini:

bigclock = true
clear_password = true
box_title = Login to
hide_key_hints = true


## Setup GRUB

Set Options in /etc/default/grub:

GRUB_TIMEOUT=0

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```


## Install and setup Hyprland

```bash
sudo pacman -S hyprland waybar hyprpaper alacritty wofi dolphin ttf-font-awesome ttf-jetbrains-mono-nerd pulseaudio pavucontrol mako nwg-look git openssh
git clone git@github.com:SunaaRisu/Arch-Linux-Install.git
```

Copy hyprland.conf to ~/.config/hypr/hyprland.conf

### Setup Waybar

Copy waybar/config and waybar/style.css to ~/.config/waybar


### Change Theme

```bash
git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git
./Gruvbox-GTK-Theme/themes/install.sh
sudo rm -r Gruvbox-GTK-Theme
gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Dark
```

change both themes in /usr/share/gtk-3.0 to Gruvbox-Dark


### Setup Custom Keyboard

Copy Custom to /usr/share/X11/xkb/symbols/


### Set Wallpaper

Copy images/ to ~/.config/hypr/
Copy hyprpaper.conf ~/.config/hypr/


### Setup bash

Copy bash/.bashrc to ~/








# Post-installation (Awesome [Desktop])

## Install and setup ly

```bash
sudo pacman -S ly xorg-server
sudo systemctl enable ly.service
sudo systemctl start ly.service
```

Set Options in /etc/ly/config.ini:

bigclock = true
clear_password = true
box_title = Login to
hide_key_hints = true


## Setup GRUB

Set Options in /etc/default/grub:

GRUB_TIMEOUT=0

```bash
grub-mkconfig -o /boot/grub/grub.cfg
```


## Install and setup awesomeWM

```bash
sudo pacman -S xorg-server ly awesome alacritty firefox git ttf-jetbrains-mono-nerd
sudo systemctl enable --now ly

git clone git@github.com:SunaaRisu/Arch-Linux-Install.git
```

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

```bash
sudo pacman -S npm cargo unzip
```

Copy all nvim/ to /home/YourUser/.config



# Wifi with NetworkManager

## Normal Wifi

```bash
nmcli device wifi connect _SSID_ --ask
```


## Eduroam

```bash
sudo pacman -S nm-connection-editor
```

Dowload the [CA-Certificate](https://downloads.rz.uni-freiburg.de/myaccount-zugang/usertrust_rsa_certification_authority.pem) from the [University server](https://wiki.uni-freiburg.de/rz/doku.php?id=wlan-eduroam).

```bash
mv USERTrust_RSA_Certification_Authority.pem /usr/share/ca-certificates/trust-source/
```

Open nm-connection-editor in the terminal and click on the plus to add a new connection.

ssid = eduroam </br>
security = wpa/wpa2 enterprise </br>
authentication = PEAP </br>
domain = uni-freiburg.de </br>
certificate = <path to certificate> </br>
username = \<username> </br>
passord = \<password> </br>

