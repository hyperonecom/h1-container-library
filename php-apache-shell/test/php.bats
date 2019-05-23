#!/usr/bin/env bats

@test "run docker image" {
	run docker run --rm "$IMAGE" h1 --version
	[ "$status" -eq 0 ]
}
