# p6df::prompt::init
#
# p6df::prompt::process
#
#<
####################################################################################################
p6df::prompt::process() {

  setopt prompt_subst
  PROMPT="\$(p6df::prompt::runtime $PromptLines[@])"
  PROMPT="
$PROMPT
"
}

p6df::prompt::runtime() {

  local -a lines

  local line
  for line in $@; do
    case $line in
      %local%)
	local tmp=$(p6df::prompt::local)
	lines+=($tmp)
	;;
      *)
	lines+=($line)
	;;
    esac
  done

  for line in $lines[@]; do
    local func="p6df::prompt::$line::line"
    if p6df::util::exists $func; then
      local cnt=$($func)
      [ -n "$cnt" ] && p6_echo "$cnt"
    fi
  done
}

p6df::prompt::std::line() {

  local tty=$fg[cyan]%l$reset_color
  local user=$fg[blue]%n$reset_color
  local host=$fg[yellow]%M$reset_color

  local info="[$tty]$user@$host rv=%?"

  p6_return_str "$info"
}

p6df::prompt::dir::line() {

  local dir=$fg[green]%/$reset_color

  p6_return_str "$dir"
}

p6df::prompt::tool::line() {

  local -a tools=(terraform docker jenkins) # jira confluence

  local tool
  for tool in $tools[@]; do
    p6df::util::exists p6df::prompt::${tool}::line && p6df::prompt::${tool}::line
  done
}

p6df::prompt::cloud::line() {

  local -a clouds=(aws gcp azure) # salesforce digitialocean rspace)

  local cloud
  for cloud in $clouds[@]; do
    p6df::util::exists p6df::prompt::${cloud}::line && p6df::prompt::${cloud}::line
  done
}

p6df::prompt::lang::line() {
  [ -n "${DISABLE_ENVS}" ] && return

  local -a langs=(node python node go java ruby perl scala lua R)
  local lang
  local str=""
  for lang in $langs[@]; do
    local prefix=$(p6_lang_cmd_2_env "$lang")
    local func="p6df::prompt::${lang}::line"
    local cntv=""
    if p6df::util::exists $func; then
      cntv=$($func)
    else
      cntv="n/a"
    fi
    str="$str $prefix:$cntv"
  done

  str=${str## }
  str="lang:\t$str"
  p6_return_str "$str"
}

p6df::prompt::env::line() {
  [ -n "${DISABLE_ENVS}" ] && return

  local -a envs=(pipenv gopath)

  local env
  for env in $envs[@]; do
    p6df::util::exists p6df::prompt::${env}::line && p6df::prompt::${env}::line
  done
}

p6df::prompt::vc::line() {

  local -a vcs=(git svn hg lp p4 cvs mg)
  local vc
  for vc in $vcs[@]; do
    p6df::util::exists p6df::prompt::${vc}::line && p6df::prompt::${vc}::line
  done
}

p6df::prompt::local() {
  local -a prompts=()

  local module
  for module in $Modules[@]; do
    case $module in
      *local*)
		# %repo
		p6df::module::parse $module
		prompts+=($repo[module])
		;;
    esac
  done

  local words=${(j: :)prompts}

  p6_return_words "$prompts"
}
