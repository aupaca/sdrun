#!/bin/bash

ARGC=$#

main() {
	if [ $ARGC -eq 0 ]; then
		return 1
	fi
	src=$(pwd)/$1
	dest=~/a.out
	mv "$src" "$dest"
	chmod +x "$dest"
	$dest "${@:2}"
	local status=$?
	mv "$dest" "$src"
	return $status
}

restore() {
	mv "$dest" "$src"
	echo
	exit 1
}

trap restore SIGINT

main $@
