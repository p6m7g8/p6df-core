# shellcheck shell=zsh
######################################################################
#<
#
# Function: p6df::modules::core::version()
#
#>
######################################################################
p6df::modules::core::version() { echo "0.0.1" }
######################################################################
#<
#
# Function: p6df::modules::core::deps()
#
#>
######################################################################
p6df::modules::core::deps()    { ModuleDeps=(p6m7g8/p6common) }
######################################################################
#<
#
# Function: p6df::modules::core::home::symlink()
#
#>
######################################################################
p6df::modules::core::home::symlink() {

  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zshrc  $P6_DFZ_DATA_DIR/.zshrc
  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zshenv $P6_DFZ_DATA_DIR/.zshenv-xdg
#  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zsh-me $P6_DFZ_DATA_DIR/.zsh-me
}

######################################################################
#<
#
# Function: p6df::modules::core::path()
#
#>
######################################################################
p6df::modules::core::path() {

  path=()
  p6df::util::path_if /opt/X11/bin
  p6df::util::path_if /usr/local/bin
  p6df::util::path_if /usr/local/sbin
  p6df::util::path_if /usr/bin
  p6df::util::path_if /usr/sbin
  p6df::util::path_if /bin
  p6df::util::path_if /sbin
}

######################################################################
#<
#
# Function: p6df::modules::core::cdpath()
#
#>
######################################################################
p6df::modules::core::cdpath() {

  cdpath=()
  p6df::util::cdpath_if $P6_DFZ_SRC_DIR
  p6df::util::cdpath_if $P6_DFZ_SRC_P6M7G8_DIR
}

######################################################################
#<
#
# Function: p6df::modules::core::aliases()
#
#>
######################################################################
p6df::modules::core::aliases() {

  alias p6df_r="p6df::init"

  alias p6df_i="p6df::mgmt::iterator"
  alias p6df_u="p6df::mgmt::update"

  alias p6df_mu="p6df::mgmt::modules::update"
  alias p6df_md="p6df::mgmt::modules::diff"
  alias p6df_mp="p6df::mgmt::modules::pull"
  alias p6df_mP="p6df::mgmt::modules::push"
  alias p6df_mS="p6df::mgmt::modules::sync"
  alias p6df_ms="p6df::mgmt::modules::status"
}

######################################################################
#<
#
# Function: p6df::modules::core::dirs()
#
#>
######################################################################
p6df::modules::core::dirs() {

  mkdir -p $ZSH_CACHE_DIR  
}

######################################################################
#<
#
# Function: p6df::modules::core::init()
#
#>
######################################################################
p6df::modules::core::init() {

  p6df::modules::core::dirs
  p6df::modules::core::path
  p6df::modules::core::cdpath
  p6df::modules::core::aliases
}