#!/bin/bash

# This command is run on startup of the server inside the container.
# This compiles the project, and then runs the binary. 

cd /usr/src/app
python3 ./DB_init.py
cargo build --release  || { echo 'buid failed' ; exit 1; }
/usr/src/app/target/release/feather-registry

