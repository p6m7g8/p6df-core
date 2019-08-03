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

  p6df::mgmt::iterator "git pull"
}

p6df::mgmt::modules::diff() {

  p6df::mgmt::iterator "git diff"
}

p6df::mgmt::iterator() {
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
