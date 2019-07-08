#!/usr/bin/env bats

@test "run h1-cli in image" {
	run docker run --rm "$IMAGE" h1 --version
	[ "$status" -eq 0 ]
}

@test "run sftp-server in image" {
	run docker run --rm "$IMAGE" sftp-server --help
	[ "$status" -eq 1 ]
}
