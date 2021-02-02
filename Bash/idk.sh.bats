#!/usr/bin/env bats

@test "Test if idk.sh without arguments gets input from stdin" {
	printf "openC\ncloseC" | ./idk.sh
}

@test "Test if idk.sh with arguments gets input from file" {
	./idk.sh examples/empty.idk
}