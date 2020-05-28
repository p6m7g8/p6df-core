<<<<<<< HEAD
# shellcheck shell=zsh

p6df::mgmt::other::modules::update_all() {

  p6df::mgmt::other::iterator "p6_git_p6_pulll"
}

=======
p6df::mgmt::other::modules::update_all() {

  p6df::mgmt::other::iterator "git pull"
}


>>>>>>> feature(mgmt): expose api to update non p6m7g8 modules
p6df::mgmt::other::iterator() {

    (
	echo "==> $P6_DFZ_SRC_DIR"
	cd $P6_DFZ_SRC_DIR

	local org
	for org in $(cd . ; ls -1 | grep -v p6m7g8); do
	    (
		echo "==[org]> $org"
		cd $P6_DFZ_SRC_DIR/$org
		local repo
		for repo in $(cd . ; ls -1); do
		    (
			echo "==[repo]> $repo"
			cd $repo
			eval "$@"
		    )
		done
	    )
	done
    )
}

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

	# Step one pull the repo repos
	local remote_repos
	remote_repos=$(p6_github_api_org_repos_list "https://api.github.com" "p6m7g8")

	local local_repos
	local_repos=$(p6_dir_list "$P6_DFZ_SRC_P6M7G8_DIR")

	local unique_repos
	unique_repos=$(echo "$local_repos" "$remote_repos" | sort -u)
	
	local repo
	for repo in $(echo "$unique_repos"); do
		p6_h1 "$repo"
		p6_run_yield "p6df::mgmt::iterator::execute $P6_DFZ_SRC_P6M7G8_DIR/$repo $@"
	done
<<<<<<< HEAD
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
=======
    )
}
<<<<<<< HEAD
>>>>>>> chore(docs): regen (#4)
=======
>>>>>>> Revert "chore(docs): regen (#4)"
