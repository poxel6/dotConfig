pkg="base-devel git"
check_if_go_is_installed() {
	if [[ -f '/usr/bin/go' || -f '/bin/go' ]]; then
		echo 'go is installed; proceeding.'
	else
		pkg="$pkg go"
	fi
}

check_if_aur_is_accessible() {
	stat=$(ping -c 5 aur.archlinux.org &> /dev/null && echo 0)
	if [[ $stat != 0 ]]; then
		echo 'aur is not accessible at the moment.'
		exit 1
	fi
}

install_yay() {
	if [[ -f '/usr/bin/yay' || -f '/bin/yay' ]]; then
		echo 'yay is installed; there is nothing to do.'
		exit 0
	else
		echo 'Cloning into yay.'
		d=$(date +"%Y-%m-%d_%H_%M_%S")
		mkdir -p /tmp/yay-$d
		check_if_aur_is_accessible
		git clone https://aur.archlinux.org/yay.git /tmp/yay-$d
		cd /tmp/yay-$d
		check_if_go_is_installed
		sudo pacman -S $pkg --noconfirm
		makepkg -si
		rm -rf /tmp/yay-$d
	fi
}



install_yay
