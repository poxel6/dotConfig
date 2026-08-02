# My Linux Configurations

## Installation
Symlinks are setup with `stow`
Install `stow` first
<module> can be any of the directories inside the repe

```sh
git clone https://poxel6/dotConfig
cd dotConfig
stow <module>
```
#### Requirements

```sh
sudo pacman -Syu \
base-devel tmux ncdu jq git-delta \
grub grub-btrfs intel-ucode snap-pac snapper \
emacs neovim \
go rustup fasm gf2 \
man-db man-pages \
pacman-contrib\
fd fastfetch ripgrep eza fzf stow tokei bat cliphist \
--noconfirm
```

Drivers
```sh
sudo pacman -Syu \
fuse3 ntfs-3g \
mesa vulkan-headers vulkan-mesa-layers vulkan-radeon \
lib32-gamemode lib32-mangohud lib32-vulkan-radeon \
mangohud gamemode gamescope cpupower \
schedtool scx-scheds scx-tools \
--noconfirm
```

```sh
sudo pacman -Syu \
pipewire pipewire-pulse pwvucontrol wireplumber mpv mpv-mpris \
--noconfirm
```

Hyprland
```sh
sudo pacman -S \
hyprcursor hypridle hyprland hyprlock hyprshade hyprpolkitagent xdg-desktop-portal-hyprland \
wf-recorder btop imv nemo ly awww swaync swayosd \
nwg-look pastel network-manager-applet \
starship android-file-transfer keyd \
--noconfirm
```


AUR
```sh
yay -S \
grimblast-git \
heroic-games-launcher-bin ludusavi-bin \
vkd3d-proton-bin dxvk-bin \
--noconfirm
```


Walker
```sh
walker
elephant-bitwarden-bin
elephant-calc-bin
elephant-clipboard-bin
elephant-desktopapplications-bin
elephant-files-bin
elephant-providerlist-bin
elephant-runner-bin
elephant-symbols-bin
```
