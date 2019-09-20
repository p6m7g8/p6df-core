p6df::mgmt::update_all() {

  p6df::mgmt::reload
  p6df::modules::fetch

  p6df::mgmt::reload
  p6df::mgmt::modules::pull
  p6df::mgmt::reload
}

p6df::mgmt::reload() {

  p6df::init
}

p6df::mgmt::modules::pull() {

  p6df::mgmt::iterator "git pull"
}

p6df::mgmt::modules::diff() {

  p6df::mgmt::iterator "git diff"
}

p6df::mgmt::modules::push() {

  p6df::mgmt::iterator "git push"
}

p6df::mgmt::iterator() {

    (
	echo "==> $P6_DFZ_SRC_P6M7G8_DIR"
	cd $P6_DFZ_SRC_P6M7G8_DIR

	local repo
	for repo in $(cd . ; ls -1); do
	    (
		echo "=====> $repo"
		cd $P6_DFZ_SRC_P6M7G8_DIR/$repo
		eval "$@"
	    )
	done
    )
}
