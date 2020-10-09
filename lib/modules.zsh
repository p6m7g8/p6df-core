# ----------------------------------------------------------------------------------------------------
# Install
# run p6dfz/bin/bootstrap [ghurl]
# run p6df::modules::fetch()
# run p6df::modules::external_deps()
# run p6df::modules::symlink()
# run p6df::modules::langs()

#
# $ZDOTDIR/.zshrc (entry point - conf/.zshrc)
#  p6df::util::user::init
#
#  p6df::modules::pre_init
#  p6df::modules::bootstrap
#
#    p6df::module::pre_init (ea)
#    p6df::module::init (ea)
#    p6df::module::post_init (ea)
#
#  p6df::modules::post_init
#
#  p6df::theme::init
#  p6df::prompt::init
#

# Load loads file(s)
# Init runs setup code(s)
# File runs no code by itself

# modules::bootstrap()
#   modules::collect()
#   foreach module
#     module::load() <--------------------------+
#       module::act()                           |
#         module::parse()                       |
#         task                                  |
#	  module::recurse()                     |
#           p6df::modules::$module::deps()      |
#	    foreach module_dep                  |
#	      module::load() -------------------+
#     module::init()
#       module::act() [FAKE]
#         module::parse()
#         p6df::module::$module::init() <-------+
#         module::recurse()                     |
#           p6df::modules::$module::deps()      |
#           module::init -----------------------+

######################################################################
#<
#
# Function: p6df::modules::pre_init()
#
#>
######################################################################
p6df::modules::pre_init() {

  p6df::util::exists "p6df::user::modules::pre_init" && p6df::user::modules::pre_init
}

######################################################################
#<
#
# Function: p6df::modules::post_init()
#
#>
######################################################################
p6df::modules::post_init() {

  p6df::util::exists "p6df::user::modules::post_init" && p6df::user::modules::post_init
}

######################################################################
#<
#
# Function: p6df::modules::bootstrap()
#
#>
######################################################################
p6df::modules::bootstrap() {

  # @Modules
  p6df::modules::collect

  local module
  for module in $Modules[@]; do
      p6df::module::load      "$module" "$P6_DFZ_SRC_DIR"
      p6df::module::pre_init  "$module" "$P6_DFZ_SRC_DIR"
      p6df::module::init      "$module" "$P6_DFZ_SRC_DIR"
  done

  for module in $Modules[@]; do
      p6df::module::post_init "$module" "$P6_DFZ_SRC_DIR"
  done

  export P6_DFZ_MODULES=${(j: :)Modules}

  # Intentionally not cleaning @Modules
}

######################################################################
#<
#
# Function: p6df::modules::collect()
#
#>
#/ Creates the global Modules array
#/ Allows hook p6df::user::modules to modify Modules
######################################################################
p6df::modules::collect() {

  declare -gaU Modules
  local -aU required_modules=(p6m7g8/p6df-core)

  p6df::util::exists "p6df::user::modules" && p6df::user::modules

  Modules=($required_modules[@] $Modules[@])
}

######################################################################
#<
#
# Function: p6df::modules::foreach(callback)
#
#  Args:
#	callback - 
#
#>
#/ Recurses through all modules running callback for each
######################################################################
p6df::modules::foreach() {
  local callback="$1"
  shift

  # @Modules
  p6df::modules::collect

  local module
  for module in $Modules[@]; do
      eval "$callback \"$module\" \"$@\" "
  done

  # cleanup
  unset Modules
}

# ---------------------------------------------------------------------------------------------------

######################################################################
#<
#
# Function: p6df::modules::fetch()
#
#>
#/ "Clones" code to `src` dir for all modules
######################################################################
p6df::modules::fetch() {

  p6df::modules::foreach "p6df::module::fetch" "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::pull()
#
#>
#/ "Pulls" code to `src` dir for all modules
######################################################################
p6df::modules::pull() {

  p6df::modules::foreach "p6df::module::pull" "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::external_deps()
#
#>
#/ Installs external recurse for all modules
######################################################################
p6df::modules::external_deps() {

  p6df::util::pm::homebrew::install

  p6df::modules::foreach "p6df::module::external_deps"
}

######################################################################
#<
#
# Function: p6df::modules::symlink()
#
#>
#/ Symlinks from $HOME to relevant files/dirs for all modules
######################################################################
p6df::modules::symlink() {

  p6df::modules::foreach "p6df::module::symlink" "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::unlink()
#
#>
#/ Unlink from $HOME for all modules
######################################################################
p6df::modules::unlink() {

  p6df::modules::foreach "p6df::module::unlink" "$P6_DFZ_SRC_DIR"
}

######################################################################
#<
#
# Function: p6df::modules::langs()
#
#>
#/ For *env build requested versions, set global
######################################################################
p6df::modules::langs() {

  p6df::modules::foreach "p6df::module::lang" "$P6_DFZ_SRC_DIR"
}