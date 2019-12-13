#!/usr/bin/env bats

# @test "run h1-cli in image" {
# 	run docker run --rm "$IMAGE" h1 --version
# 	[ "$status" -eq 0 ]
# }

# @test "run sftp-server in image" {
# 	run docker run --rm "$IMAGE" sftp-server --help
# 	[ "$status" -eq 1 ]
# }

# @test "unzip available" {
# 	run docker run --rm "$IMAGE" unzip -v
# 	[ "$status" -eq 0 ]
# }

# @test "zip available" {
# 	run docker run --rm "$IMAGE" zip -v
# 	[ "$status" -eq 0 ]
# }

@test "wp-cli available" {
	tmp_dir=$(mktemp -d);
	run docker run --rm -v $tmp_dir:/data/public "$IMAGE" sh -c 'curl -L -s https://wordpress.org/latest.tar.gz | tar xvz --strip-components=1 -f -'
	run docker run --rm -v $tmp_dir:/data/public "$IMAGE" wp -v
	run docker run --rm -v $tmp_dir:/data/public "$IMAGE" wp  --help
	[ "$status" -eq 0 ]
}