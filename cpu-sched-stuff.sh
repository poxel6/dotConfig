# sudo echo "SCX_SCHEDULER=scx_lavd" >> /etc/default/scx
sudo systemctl enable --now scx_loader.service
# addedthese to /etc/sudoers.d/scx
# pox ALL=(root) NOPASSWD: /usr/bin/scx_lavd
# pox ALL=(root) NOPASSWD: /usr/bin/scx_bpfland
# pox ALL=(root) NOPASSWD: /usr/bin/pkill
#
# add to /etc/default/cpupower
# governor='performance'
# sudo systemctl enable --now cpupower.service
