#!/usr/bin/env bash

# Error
function error_exit () {
	printf '\aerror: %s' "$@" >&2 ## Print error with "bell" to argument in stderr
	exit 1
}

# Stdin
function stdin () {
	## mapfile = readarray
	readarray -t TOKENS ## Get input
}

# File
function src () {
	## mapfile = readarray
	mapfile -t TOKENS < "$1" ## Get file
}

# Check DEBUG
function debug () {
	## Check if DEBUG is either 1 or 3
	if [[ $DEBUG =~ [13] ]]; then
		echo "Tokens: ${TOKENS[*]}"
		echo "BOF: ${TOKENS[0]}"
		echo "EOF: ${TOKENS[-1]}"
		[[ -n ${memstack[*]} ]] && echo "Memory Stack: ${memstack[*]}" ### Check if Memory Stack exists
	fi
	## Check if DEBUG is either 2 or 3
	if [[ $DEBUG =~ [23] ]]; then
		set -xv ### set verbose and xtrace
	fi
}

# Interpreter
function interpreter () {
	[[ ${TOKENS[0]} == openC ]] || error_exit "No openC at BOF" ## Check if BOF exists

	for (( line_pointer = ${1:-0}, line_pointer1 = ${2:-$((line_pointer + 1))}; line_pointer < ${#TOKENS[@]}; line_pointer++, line_pointer1++ )); do
		case ${TOKENS[$line_pointer]} in
			movLoc)
				stack+=( "${TOKENS[$line_pointer]}" ) #### Append to Stack
				;;

			extract)
				instruction="${stack[-1]}" #### Add last element
				;;

			movVar)
				variable=${TOKENS[$line_pointer1]}
				;;

			execute)
				case $instruction in
					1)
						exit 0
						;;
					2)
						printf '%s\n' "${variable[@]}"
						;;
					3)
						readarray -t variable
						;;
				esac
				;;

			isolate)
				line=${stack[-1]}
				;;

			isolateX)
				export memstack+=( "${TOKENS[${stack[-1]}]}" ) #### Append to Memory Stack
				;;

			openJump)
				interpreter "$line" "$((line + 1))" #### Recurse through the interpreter
				;;

			if)
				[[ $variable == "$instruction" ]] && interpreter "$line" "$((line + 1))" #### If variable is equal to instruction, recurse through interpreter
				;;

			pause)
				sleep 1
				;;

		esac
	done

	[[ ${TOKENS[-1]} == closeC ]] || error_exit "Error, no 'closeC' at EOF" ## Check if EOF exists
}

# Show usage
function usage () {
	echo "Collapsed:"
	echo "$0 [-d|--debug][=| ][1|2|3] [-hs|--help,--stdin] [-f|--file][=| ][file.idk]"
	echo "More Readable:"
	echo "$0 [-h|--help]"
	echo "$0 [-s|--stdin]"
	echo "$0 [-f|--file][=| ]file.idk"
	echo "$0 [--all-files][=| ]file.idk file1.idk file2.idk"
	echo "$0 [-d|--debug][=| ][1|2|3]"
	echo
	echo "Options:"
	echo
	echo "  -h --help: display this help page"
	echo "  -s --stdin: execute from stdin"
	echo "  -f --file: execute from file"
	echo "  -d --debug: debug script from 1-3"
	#echo "  --all-files: instead of one by one adding -f or --file, execute all files. Note that this will also debug for all files if debug option is set. You also would not place other options conjuction with this option because it is marked as a file after it."
	echo
	echo "Debug:"
	echo
	echo "1: sets DEBUG=1"
	echo "2: sets 'set -xv', used for debugging the interpreter"
	echo "3: sets DEBUG=1 and 'set -xv'"
	echo
	echo "Notes:"
	echo "| means or"
}

# Options
function options () {
	option=$(getopt -o 'hd:sf:' -a -l 'help,debug:,stdin,file:,all-files:' -q -n "$0" -- "$@")
	eval set -- "$option"
	unset option
	while true; do
		case $1 in
			'-h'|'--help')
				usage
				shift
				break
				;;

			'-s'|'--stdin')
				stdin
				shift
				;;

			'-f'|'--file')
				if [[ -f $2 ]]; then
					src "$2"
				else
					error_exit "File '$2' does not exist"
					break 1
				fi
				shift 2
				;;

			'-d'|'--debug')
				case "$2" in
					1|2|3)
						DEBUG="$2"
						shift 2
						continue
						;;

					'')
						DEBUG=1
						shift 2
						continue
						;;

					*)
						error_exit "Debug option requires an argument is required, or unknown error value"
						break 1
						;;
				esac
				;;

			'--')
				shift
				break
				;;

			*)
				error_exit "Unknown error"
				;;
		esac
		debug
		interpreter 0 1
		unset DEBUG TOKENS
	done
}

# Run
options
