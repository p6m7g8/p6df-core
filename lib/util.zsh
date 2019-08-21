# minimalistic - dispatch to modules

p6df::util::exists() {
  local thing="$1"
  type -f "$thing" > /dev/null 2>&1
}

export -a FILES
p6df::util::file_load() {
  local file="$1"

  if [[ -r "$file" ]]; then
    FILES+=($file)
    if p6df::util::exists p6_file_load; then
      p6_file_load "$file"
    else
      . "$file"
    fi
  fi
}

p6df::util::path_if() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    path+=($dir)
  fi
}

p6df::util::cdpath_if() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    cdpath+=($dir)
  fi
}

p6df::util::user::init() {

  p6df::util::file_load "$HOME/.zsh-me"
}

p6df::util::pm::homebrew::install() {

  yes | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}
p6df::path::fpath_brew_add() {
    local formulae="$1"

    fpath=(/usr/local/opt/$formulae/share/zsh/site-functions $fpath)
}

p6df::path::fpath_current() {

    local fp
    for fp in $fpath[@]; do
	echo $fp
    done | sort
}
