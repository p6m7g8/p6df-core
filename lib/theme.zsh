######################################################################
#<
#
# Function: p6df::theme::init()
#
#>
######################################################################
p6df::theme::init() {

  p6df::util::exists "p6df::user::theme" && p6df::user::theme

  export P6_DFZ_THEME=theme
}