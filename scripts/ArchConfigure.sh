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

# Ly config
pacman -S ly
systemctl enable ly.service

sed -i 's/bigclock = false/bigclock = true' /etc/ly/config.ini
sed -i 's/clear_password = false/clear_password = true' /etc/ly/config.ini
sed -i 's/box_title = null/box_title = Login to' /etc/ly/config.ini
sed -i 's/hide_key_hints = false/hide_key_hints = true' /etc/ly/config.ini

# Grub config
sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# Hyprland config

sudo pacman -S hyprland waybar hyprpaper alacritty wofi dolphin ttf-font-awesome ttf-jetbrains-mono-nerd pulseaudio pavucontrol mako nwg-look git openssh
git clone https://github.com/SunaaRisu/Arch-Linux-Install.git
cp ./Arch-Linux-Install/Arch-Hyprland-WM/Laptop/hyprland.conf /home/sunaa/.config/hypr/hyprland.conf
cp ./Arch-Linux-Install/Arch-Hyprland-WM/Laptop/waybar/config /home/sunaa/.config/waybar/config
cp ./Arch-Linux-Install/Arch-Hyprland-WM/Laptop/waybar/style.css /home/sunaa/.config/waybar/style.css

git clone https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme.git
./Gruvbox-GTK-Theme/themes/install.sh
sudo rm -r Gruvbox-GTK-Theme
gsettings set org.gnome.desktop.interface gtk-theme Gruvbox-Dark
sed -i 's/gtk-icon-theme-name = Adwaita/gtk-icon-theme-name = Gruvbox-Dark' /usr/share/gtk-3.0/settings.ini
sed -i 's/gtk-theme-name = Adwaita/gtk-theme-name = Gruvbox-Dark' /usr/share/gtk-3.0/settings.ini
sed -i 's/gtk-icon-theme-name = Adwaita/gtk-icon-theme-name = Gruvbox-Dark' /usr/share/gtk-4.0/settings.ini
sed -i 's/gtk-theme-name = Adwaita/gtk-theme-name = Gruvbox-Dark' /usr/share/gtk-4.0/settings.ini

cp ./Arch-Linux-Install/Arch-Hyprland-WM/Laptop/kb/custom /usr/share/X11/xkb/symbols/custom
cp -r ./Arch-Linux-Install/images/ /home/sunaa/.config/hypr/
cp Arch-Linux-Install/Arch-Hyprland-WM/Laptop/hyprpaper.conf /home/sunaa/.config/hypr/hyprpaper.conf
cp ./Arch-Linux-Install/.bashrc /home/sunaa/

pacman -S npm cargo unzip
cp -r ./Arch-Linux-Install/nvim/ /home/sunaa/.config/

mkdir aur
cd aur
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si




exit
umount -a
reboot
