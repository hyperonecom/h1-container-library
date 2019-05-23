#!/usr/bin/env bats

@test "run h1-cli in image" {
	run docker run --rm "$IMAGE" h1 --version
	[ "$status" -eq 0 ]
}
