p6df::mgmt::update_all() {

  p6df::mgmt::reload
  p6df::modules::fetch

  p6df::mgmt::reload
  p6df::mgmt::modules::update
  p6df::mgmt::reload
}

p6df::mgmt::reload() {

  p6df::init
}

p6df::mgmt::modules::update() {

  p6df::mgmt::_iterator "git pull"
}

p6df::mgmt::modules::diff() {

  p6df::mgmt::_iterator "git diff"
}

p6df::mgmt::iterator() {
    local include_p6="$1"

    (
      echo "============> $P6_DFZ_SRC_DIR"

      cd $P6_DFZ_SRC_DIR

      local orgs
      if [[ $include_p6 = "p6" ]]; then
	orgs=$(ls -1 | grep -v p6m7g8)
      else
	orgs=$(ls -1)
      fi

      local org
      for org in $(echo $orgs); do
	  (
	    echo "========> $org"
	    cd $P6_DFZ_SRC_DIR/$org
	    local users=$(ls -1)

	    local user
	    for user in $(echo $users); do
		(
		    echo "=====> $org/$user"
		    cd $P6_DFZ_SRC_DIR/$org/$user
		    local crev=$(git log --pretty=format:"%h" -1)
		    git pull
		    local nrev=$(git log --pretty=format:"%h" -1)
		    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative ${crev}..${nrev}
		)
		return
	    done
	  )
      done
    )
}

p6df::mgmt::_iterator() {
  local cmd="$1"
  shift 1

  # @Modules
  p6df::modules::collect

  local module
  for module in $Modules[@]; do
      echo -n "=====> $module: $cmd $@"
      ( cd $P6_DFZ_SRC_DIR/$module
	  # %repo
	  p6df::module::parse "$module"
	  p6df::module::recurse2 "$cmd $@"
	  unset repo
      )
      echo
  done
}
