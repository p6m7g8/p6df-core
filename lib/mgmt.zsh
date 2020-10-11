# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6df::core::mgmt::update()
#
#>
######################################################################
p6df::core::mgmt::update() {

  p6df::mgmt::modules::update
}

######################################################################
#<
#
# Function: p6df::core::mgmt::modules::send()
#
#>
######################################################################
p6df::core::mgmt::modules::send() {

	p6df::core::modules::push
}

######################################################################
#<
#
# Function: p6df::core::mgmt::modules::sync()
#
#>
######################################################################
p6df::core::mgmt::modules::sync() {

	p6df::core::modules::sync
}

######################################################################
#<
#
# Function: p6df::core::mgmt::modules::update()
#
#>
######################################################################
p6df::core::mgmt::modules::update() {

  p6df::init
  p6df::core::modules::fetch
  p6df::core::modules::pull
  p6df::init
}

######################################################################
#<
#
# Function: p6df::core::mgmt::modules::status()
#
#>
######################################################################
p6df::core::mgmt::modules::status() {

	p6df::core::modules::status
}

######################################################################
#<
#
# Function: p6df::core::mgmt::modules::diff()
#
#>
######################################################################
p6df::core::mgmt::modules::diff() {

	p6df::core::modules::diff
}