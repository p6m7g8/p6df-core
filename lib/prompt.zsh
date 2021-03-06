######################################################################
#<
#
# Function: p6df::core::prompt::init()
#
#>
######################################################################
p6df::core::prompt::init() {
  p6df::util::run::if "p6df::user::prompt"

  p6df::core::prompt::process
}

######################################################################
#<
#
# Function: p6df::core::prompt::process()
#
#  Environment:	 PROMPT
#>
######################################################################
p6df::core::prompt::process() {

  setopt prompt_subst
  PROMPT="\$(p6df::prompt::runtime $PromptLines[@])"
  PROMPT="
$PROMPT
"
}

######################################################################
#<
#
# Function: p6df::prompt::runtime(...)
#
#  Args:
#	... - 
#
#  Depends:	 p6_echo p6_log p6_string
#>
######################################################################
p6df::prompt::runtime() {
  shift 0

  local lf
  for lf in "$@"; do
    local func="$lf"
    p6_log "$func"
    local cnt=$(p6df::util::run::if "$func")
    if ! p6_string_blank "$cnt"; then
      p6_echo "$cnt"
    fi
  done
}
