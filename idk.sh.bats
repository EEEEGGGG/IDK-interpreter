#!/usr/bin/env bats

@test "Test if idk gets input from stdin without arguments" {
	run idk.sh
}