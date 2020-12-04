######################################################################
#<
#
# Function: p6df::core::modules::recurse::_bootstrap(module, callback)
#
#  Args:
#	module -
#	callback -
#
#>
######################################################################
p6df::core::modules::recurse::_bootstrap() {
    local module="$1"
    local callback="$2"

    if [[ _P6_DFZ_LOADED[$module] -gt 0 ]]; then
      return
    fi

    # %repo
    p6df::core::module::parse "$module"
    p6df::core::module::source "$repo[load_path]" "$repo[extra_load_path]"

    # @ModuleDeps
    unset ModuleDeps
    p6df::util::run::if "$repo[prefix]::deps"
    local dep
    for dep in $ModuleDeps[@]; do
      p6df::core::modules::recurse::_bootstrap "$dep" "$callback"
    done

    # Original Module (tail-recursive, after dep chain)
    # XXX: how to not reparse
    p6df::core::module::parse "$module"
    p6df::util::run::if "p6df::modules::$repo[module]::$callback"
    _P6_DFZ_LOADED[$module]=$(($_P6_DFZ_LOADED[$module]+1))
}

######################################################################
#<
#
# Function: p6df::core::modules::recurse::internal(module, callback)
#
#  Args:
#	module -
#	callback -
#
#>
######################################################################
p6df::core::modules::recurse::internal() {
    local module="$1"
    local callback="$2"

    local t0=$EPOCHREALTIME

    if [[ _P6_DFZ_LOADED_INIT[$module] -gt 0 ]]; then
      local t1=$EPOCHREALTIME
      p6_time "p6df::core::modules::recurse::internal($module): short $(($t1-$t0))"
      return
    fi

    case $module in
      */p6*) ;;
      *) return ;;
    esac

    # %repo
    p6df::core::module::parse "$module"

    # @ModuleDeps
    unset ModuleDeps
    p6df::util::run::if "$repo[prefix]::deps"
    local dep
    for dep in $ModuleDeps[@]; do
      p6df::core::modules::recurse::internal "$dep" "$callback"
    done

    # Original Module (tail-recursive, after dep chain)
    # XXX: how to not reparse
    p6df::core::module::parse "$module"
    local t2=$EPOCHREALTIME
    p6df::util::run::if "p6df::modules::$repo[module]::$callback"
    local t3=$EPOCHREALTIME; p6_time "p6df::modules::$repo[module]::$callback(): $(($t3-$t2))"
    _P6_DFZ_LOADED_INIT[$module]=$(($_P6_DFZ_LOADED_INIT[$module]+1))
    local t1=$EPOCHREALTIME
    p6_time "p6df::core::modules::recurse::internal($module): full $(($t1-$t0))"
}

######################################################################
#<
#
# Function: p6df::core::modules::recurse::callback(module, ..., callback)
#
#  Args:
#	module -
#	... - 
#	callback -
#
#>
######################################################################
p6df::core::modules::recurse::callback() {
    local module="$1"
    shift 1
    local callback="$1"

    if [[ _P6_DFZ_LOADED_CB[$module] -gt 0 ]]; then
      return
    fi

    # %repo
    p6df::core::module::parse "$module"

    # @ModuleDeps
    unset ModuleDeps
    p6df::util::run::if "$repo[prefix]::deps"
    local dep
    for dep in $ModuleDeps[@]; do
      p6df::core::modules::recurse::callback "$dep" "$@"
    done

    # %repo
    p6df::core::module::parse "$module"
    shift 1 # callback
    p6_h3 "$callback($module, org, repo, rest)"
    p6df::util::run::if "$callback" "$module" "$repo[org]" "$repo[repo]" "$@"

    # TODO: XXX: zsh : makes ohmyzsh not unique
    _P6_DFZ_LOADED_CB[$module]=$(($_P6_DFZ_LOADED_CB[$module]+1))
}

######################################################################
#<
#
# Function: p6df::core::modules::recurse::callback::dep(module, ..., callback)
#
#  Args:
#	module -
#	... - 
#	callback -
#
#>
######################################################################
p6df::core::modules::recurse::callback::dep() {
    local module="$1"
    shift 1
    local callback="$1"

    case $module in
      */p6*) ;;
      *) return ;;
    esac

    # %repo
    p6df::core::module::parse "$module"

    # @ModuleDeps
    unset ModuleDeps
    p6df::util::run::if "$repo[prefix]::deps"
    local dep
    for dep in $ModuleDeps[@]; do
      p6df::util::run::if "$callback" "$module" "$dep"
      p6df::core::modules::recurse::callback::dep "$dep" "$@"
    done
}

######################################################################
#<
#
# Function: p6df::core::modules::foreach(callback, ...)
#
#  Args:
#	callback -
#	... - 
#
#>
######################################################################
p6df::core::modules::foreach() {
  local callback="$1"
  shift 1

  unset _P6_DFZ_LOADED_CB
  declare -gA _P6_DFZ_LOADED_CB

  local module
  for module in $Modules[@]; do
    p6df::util::run::code "$callback $module $@"
  done
}

######################################################################
#<
#
# Function: p6df::core::modules::collect()
#
#>
#/ Creates the global Modules array
#/ Allows hook p6df::user::modules::collect to modify Modules
######################################################################
p6df::core::modules::collect() {

  declare -gaU Modules

  p6df::util::run::if "p6df::user::modules"
}

######################################################################
#<
#
# Function: p6df::core::modules::init()
#
#>
######################################################################
p6df::core::modules::init() {

  declare -gA _P6_DFZ_LOADED
  declare -gA _P6_DFZ_LOADED_INIT

  p6df::util::run::if "p6df::user::modules::init::pre"
  p6df::core::modules::init::start
  p6df::util::run::if "p6df::user::modules::init::post"
}

######################################################################
#<
#
# Function: p6df::core::modules::init::start()
#
#>
######################################################################
p6df::core::modules::init::start() {

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::module::init::start"
}

######################################################################
#<
#
# Function: p6df::core::modules::fetch()
#
#>
######################################################################
p6df::core::modules::fetch() {

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::module::fetch"
}

######################################################################
#<
#
# Function: p6df::core::modules::pull()
#
#>
######################################################################
p6df::core::modules::pull() {

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::module::pull"
}

######################################################################
#<
#
# Function: p6df::core::modules::push()
#
#>
######################################################################
p6df::core::modules::push() {

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::module::push"
}

######################################################################
#<
#
# Function: p6df::core::modules::sync()
#
#>
######################################################################
p6df::core::modules::sync() {

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::module::sync"
}

######################################################################
#<
#
# Function: p6df::core::modules::status()
#
#>
######################################################################
p6df::core::modules::status() {

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::module::status"
}

######################################################################
#<
#
# Function: p6df::core::modules::diff()
#
#>
######################################################################
p6df::core::modules::diff() {

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::module::diff"
}

p6df::core::modules::langs() {

  # @Modules
  p6df::core::modules::collect

  local -A _P6_DFZ_LOADED_INIT
  p6df::core::modules::foreach "p6df::core::module::langs"
}
