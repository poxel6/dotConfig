/etc/snapper/configs/root
these 👇️ into this 👆️
NUMBER_CLEANUP="yes"
NUMBER_LIMIT="10-15"
NUMBER_LIMIT_IMPORTANT="3"

TIMELINE_CREATE="yes"
TIMELINE_CLEANUP="yes"

TIMELINE_LIMIT_HOURLY="12"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="0"
TIMELINE_LIMIT_MONTHLY="1"
TIMELINE_LIMIT_QUARTERLY="0"
TIMELINE_LIMIT_YEARLY="0"

SPACE_LIMIT="8G"
FREE_LIMIT="20G"

sudo snapper setup-quota
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
