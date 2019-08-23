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
	p6_msg "==> $P6_DFZ_SRC_P6M7G8_DIR"
	cd $P6_DFZ_SRC_P6M7G8_DIR

	local repo
	for repo in $(p6_dirs_list "."); do
	    (
		p6_msg "=====> $repo"
		cd $P6_DFZ_SRC_P6M7G8_DIR/$repo
		p6_log_and_run "$@"
	    )
	done
    )
}

# local crev=$(git log --pretty=format:"%h" -1)
# git pull
# local nrev=$(git log --pretty=format:"%h" -1)
# git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative ${crev}..${nrev}
