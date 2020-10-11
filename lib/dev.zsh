# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6df::core::dev::graph()
#
#>
######################################################################
p6df::core::dev::graph() {

  cat <<EOF 
digraph p6m7g8 {
 rankdir=LR;
# size="11,8.5";
# layout=neato;
# overlap=false;
# splines=true;
# pack=true;
# start="random";
# sep=0.1;
# edge [len=2];
# node[shape=oval,style=filled,fillcolor="#FFFFFF"];
EOF

  # @Modules
  p6df::core::modules::collect

  p6df::core::modules::foreach "p6df::core::dev::graph::dot" | sort -u

  p6_echo "}"
}

######################################################################
#<
#
# Function: p6df::core::dev::graph::dot(module, module, dep)
#
#  Args:
#	module - 
#	module - 
#	dep - 
#
#>
######################################################################
p6df::core::dev::graph::dot() {
  local module="$1"

  p6df::core::modules::recurse::callback::dep "$module" "_dot"
}

_dot() {
  local module="$1"
  local dep="$2"

  module=$(echo $module | sed -e 's,[:\./-],_,g')
  dep=$(echo $dep | sed -e 's,[:\./-],_,g')

	p6_echo "$module -> $dep;"
}