#!/usr/bin/env bash 

set -xv
# Set to enable Debugging
DEBUG=1
# Convert to tokens
function token () {
	readarray -t TOKENS
}

function interpreter () {
	if [[ ${TOKENS[0]} != openC ]]; then
		exit 1
	fi
	
	for ((len = 0, len1 = 1, TOKEN = ${TOKENS[$len]}; len < ${#TOKENS}; len++, len1++ )); do
		case $TOKEN in
			movLoc)
				if [[ $len1 -eq 1 ]]; then
					inst=1
				elif [[ $len1 -eq 2 ]]; then
					inst=2
				fi
			;;
			extract)
				if [[ $inst -eq 1 ]]; then
			         	instruction="stop"
				elif [[ $inst -eq 2 ]]; then
					instruction="output"
				fi
			;;
			movVar) output=${TOKENS[$len1]}
			;;
			execute)
				if [[ $instruction == stop ]]; then
					exit 0
				elif [[ $instruction == output ]]; then
				 	echo "$output"
				fi
			;;
		esac
	done
	
	if [[ ${TOKENS[-1]} != closeC ]]; then
		echo "Error, no 'closeC' at EOF"
		exit 2
	fi
}

if [[ -n $@ ]]; then
	for file in "$@"; do
		mapfile -t TOKENS < "$file"
	done
else
	token
fi
# Check DEBUG
if [[ -n $DEBUG ]]; then
	echo "Tokens: ${TOKENS[*]}"
	echo "BOF: ${TOKENS[0]}"
	echo "EOF: ${TOKENS[-1]}"
fi
interpreter
