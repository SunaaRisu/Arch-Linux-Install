# Arch Install

[Encrypted Install](https://gist.github.com/mjnaderi/28264ce68f87f52f2cabb823a503e673)
[Comfy Install](https://www.youtube.com/watch?v=68z11VAYMS8)


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
