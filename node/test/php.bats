#!/usr/bin/env bats

@test "page load" {
	tmp_dir=$(mktemp -d);
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
    cp "${BATS_TEST_DIRNAME}/app.js" "${tmp_dir}/app.js"
	chmod -o+rx "$tmp_dir";
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data/public" -p "$random_port:8080" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port/"
	[ "$status" -eq 0 ]
	[[ "$output" == *"Hello world"* ]]
	docker container stop $container_id;
}

@test "run h1-cli in image" {
	run docker run --rm "$IMAGE" h1 --version
	[ "$status" -eq 0 ]
}

@test "run sftp-server in image" {
	run docker run --rm "$IMAGE" sftp-server --help
	[ "$status" -eq 1 ]
}

@test "unzip available" {
	run docker run --rm "$IMAGE" unzip -v
  [ "$status" -eq 0 ]
}

@test "zip available" {
	run docker run --rm "$IMAGE" zip -v
  [ "$status" -eq 0 ]
}
