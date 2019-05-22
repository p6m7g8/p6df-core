p6df::modules::core::version() { echo "0.0.1" }
p6df::modules::core::deps()    { ModuleDeps=(p6m7g8/p6common) }
p6df::modules::core::external::brew() { }
p6df::modules::core::home::symlink() {

  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zshenv $P6_DFZ_DATA_DIR/.zshenv
  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zshrc  $P6_DFZ_DATA_DIR/.zshrc
  ln -fs $P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zsh-me $P6_DFZ_DATA_DIR/.zsh-me
}

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

p6df::modules::core::cdpath() {

  cdpath=()
  p6df::util::cdpath_if $P6_DFZ_SRC_DIR
  p6df::util::cdpath_if $P6_DFZ_SRC_P6M7G8_DIR
}

p6df::modules::core::init() {

  p6df::modules::core::path
  p6df::modules::core::cdpath
}
