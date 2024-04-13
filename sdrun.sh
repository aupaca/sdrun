#!/bin/bash

main() {
	if [ $# -ne 1 ]; then
		return 1
	fi
	src=$(pwd)/$1
	dest=~/a.out
	mv $src $dest
	chmod +x $dest
	$dest
	local status=$?
	mv $dest $src
	return $status
}

restore() {
	mv $dest $src
	echo
	exit 1
}

trap restore SIGINT

main $@
