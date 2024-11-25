#!/bin/bash

ARGC=$#

main() {
	if [ $ARGC -eq 0 ]; then
		echo "sdrun <bin-name> [arg1, arg2, ..., argn]"
		return 1
	fi

	SOURCE_PATH=$(pwd)/$1
	if [ ! -f $SOURCE_PATH ]; then
		echo "file not found"
		return 1
	fi

	TEMP_PATH=~/a.out
	mv "$SOURCE_PATH" "$TEMP_PATH" 2> /dev/null
	chmod +x "$TEMP_PATH"
	$TEMP_PATH "${@:2}"
	local status=$?
	mv "$TEMP_PATH" "$SOURCE_PATH" 2> /dev/null
	return $status
}

restore() {
	mv "$TEMP_PATH" "$SOURCE_PATH" 2> /dev/null
	echo
	exit 1
}

trap restore SIGINT

main $@
