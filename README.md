# ArchPostInstall
## Install DM, WM and basic packages
sudo pacman -S sddm ly awesome alacritty firefox git neofetch
sudo pacman -R sddm
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