# ArchPostInstall
## Install DM, WM and basic packages
sudo pacman -S sddm ly awesome alacritty firefox git neofetch
sudo pacman -R sddm
sudo systemctl enable --now ly

git clone git@github.com:SunaaRisu/ArchPostInstall.git

## make awesome usable
1. Copy all files from here/Xorg to YourPC/etc/X11/xorg.conf.d

    00.keyboard.conf                    // changes keyboard layout to Dvorak (change if needed)
    10.monitors.conf                    // changes monitor layout (change if needed (use xrandr and arandr (ui)))

2. Copy all files from here/scripts to YourPC/bin

    set-refresh-rate.sh                 // sets refresh rate of DP-3 to 120Hz (change if needed)

3. Copy all background images from here/images/backgrounds to /usr/share/backgrounds
