update_git:
	git submodule update --recursive
	cargo fetch --manifest-path ./registry/feather-registry/Cargo.toml

build: update_git
	sudo docker-compose build

