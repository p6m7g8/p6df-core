# minimalistic - dispatch to modules

######################################################################
#<
#
# Function: p6df::util::exists()
#
#>
######################################################################
p6df::util::exists() {
  local thing="$1"
  type -f "$thing" > /dev/null 2>&1
}

export -a FILES
######################################################################
#<
#
# Function: p6df::util::file_load(file)
#
#  Args:
#	file - 
#
#>
######################################################################
p6df::util::file_load() {
  local file="$1"

  if [[ -r "$file" ]]; then
    FILES+=($file)
    . "$file"
  fi
}

######################################################################
#<
#
# Function: p6df::util::path_if(dir)
#
#  Args:
#	dir - 
#
#>
######################################################################
p6df::util::path_if() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    path+=($dir)
  fi
}

######################################################################
#<
#
# Function: p6df::util::cdpath_if(dir)
#
#  Args:
#	dir - 
#
#>
######################################################################
p6df::util::cdpath_if() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    cdpath+=($dir)
  fi
}

######################################################################
#<
#
# Function: p6df::util::user::init()
#
#>
######################################################################
p6df::util::user::init() {

  p6df::util::file_load "$HOME/.zsh-me"
}

######################################################################
#<
#
# Function: p6df::util::pm::homebrew::install()
#
#>
######################################################################
p6df::util::pm::homebrew::install() {

  yes | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
#  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}
######################################################################
#<
#
# Function: p6df::path::fpath_brew_add(formulae)
#
#  Args:
#	formulae - 
#
#>
######################################################################
p6df::path::fpath_brew_add() {
    local formulae="$1"

    fpath=(/usr/local/opt/$formulae/share/zsh/site-functions $fpath)
}

######################################################################
#<
#
# Function: p6df::path::fpath_current()
#
#>
######################################################################
p6df::path::fpath_current() {

    local fp
    for fp in $fpath[@]; do
	echo $fp
    done | sort
}