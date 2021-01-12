#!/usr/bin/env bats

@test "console load" {
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	container_id=$(docker run --rm -d -e PORT=8080 -p "$random_port:8080" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port"
	[ "$status" -eq 0 ]
	[[ "$output" == *"terminal-container"* ]]
	docker container stop $container_id;
}