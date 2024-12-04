#!/bin/bash

BIN_FILE=$1
TEMP_BIN_FILE=~/a.out

main() {
	if [ $# -eq 0 ]; then
		echo "sdrun <path/to/binary> [arg1, arg2, ..., argn]"
		return 1
	fi
	if [ ! -f $BIN_FILE ]; then
		echo "file not found"
		return 1
	fi
	mv "$BIN_FILE" "$TEMP_BIN_FILE" 2> /dev/null
	chmod +x "$TEMP_BIN_FILE"
	$TEMP_BIN_FILE "${@:2}"
	local binReturnCode=$?
	mv "$TEMP_BIN_FILE" "$BIN_FILE" 2> /dev/null
	return $binReturnCode
}

restore() {
	mv "$TEMP_BIN_FILE" "$BIN_FILE" 2> /dev/null
	echo
	exit 1
}

trap restore SIGINT
main $@