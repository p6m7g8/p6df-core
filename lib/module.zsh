######################################################################
#<
#
# Function: p6df::core::module::parse(module)
#
#  Args:
#	module -
#
#  Environment:	 XXX
#>
######################################################################
p6df::core::module::parse() {
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
# Function: p6df::core::module::init::start(module)
#
#  Args:
#	module -
#
#>
######################################################################
p6df::core::module::init::start() {
  local module="$1"

  p6df::core::modules::recurse::_bootstrap "$module" "init::pre"
  p6df::core::modules::recurse::internal "$module" "init"
  p6df::core::modules::recurse::internal "$module" "init::post"
}

######################################################################
#<
#
# Function: p6df::core::module::langs(module)
#
#  Args:
#	module -
#
#>
######################################################################
p6df::core::module::langs() {
  local module="$1"

  p6df::core::modules::recurse::internal "$module" "langs"
}

######################################################################
#<
#
# Function: p6df::core::module::vscodes(module)
#
#  Args:
#	module -
#
#>
######################################################################
p6df::core::module::vscodes() {
  local module="$1"

  p6df::core::modules::recurse::internal "$module" "vscodes"
}

######################################################################
#<
#
# Function: p6df::core::module::home::symlink(module)
#
#  Args:
#	module -
#
#>
######################################################################
p6df::core::module::home::symlink() {
  local module="$1"

  p6df::core::modules::recurse::internal "$module" "home::symlink"
}

######################################################################
#<
#
# Function: p6df::core::module::brew(module)
#
#  Args:
#	module -
#
#>
######################################################################
p6df::core::module::brew() {
  local module="$1"

  p6df::core::modules::recurse::internal "$module" "external::brew"
}

######################################################################
#<
#
# Function: p6df::core::module::fetch(module, dep, org, repo, ..., prefix)
#
#  Args:
#	module -
#	dep -
#	org -
#	repo -
#	... - 
#	prefix -
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::fetch() {
  local module="$1"

  p6df::core::modules::recurse::callback "$module" "_fetch" "$P6_DFZ_SRC_DIR"
}

_fetch() {
  local dep="$1"
  local org="$2"
  local repo="$3"
  shift 3
  local prefix="$1"

  git clone https://github.com/$org/$repo $prefix/$org/$repo
}

######################################################################
#<
#
# Function: p6df::core::module::pull(module, dep, org, repo, ..., prefix)
#
#  Args:
#	module -
#	dep -
#	org -
#	repo -
#	... - 
#	prefix -
#
#  Depends:	 p6_git
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::pull() {
  local module="$1"

  p6df::core::modules::recurse::callback "$module" "_pull" "$P6_DFZ_SRC_DIR"
}

_pull() {
  local dep="$1"
  local org="$2"
  local repo="$3"
  shift 3
  local prefix="$1"

  (cd $prefix/$org/$repo ; p6_git_p6_pull)
}

######################################################################
#<
#
# Function: p6df::core::module::push(module, dep, org, repo, ..., prefix)
#
#  Args:
#	module -
#	dep -
#	org -
#	repo -
#	... - 
#	prefix -
#
#  Depends:	 p6_git
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::push() {
  local module="$1"

  p6df::core::modules::recurse::callback "$module" "_push" "$P6_DFZ_SRC_DIR"
}

_push() {
  local dep="$1"
  local org="$2"
  local repo="$3"
  shift 3
  local prefix="$1"

  (cd $prefix/$org/$repo ; p6_git_p6_push)
}

######################################################################
#<
#
# Function: p6df::core::module::sync(module, dep, org, repo, ..., prefix)
#
#  Args:
#	module -
#	dep -
#	org -
#	repo -
#	... - 
#	prefix -
#
#  Depends:	 p6_git
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::sync() {
  local module="$1"

  p6df::core::modules::recurse::callback "$module" "_sync" "$P6_DFZ_SRC_DIR"
}

_sync() {
  local dep="$1"
  local org="$2"
  local repo="$3"
  shift 3
  local prefix="$1"

  (cd $prefix/$org/$repo ; p6_git_p6_sync)
}

######################################################################
#<
#
# Function: p6df::core::module::status(module, dep, org, repo, ..., prefix)
#
#  Args:
#	module -
#	dep -
#	org -
#	repo -
#	... - 
#	prefix -
#
#  Depends:	 p6_git
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::status() {
  local module="$1"

  p6df::core::modules::recurse::callback "$module" "_status" "$P6_DFZ_SRC_DIR"
}

_status() {
  local dep="$1"
  local org="$2"
  local repo="$3"
  shift 3
  local prefix="$1"

  (cd $prefix/$org/$repo ; p6_git_p6_status)
}

######################################################################
#<
#
# Function: p6df::core::module::diff(module, dep, org, repo, ..., prefix)
#
#  Args:
#	module -
#	dep -
#	org -
#	repo -
#	... - 
#	prefix -
#
#  Depends:	 p6_git
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::diff() {
  local module="$1"

  p6df::core::modules::recurse::callback "$module" "_diff" "$P6_DFZ_SRC_DIR"
}

_diff() {
  local dep="$1"
  local org="$2"
  local repo="$3"
  shift 3
  local prefix="$1"

  (cd $prefix/$org/$repo ; p6_git_p6_diff)
}

######################################################################
#<
#
# Function: p6df::core::module::source(relpath, relaux)
#
#  Args:
#	relpath -
#	relaux -
#
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::source() {
    local relpath="$1"
    local relaux="$2"

    [[ -n "$relaux" ]] && p6df::util::file::load "$P6_DFZ_SRC_DIR/$relaux"
    p6df::util::file::load "$P6_DFZ_SRC_DIR/$relpath"
}

######################################################################
#<
#
# Function: p6df::core::module::version(module)
#
#  Args:
#	module -
#
#  Depends:	 p6_file
#  Environment:	 P6_DFZ_SRC_DIR
#>
######################################################################
p6df::core::module::version() {
  local module="$1"

  # %repo
  p6df::core::module::parse "$module"

  p6_file_display $P6_DFZ_SRC_DIR/$repo[org]/$repo[repo]/conf/version
}
