#!/usr/bin/env bash 

# Uncomment to enable debugging
set -xv
DEBUG=1

# stdin
function stdin () {
	## Get input and put it into an array to TOKENS
	readarray -t TOKENS
}

# file source
function src () {
	## Same as stdin but changed the name because it makes more sense
	## Get file and change it to an array to TOKENS
	mapfile -t TOKENS < "$1"
}

# Run the interpreter
function interpreter () {
	## Check if BOF exists
	if [[ ${TOKENS[0]} != openC ]]; then
		exit 1
	fi

	## For loop when len is 0 if first argument is null, otherwise set the first argument to len,
	## when len1 is len + 1,
	## when len_1 is len - 1,
	## when len_2 is len - 2,
	## when len is less than the number of elements in TOKEN array,
	## Increment after len, Increment after len1, Increment after len2, Increment after len22.
	for (( len = ${1:-0}, len1 = $((len + 1)), len_1 = $((len - 1)), len_2 = $((len - 2)); len < ${#TOKENS[@]}; len++, len1++, len_1++, len_2++)); do
		### Case TOKEN
		case ${TOKENS[$len]} in
			movLoc)
				if [[ ${TOKENS[$len1]} -eq 1 ]]; then
					inst=1
				elif [[ ${TOKENS[$len1]} -eq 2 ]]; then
					inst=2
				fi
				;;

			extract)
				if [[ $inst -eq 1 ]]; then
			         	instruction="1"
				elif [[ $inst -eq 2 ]]; then
					instruction="2"
				fi
				;;

			movVar) 
				variable=${TOKENS[$len1]}
				;;

			execute)
				if [[ $instruction == 1 ]]; then
					exit 0
				elif [[ $instruction == 2 ]]; then
				 	echo "$variable"
				fi
				;;

			isolate)
				if [[ -n $len1 ]]; then
					line=${TOKENS[$len1]}
				fi
				;;

			isolateX)
				##### Memory stack
				if [[ -n $len1 ]]; then
					memstack[$len1]=( "${TOKEN[$len1]}" )
				fi
				;;

			openJump)
				if [[ -n $line ]]; then
					interpreter $line
				elif [[ -n $memstack[$len] ]]; then
				fi
				;;

			pause)
				sleep 1
				;;

		esac
	done
	
	## Check if EOF exists
	if [[ ${TOKENS[-1]} != closeC ]]; then
		echo "Error, no 'closeC' at EOF"
		exit 2
	fi
}

# Show usage
##function usage () {
##	echo "stdin: $0 -s"
##}

# Set to enable Debugging
##while getopts ":hd:sf:" option; do
##	case $option in
##		h)
##			usage
##		;;
##		d)
##			case "$OPTARG" in
##				"")
##					DEBUG=1
##				;;
##				1)
##					DEBUG=1
##				;;
##				2)
##					set -xv
##				;;
##				3)
##					DEBUG=1
##					set -xv
##				;;
##				*)
##					echo "Invalid DEBUG value: $OPTARG. Use 1, 2, 3"
##					exit 3
##				;;
##			esac
##		;;
##		s)
##			stdin
##		;;
##		f)
##			if [[ -n $OPTARG ]]; then
##				for file in $OPTARG; do
##					src "$file"
##				done
##			else
##				echo "Option -f defined but no argument."
##				exit 4
##			fi
##		;;
##		*)
##			echo "Unknown option"
##	esac
##done

# Check if no argument is provided
if [[ $# -eq 0 ]]; then
	stdin
else
	for file in "$@"; do
		src "$file"
	done
fi

# Check DEBUG
if [[ -n $DEBUG ]]; then
	echo "Tokens: ${TOKENS[*]}"
	echo "BOF: ${TOKENS[0]}"
	echo "EOF: ${TOKENS[-1]}"
fi

interpreter
