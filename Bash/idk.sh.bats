#!/usr/bin/env bats

cwd="$(pwd)"
[ "$(basename "${cwd}")" == "Bash" ] && cwd="${cwd}"/..
@test "Test if idk.sh without arguments gets input from stdin" {
	printf "openC\ncloseC" | "${cwd}"/Bash/idk.sh
}

@test "Test if idk.sh with arguments gets input from file" {
	"${cwd}"/Bash/idk.sh examples/empty.idk
}
