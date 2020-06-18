# shellcheck shell=zsh

p6df::mgmt::update() {

  p6df::mgmt::modules::update
}

p6df::mgmt::modules::update() {

  p6df::init
  p6df::modules::fetch
  p6df::modules::pull
  p6df::init
}

p6df::mgmt::modules::diff() {

  p6df::mgmt::iterator "p6_git_p6_diff"
}

p6df::mgmt::modules::pull() {

  p6df::mgmt::iterator "p6_git_p6_pull"
}

p6df::mgmt::modules::push() {

  p6df::mgmt::iterator "p6_git_p6_push"
}

p6df::mgmt::modules::sync() {

  p6df::mgmt::iterator "p6_git_p6_sync"
}

p6df::mgmt::iterator() {

	local remote_repos
	remote_repos=$(p6_github_api_org_repos_list "https://api.github.com" "p6m7g8")

	local local_repos
	local_repos=$(p6_dir_list "$P6_DFZ_SRC_P6M7G8_DIR")

	local unique_repos
	unique_repos=$(p6_word_unique "$local_repos" "$remote_repos")

	local repo
	for repo in $(echo "$unique_repos"); do
		p6_h1 "$repo"
	    p6_run_yield "p6df::mgmt::iterator::execute $P6_DFZ_SRC_P6M7G8_DIR/$repo $@"
	done
}

p6df::mgmt::iterator::execute() {
	local dir="$1"
	shift 1

	local repo
	repo=$(basename "$dir")
	if ! p6_dir_exists "$dir"; then
		gh repo clone p6m7g8/$repo $dir
	fi

	(
		cd $dir	
		p6_run_code "$@"
	)
}
