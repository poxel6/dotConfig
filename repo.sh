base_path="$HOME/Personal"
clone_repo_if_dont_exist() {
	if [[ -d "$base_path/$(basename $1)" ]]; then
		echo "repo already exist: $1 "
	else
		echo " -------- cloning to $base_path/$(basename $1) -------- "
		git clone git@github.com:$1 "$base_path/$(basename $1)"
		echo " -------- ==================================== -------- "
		echo
	fi
}

clone_repo_if_dont_exist poxel6/clox
clone_repo_if_dont_exist poxel6/twitter-clone
clone_repo_if_dont_exist poxel6/newj
clone_repo_if_dont_exist desktop-pets/pets
