<!-- sudo grub-mkfont -o /boot/grub/fonts/iosevka.pf2 -s 20 /usr/share/fonts/TTF/IosevkaNerdFontMono-Regular.ttf -->
sudo grub-mkfont -s 24 -o /boot/grub/fonts/liberation.pf2 /usr/share/fonts/liberation/LiberationMono-Regular.ttf

/etc/default/grub
GRUB_BACKGROUND="/home/conch/Pictures/Wallpapers/lion_galaxy_purple.jpg"
GRUB_FONT=/boot/grub/fonts/dejavu20.pf2


GRUB_GFXMODE=1920x1080x32
GRUB_DISABLE_SUBMENU=y

sudo grub-mkconfig -o /boot/grub/grub.cfg
