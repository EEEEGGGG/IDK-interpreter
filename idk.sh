#!/usr/bin/env bash 

# Debugging
## Add DEBUG=1 to idk.sh
### DEBUG=1 ./idk.sh
## Or add set -xv to idk.sh
### bash -xv idk.sh
## Or both.
### DEBUG=1 bash -xv idk.sh

# Error
function error_exit () {
	printf '\aerror: %s' "$@" >&2
	exit 1
}

# Stdin
function stdin () {
	## Get input and put it into an array to TOKENS
	readarray -t TOKENS
}

# File source
function src () {
	## Same as stdin but changed the name because it makes more sense
	## Get file and change it to an array to TOKENS
	mapfile -t TOKENS < "$1"
}

# Check DEBUG
function debug () {
	if [[ -n $DEBUG ]]; then
		echo "Tokens: ${TOKENS[*]}"
		echo "BOF: ${TOKENS[0]}"
		echo "EOF: ${TOKENS[-1]}"
		## Check if Memory Stack exists, otherwise don't output anything
		[[ -n ${memstack[*]} ]] && echo "Memory Stack: ${memstack[*]}"
	fi
}

# Run the interpreter
function interpreter () {
	## Check if BOF exists
	[[ ${TOKENS[0]} == openC ]] || error_exit "No openC at BOF"
	
	## For loop
	## Where len is 0 if $1 is unset or null, otherwise use $1 to len
	## Where len1 is len + 1 if $2 is unset or null, otherwise use $2 to len1
	for (( len = ${1:-0}, len1 = ${2:-$((len + 1))}; len < ${#TOKENS[@]}; len++, len1++ )); do
		### Case TOKEN
		case ${TOKENS[$len]} in
			movLoc)
				#### Check if integer
				[[ ${TOKENS[$len1]} =~ ^[0-9]+$ ]] && inst+=( "${TOKENS[$len1]}" )
				;;

			extract)
				instruction="${inst[-1]}"
				;;

			movVar) 
				variable=${TOKENS[$len1]}
				;;

			execute)
				case $instruction in
					1)
						exit 0
						;;
					2)
						echo "$variable"
						;;
					3)
						read -r variable
						;;
				esac
				;;

			isolate)
				line=${inst[-1]}
				;;

			isolateX)
				##### Memory stack
				export memstack+=( "${TOKENS[${inst[-1]}]}" )
				;;

			openJump)
				interpreter "$line" $((line + 1))
				;;

			if)
				[[ $variable == $instruction ]] && interpreter "$line" $((line + 1))
				;;

			pause)
				sleep 1
				;;

		esac
	done
	
	## Check if EOF exists
	[[ ${TOKENS[-1]} == closeC ]] || error_exit "Error, no 'closeC' at EOF"
}

# Show usage
##function usage () {
	##echo "$0 [-h|--help]"
	##echo "$0 [-s|--stdin]"
	##echo "$0 [-f|--file] file.idk"
	##echo "$0 [-d|--debug] [1, 2, 3]"
	##echo
	##echo "Options:"
	##echo
	##echo "  -h --help: display this help page"
	##echo "  -s --stdin: execute from stdin"
	##echo "  -f --file: execute from file"
	##echo "  -d --debug: debug script from 1-3"
	##echo
	##echo "Debug"
	##echo
	##echo "1: sets DEBUG=1"
	##echo "2: sets 'set -xv', used for debugging the interpreter"
	##echo "3: sets DEBUG=1 and 'set -xv'"
##}

# Set to enable Debugging
##option=$(getopt -o 'hsf:d::' -a -l 'help,stdin,file:,debug::' -q -n "$0" -- "$@")
##eval set -- "$option"
##unset option
##while true; do
	##case $1 in
		##'-h'|'--help')
			##usage
			##shift
			##break
			##;;

		##'-s'|'--stdin')
			##stdin
			##shift
			##continue
			##;;

		##'-f'|'--file')
			##if [[ -f $2 ]]; then
				##src "$2"
			##fi
			##shift 2
			##break
			##;;
		##'-d'|'--debug')
			##case "$2" in
				##'')
					##DEBUG=1
					##shift 2
					##;;

				##1|2|3)
					##DEBUG="$2"
					##shift 2
					##;;
				
				##*)
					##error_exit "Unknown error value"
					##break 1
					##;;
			##esac
			##;;

		##'--')
			##stdin
			##break
			##;;

		##*)
			##error_exit "Unknown error"
			##;;
	##esac
##done

if (( $# )); then
	for file in "$@"; do
		src "$file"
		interpreter
		debug
		unset len len1
	done
else
	stdin
	debug
	interpreter
fi
