######################################################################
#<
#
# Function: p6df::module::recurse(callback, ...)
#
#  Args:
#	callback - 
#	... - 
#
#>
######################################################################
p6df::module::recurse() {
  local callback="$1"
  shift 1

  ## @ModuleDeps
  local -aU ModuleDeps

  # XXX: should be tail-recursive
  p6df::util::exists "$repo[prefix]::deps" && $repo[prefix]::deps

  local dep
  for dep in $ModuleDeps[@]; do
#      echo eval "[$callback] [\"$dep\"] [\"$@\"] "
      eval "$callback \"$dep\" \"$@\" "
  done

  # cleanup
  unset ModuleDeps
}

######################################################################
#<
#
# Function: p6df::module::act(module, module_function, callback)
#
#  Args:
#	module - 
#	module_function - 
#	callback - 
#
#>
######################################################################
p6df::module::act() {
  local module="$1"
  local module_function="$2"
  local callback="$3"

  # %repo
  p6df::module::parse "$module"
  p6df::util::exists "p6df::modules::$repo[module]::$module_function" && p6df::modules::$repo[module]::$module_function
  p6df::module::recurse "$callback" "$@"

  # cleanup
  unset repo
}

######################################################################
#<
#
# Function: p6df::module::parse(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::parse() {
  local module="$1"

  declare -gA repo

  repo[repo]=${${module%%:*}##*/}            # org/(repo)
  repo[proto]=https
  repo[host]=github.com                      # XXX:
  repo[org]=${module%%/*}                    # (org)/repo
  repo[path]=$repo[org]/$repo[repo]          # (org/repo)
  repo[version]=master

  repo[module]=${repo[repo]##p6df-}          # p6df-(repo)
  repo[prefix]=p6df::modules::$repo[module]  # p6df::modules::(repo) without p6df-
  repo[sub]=${module##*:}                    # subdir file path : sep

  repo[ns]=$repo[repo]                       # shell namespace
  repo[plugin]=${repo[sub]##*/}              # subdir plugin up to first /

  if [[ $repo[repo] =~ ^p6 ]]; then
    repo[load_path]=$repo[path]/init.zsh
  elif [[ $repo[org] = ohmyzsh ]]; then
      if [[ $repo[sub] =~ lib ]]; then
	      repo[load_path]=$repo[path]/$repo[sub].zsh
      else
	      repo[load_path]=$repo[path]/$repo[sub]/$repo[plugin].plugin.zsh
      fi
  elif [[ $repo[repo] = prezto ]]; then
      repo[load_path]=$repo[path]/$repo[sub]/init.zsh
      repo[extra_load_path]=$repo[path]/init.zsh
  else
      repo[load_path]=$repo[path]/$repo[plugin].plugin.zsh
  fi
}

######################################################################
#<
#
# Function: p6df::module::external_deps(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::external_deps() {
  local module="$1"

  p6df::module::act "$module" "external::brew" "p6df::module::external_deps"
}

######################################################################
#<
#
# Function: p6df::module::symlink(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::symlink() {
  local module="$1"

  p6df::module::act "$module" "home::symlink" "p6df::module::symlink"
}

######################################################################
#<
#
# Function: p6df::module::unlink(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::unlink() {
  local module="$1"

  p6df::module::act "$module" "home::unlink" "p6df::module::unlink"
}

######################################################################
#<
#
# Function: p6df::module::lang(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::lang() {
  local module="$1"

  p6df::module::act "$module" "langs" "p6df::module::lang"
}

######################################################################
#<
#
# Function: p6df::module::init(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::init() {
  local module="$1"

  p6df::module::act "$module" "init" "p6df::module::init"
}

######################################################################
#<
#
# Function: p6df::module::pre_init(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::pre_init() {
  local module="$1"

  p6df::module::act "$module" "pre_init" "p6df::module::pre_init"
}

######################################################################
#<
#
# Function: p6df::module::post_init(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::post_init() {
  local module="$1"

  p6df::module::act "$module" "post_init" "p6df::module::post_init"
}

######################################################################
#<
#
# Function: p6df::module::load(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::load() {
  local module="$1"

  # %repo
  p6df::module::parse "$module"

  p6df::module::load::files "$repo[load_path]" "$repo[extra_load_path]"
  p6df::module::recurse "p6df::module::load"

  # cleanup
  unset repo
}

######################################################################
#<
#
# Function: p6df::module::load::files(relpath, relaux)
#
#  Args:
#	relpath - 
#	relaux - 
#
#>
######################################################################
p6df::module::load::files() {
    local relpath="$1"
    local relaux="$2"

###
#    echo "===========> $repo[module]"
#    echo "repo[prefix] = $repo[prefix]"
#    echo "repo[sub]    = $repo[sub]"
#    echo "repo[ns]     = $repo[ns]"
#    echo "repo[plugin] = $repo[plugin]"
#    echo "repo[load_path] = $repo[load_path]"
#    echo "repo[extra_load_path] = $repo[extra_load_path]"
#
#    echo "relaux:  $P6_DFZ_SRC_DIR/$relaux"
#    echo "relpath: $P6_DFZ_SRC_DIR/$relpath"
##
    [[ $relaux ]] && p6df::util::file_load "$P6_DFZ_SRC_DIR/$relaux"
    p6df::util::file_load "$P6_DFZ_SRC_DIR/$relpath"
}

######################################################################
#<
#
# Function: p6df::module::fetch(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::fetch() {
  local module="$1"

  # %repo
  p6df::module::parse "$module"

  git clone https://github.com/$repo[org]/$repo[repo] $P6_DFZ_SRC_DIR/$repo[org]/$repo[repo]

  p6df::module::recurse "p6df::module::fetch"

  # cleanup
  unset repo
}

><
# p6df::module::pull
#
# Return
######################################################################
#<
#
# Function: p6df::module::pull(module)
#
#  Args:
#	module - 
#
#>
######################################################################
p6df::module::pull() {
  local module="$1"

  # %repo
  p6df::module::parse "$module"

  (cd $P6_DFZ_SRC_DIR/$repo[org]/$repo[repo] ; git pull)

  p6df::module::recurse "p6df::module::pull"

  # cleanup
  unset repo
}