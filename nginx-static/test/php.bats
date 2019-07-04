#!/usr/bin/env bats

@test "page load" {
	tmp_dir=$(mktemp -d);
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	echo "61ecbc41cdae3e6b32712a06c73606fa" > "${tmp_dir}/content.txt";
	chmod -o+rx "$tmp_dir";
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data/public" -p "$random_port:80" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port/content.txt"
	[ "$status" -eq 0 ]
  [[ "$output" == *"61ecbc41cdae3e6b32712a06c73606fa"* ]]
  docker container stop $container_id;
}
