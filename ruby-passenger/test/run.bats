#!/usr/bin/env bats

@test "use root to start test" {
	run id -u
	[[ "$output" -eq "0" ]]
}

@test "page load" {
	tmp_dir=$(mktemp -d);
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	mkdir ${tmp_dir}/app/;
	cp "${BATS_TEST_DIRNAME}/config.ru" "${tmp_dir}/app/config.ru"
	chmod -o+rx "$tmp_dir";
	chown -R 23456:23456 "$tmp_dir"
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data/" -p "$random_port:8080" "$IMAGE");
	docker exec -w /data/app $container_id gem install rack
	sleep 3
	run curl "localhost:$random_port"
	[ "$status" -eq 0 ]
	[[ "$output" == *"Hello World"* ]]
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

@test "psql available" {
	run docker run --rm "$IMAGE" psql --version
  [ "$status" -eq 0 ]
}