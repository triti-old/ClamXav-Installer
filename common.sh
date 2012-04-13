#!/bin/bash

# print: Print a message to stdout.
# Usage: print "message"

function print() {
	printf '%s\n' "$@"
}

# warn: Print a message to stderr.
# Usage: warn "message"

function warn() {
	printf '%s\n' "$@" >&2
}

# die: Print a message to stderr and exit with either the given status or that of the most recent command.
# Usage: some_command || die "message" [status code]

function die () {
	local st=
	warn "$1"
	exit "$st"
}

# install_pkg_to_volume: Installs a PKG installer to the specified volume
# Usage: install_pkg_to_volume path_to_pkg path_to_volume

function install_pkg_to_volume () {
	[[ -e "$1" ]] || die "ERROR: $1 not found."
	
	print "Installing $1 to $2..."
	/usr/sbin/installer -pkg "$1" -target "$2"
}

# ----------------------------------------------------------------------------

VOLUME="$3"
