#!/usr/bin/env bats

@test "page load" {
	tmp_dir=$(mktemp -d);
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	echo "61ecbc41cdae3e6b32712a06c73606fa" > "${tmp_dir}/content.txt";
	chmod -o+rx "$tmp_dir";
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data/public" -p "$random_port:8080" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port/content.txt"
	[ "$status" -eq 0 ]
	[[ "$output" == *"61ecbc41cdae3e6b32712a06c73606fa"* ]]
	docker container stop $container_id;
}

@test "page load on readonly fs" {
	tmp_dir=$(mktemp -d);
	mkdir -p ${tmp_dir}/var/run ${tmp_dir}/public ${tmp_dir}/tmp;
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	echo "61ecbc41cdae3e6b32712a06c73606fa" > "${tmp_dir}/public/content.txt";
	chmod -o+rx "$tmp_dir";
	chown 23456:23456 -R "$tmp_dir";
	container_id=$(docker run --rm -d --read-only -v "${tmp_dir}:/data/" -v "${tmp_dir}/var/run:/var/run" -v "${tmp_dir}/tmp:/tmp" -p "$random_port:8080" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port/content.txt"
	[ "$status" -eq 0 ]
	[[ "$output" == *"61ecbc41cdae3e6b32712a06c73606fa"* ]]
	docker container stop $container_id;
}

@test "use custom config" {
	tmp_dir=$(mktemp -d);
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	mkdir -p ${tmp_dir}/public/;
	echo "61ecbc41cdae3e6b32712a06c73606fa" > "${tmp_dir}/public/61ecbc41cdae3e6b32712a06c73606fa.txt";
	mkdir -p ${tmp_dir}/etc/nginx/;
	cp "${BATS_TEST_DIRNAME}/nginx.conf" ${tmp_dir}/etc/nginx;
	chmod -o+rx "$tmp_dir";
	chown 23456:23456 -R "$tmp_dir";
	echo docker run --rm -d -v "${tmp_dir}:/data/" -p "$random_port:8080" "$IMAGE"
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data/" -p "$random_port:8080" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port/"
	[ "$status" -eq 0 ]
	[[ "$output" == *"61ecbc41cdae3e6b32712a06c73606fa"* ]]
	docker container stop $container_id;
}
