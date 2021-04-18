######################################################################
#<
#
# Function: p6df::core::path::init()
#
#  Environment:	 X11
#>
######################################################################
p6df::core::path::init() {

  path=()
  p6df::util::path::if /opt/X11/bin
  p6df::util::path::if /usr/local/bin
  p6df::util::path::if /usr/local/sbin
  p6df::util::path::if /usr/bin
  p6df::util::path::if /usr/sbin
  p6df::util::path::if /bin
  p6df::util::path::if /sbin
}

######################################################################
#<
#
# Function: p6df::core::path::cd::init()
#
#  Environment:	 P6_DFZ_SRC_DIR P6_DFZ_SRC_P6M7G8_DIR
#>
######################################################################
p6df::core::path::cd::init() {

  cdpath=()
  p6df::util::cdpath::if $P6_DFZ_SRC_DIR
  p6df::util::cdpath::if $P6_DFZ_SRC_P6M7G8_DIR
  p6df::util::cdpath::if $P6_DFZ_SRC_WORK_DIR

  p6df::util::cdpath::if $P6_DFZ_SRC_ORIGINAL_DIR
  p6df::util::cdpath::if $P6_DFZ_SRC_ORIGINAL_DIR/p6m7g8
  p6df::util::cdpath::if $P6_DFZ_SRC_ORIGINAL_DIR/pgollucci

  p6df::util::cdpath::if $P6_DFZ_SRC_FOCUSED_DIR

  p6df::util::cdpath::if $P6_DFZ_SRC_FORKED_DIR/pgollucci

  p6df::util::cdpath::if $P6_DFZ_SRC_MISC_DIR
}
