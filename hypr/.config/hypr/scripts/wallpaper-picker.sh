#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="${HOME}/Pictures/Wallpapers"

# Change this if you keep the theme somewhere else.
ROFI_THEME="${HOME}/.config/rofi/wallpaper-picker.rasi"

usage() {
	cat <<EOF
Usage:
    $(basename "$0")                    Open interactive Rofi picker
    $(basename "$0") random              Pick a random wallpaper
    $(basename "$0") random <category>   Pick a random wallpaper from category

Examples:
    $(basename "$0")
    $(basename "$0") random
    $(basename "$0") random batman
EOF
}

# Recursively find all supported image files.
find_images() {
	local directory="$1"

	find "$directory" \
		-type f \
		\( \
		-iname '*.jpg' -o \
		-iname '*.jpeg' -o \
		-iname '*.png' -o \
		-iname '*.webp' -o \
		-iname '*.gif' -o \
		-iname '*.bmp' \
		\) \
		-print
}

# Get all direct subdirectories of WALLPAPER_DIR.
get_categories() {
	find "$WALLPAPER_DIR" \
		-mindepth 1 \
		-maxdepth 1 \
		-type d \
		-printf '%f\n' |
		sort
}

# Pick a random wallpaper from a directory.
random_wallpaper() {
	local directory="$1"

	local wallpaper
	wallpaper="$(
		find_images "$directory" |
			shuf -n 1
	)"

	if [[ -z "$wallpaper" ]]; then
		printf 'error: no wallpapers found in: %s\n' \
			"$directory" >&2
		return 1
	fi

	printf '%s\n' "$wallpaper"
}

# Explicitly select a wallpaper using Rofi.
#
# The visible entry looks like:
#
#     Batman Begins.jpg    [batman]
#
# The full path is NEVER displayed in Rofi.
#
# Rofi returns the zero-based index of the selected entry.
# We then use that index to retrieve the original full path.
#
# This means:
#
#     Rofi UI:
#         Batman Begins.jpg [batman]
#
#     Script stdout:
#         /home/conch/Pictures/Wallpapers/batman/Batman Begins.jpg
#
select_wallpaper() {
	local -a wallpapers=()

	local path
	local filename
	local category
	local relative
	local selected_index

	# Store all image paths in an array.
	#
	# The array index becomes the identifier we use to map
	# Rofi's selected index back to the original full path.
	while IFS= read -r path; do
		wallpapers+=("$path")
	done < <(
		find_images "$WALLPAPER_DIR" |
			sort
	)

	# Nothing to select.
	if [[ "${#wallpapers[@]}" -eq 0 ]]; then
		printf 'error: no wallpapers found in: %s\n' \
			"$WALLPAPER_DIR" >&2
		return 1
	fi

	# Generate the Rofi entries.
	#
	# Each entry contains:
	#
	#     filename    [category]
	#
	# The full path is only used for the thumbnail.
	#
	# Rofi's -format i makes it return the zero-based
	# index of the selected entry instead of the visible text.
	selected_index="$(
		{
			for path in "${wallpapers[@]}"; do
				filename="$(basename "$path")"

				relative="${path#"$WALLPAPER_DIR"/}"

				# The first path component relative to
				# WALLPAPER_DIR is the category.
				category="${relative%%/*}"

				printf '%s [%s]\0icon\x1fthumbnail://%s\n' \
					"$filename" \
					"$category" \
					"$path"
			done
		} |
			rofi \
				-dmenu \
				-i \
				-p "Wallpaper" \
				-show-icons \
				-format i \
				-theme "$ROFI_THEME"
	)"

	# User pressed Escape.
	if [[ -z "$selected_index" ]]; then
		return 1
	fi

	# Return ONLY the full path.
	printf '%s\n' "${wallpapers[$selected_index]}"
}

# Interactive Rofi picker.
#
# Menu:
#
#     select
#     anime
#     batman
#     landscapes
#
# Selecting a category immediately returns a random wallpaper.
# Selecting "select" opens the visual wallpaper picker.
interactive_mode() {
	local choice

	choice="$(
		{
			printf '%s\n' "select"
			get_categories
		} |
			rofi \
				-dmenu \
				-i \
				-p "Wallpaper"
	)"

	# User pressed Escape.
	[[ -z "$choice" ]] && return 1

	if [[ "$choice" == "select" ]]; then
		select_wallpaper
	else
		random_wallpaper "$WALLPAPER_DIR/$choice"
	fi
}

main() {
	if [[ ! -d "$WALLPAPER_DIR" ]]; then
		printf 'error: wallpaper directory does not exist: %s\n' \
			"$WALLPAPER_DIR" >&2
		exit 1
	fi

	case "$#" in
	0)
		interactive_mode
		;;

	1)
		case "$1" in
		random)
			random_wallpaper "$WALLPAPER_DIR"
			;;

		-h | --help | help)
			usage
			;;

		*)
			printf 'error: unknown argument: %s\n\n' \
				"$1" >&2
			usage >&2
			exit 2
			;;
		esac
		;;

	2)
		if [[ "$1" != "random" ]]; then
			printf 'error: expected "random" as first argument\n\n' \
				>&2
			usage >&2
			exit 2
		fi

		category="$2"
		directory="$WALLPAPER_DIR/$category"

		if [[ ! -d "$directory" ]]; then
			printf 'error: category does not exist: %s\n' \
				"$category" >&2
			exit 1
		fi

		random_wallpaper "$directory"
		;;

	*)
		printf 'error: too many arguments\n\n' >&2
		usage >&2
		exit 2
		;;
	esac
}

main "$@"

