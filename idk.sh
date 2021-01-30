#!/usr/bin/env bash 

# Uncomment to enable debugging
##set -xv
##DEBUG=1

# Error
function error_exit () {
	printf '\aerror: '"$@" >&2
	exit 1
}

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
	[[ ${TOKENS[0]} == openC ]] || error_exit "No openC at BOF"
	
	## For loop
	## Where len is 0 if $1 is unset or null, otherwise use $1 to len
	## Where len1 is len + 1 if $2 is unset or null, otherwise use $2 to len1
	for (( len = ${1:-0}, len1 = ${2:-$((len + 1))}; len < ${#TOKENS[@]}; len++, len1++ )); do
		### Case TOKEN
		case ${TOKENS[$len]} in
			movLoc)
				#### Check if integer
				if [[ ${TOKENS[$len1]} =~ ^[0-9]+$ ]]; then
					inst=${TOKENS[$len1]}
				else
					error_exit "Not an integer"
				fi
				;;

			extract)
				case $inst in
					1)
						instruction="1"
						;;
					2)
						instruction="2"
						;;
					3)
						instruction="3"
						;;
				esac
				;;

			movVar) 
				variable=${TOKENS[$len1]}
				;;

			execute)
				case $instructiont in
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
				[[ -n $inst ]] && line=$inst
				;;

			isolateX)
				##### Memory stack
				[[ -n ${inst} ]] && export memstack+=( "${TOKENS[$((inst - 1))]}" )
				;;

			openJump)
				[[ -n $line ]] && interpreter "$line" $((line + 1))
				;;

			if)
				if [[ $variable == $instruction  ]]; then
					[[ -n $line ]] && interpreter "$line" $((line + 1))
				fi
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
if (( $# )); then
	if [[ -e $1 ]]; then
		src "$1"
	else
		error_exit "No such file $1"
	fi
else
	stdin
fi

interpreter

# Check DEBUG
if [[ -n $DEBUG ]]; then
	echo "Tokens: ${TOKENS[*]}"
	echo "BOF: ${TOKENS[0]}"
	echo "EOF: ${TOKENS[-1]}"
	## Check if Memory Stack exists, otherwise don't output anything
	[[ -n ${memstack[*]} ]] && echo "Memory Stack: ${memstack[*]}"
fi
