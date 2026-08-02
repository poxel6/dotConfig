# BASE
base() {
	echo "Installing base packages..."
	sudo pacman -Syu \
		base-devel tmux ncdu jq git-delta \
		grub grub-btrfs intel-ucode snap-pac snapper \
		emacs neovim \
		go rustup fasm \
		man-db man-pages \
		pacman-contrib fd fastfetch ripgrep eza fzf stow tokei bat cliphist \
		--noconfirm
	echo "Finished installing base packages..."
}

# DRIVERS
drivers() {
	echo "Installing drivers packages..."
	sudo pacman -Syu \
		fuse3 ntfs-3g \
		mesa vulkan-headers vulkan-mesa-layers vulkan-radeon \
		lib32-gamemode lib32-mangohud lib32-vulkan-radeon \
		mangohud gamemode gamescope cpupower \
		schedtool scx-scheds scx-tools \
		--noconfirm
	echo "Finished installing drivers packages..."
}

# AUDIO
audio() {
	echo "Installing audio packages..."
	sudo pacman -Syu \
		pipewire pipewire-pulse wireplumber mpv mpv-mpris \
		--noconfirm
	echo "Finished installing audio packages..."
}

# HYPRLAND
hyprland() {
	echo "Installing hyprland packages..."
	sudo pacman -S \
		hyprcursor hypridle hyprland hyprlock hyprpolkitagent xdg-desktop-portal-hyprland \
		wf-recorder btop imv nemo ly awww swaync swayosd \
		nwg-look pastel network-manager-applet \
		starship android-file-transfer keyd \
		--noconfirm
	echo "Finished installing hyprland packages..."
}

# AUR
aur() {
	echo "Installing aur packages..."
	yay -S \
		gf2 \
		grimblast-git hyprshade pwvucontrol \
		heroic-games-launcher-bin ludusavi-bin \
		vkd3d-proton-bin dxvk-bin \
		--noconfirm
	echo "Finished installing aur packages..."
}

# WALKER
walker() {
	echo "Installing walker packages..."
	yay -S \
		walker \
		elephant-bitwarden-bin \
		elephant-calc-bin \
		elephant-clipboard-bin \
		elephant-desktopapplications-bin \
		elephant-files-bin \
		elephant-providerlist-bin \
		elephant-runner-bin \
		elephant-symbols-bin \
		--noconfirm
	echo "Finished installing walker packages..."
}

base
drivers
audio
hyprland
aur
walker
