#!/usr/bin/env bats

@test "page load" {
	tmp_dir=$(mktemp -d);
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	echo "<?php phpinfo(); ?>" > "${tmp_dir}/index.php";
	chmod -o+rx "$tmp_dir";
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data/public" -p "$random_port:8080" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port/index.php"
	[ "$status" -eq 0 ]
	[[ "$output" == *"PHP"* ]]
	[[ "$output" == *"Apache 2.0 Handler"* ]]
	docker container stop $container_id;
}

@test "page load on readonly fs" {
	tmp_dir=$(mktemp -d);
	mkdir -p ${tmp_dir}/var/run ${tmp_dir}/public ${tmp_dir}/tmp;
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	echo "<?php phpinfo(); ?>" > "${tmp_dir}/public/index.php";
	chmod -o+rx "$tmp_dir";
	chown 23456:23456 -R "$tmp_dir";
	container_id=$(docker run -d --read-only -v "${tmp_dir}:/data/" -v "${tmp_dir}/var/run:/var/run" -v "${tmp_dir}/tmp:/tmp" -p "$random_port:8080" "$IMAGE");
	>&2 echo "container: $container_id";
	>&2 echo docker run -d --read-only -v "${tmp_dir}:/data/" -v "${tmp_dir}/var/run:/var/run" -v "${tmp_dir}/tmp:/tmp" -p "$random_port:8080" "$IMAGE";
	sleep 3
	run curl "localhost:$random_port/index.php"
	[[ "$output" == *"PHP"* ]]
	[[ "$output" == *"Apache 2.0 Handler"* ]]
	docker container stop $container_id;
}

@test "custom php.ini load" {
	tmp_dir=$(mktemp -d);
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	mkdir -p ${tmp_dir}/{public,etc/php/conf.d};
	echo "<?php phpinfo(); ?>" > "${tmp_dir}/public/index.php";
	echo 'error_prepend_string = "xJHJpiChWeJs7Hc"' > "${tmp_dir}/etc/php/conf.d/custom.ini";
	chmod -o+rx "$tmp_dir";
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data/" -p "$random_port:8080" "$IMAGE");
	sleep 3
	run curl "localhost:$random_port/index.php"
	[ "$status" -eq 0 ]
	[[ "$output" == *"xJHJpiChWeJs7Hc"* ]]
	docker container stop $container_id;
}

@test "file permission" {
	tmp_dir=$(mktemp -d);
	public_dir="${tmp_dir}/public";
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	mkdir -p "$public_dir";
	chmod -o+rx "$tmp_dir";
	echo "<?php error_reporting(E_ALL); file_put_contents('/data/public/any-name.txt', 'content'); ?>" > "${public_dir}/index.php";
	chown 23456:23456 -R "$tmp_dir";
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data" -p "$random_port:8080" "$IMAGE");
	sleep 3
	curl "localhost:$random_port/index.php";
	run curl -s "localhost:$random_port/index.php";
	[ "$status" -eq 0 ]
	[ "$output" == "" ]
	run curl -s "localhost:$random_port/any-name.txt";
	[ "$status" -eq 0 ]
	[ "$output" == "content" ]
	docker container stop $container_id;
}

@test "imagick available" {
	tmp_dir=$(mktemp -d);
	public_dir="${tmp_dir}/public";
	random_port=$((((RANDOM + RANDOM) % 63001) + 2000))
	mkdir -p "$public_dir";
	chown 23456:23456 -R "$tmp_dir";
	echo "<?php var_dump(Imagick::getCopyright()); ?>" > "${public_dir}/index.php";
	container_id=$(docker run --rm -d -v "${tmp_dir}:/data" -p "$random_port:8080" "$IMAGE");
	sleep 3
	curl -s "localhost:$random_port/index.php";
	run curl -s "localhost:$random_port/index.php";
	[ "$status" -eq 0 ]
	[[ "$output" =~ .*ImageMagick.* ]];
	docker container stop $container_id;
}

@test "load ioncube loader" {
	run docker run --rm "$IMAGE" php -i
	[[ "$output" == *"with the ionCube PHP Loader"* ]]
}
