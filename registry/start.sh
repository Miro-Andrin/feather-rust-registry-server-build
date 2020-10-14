#!/bin/bash

# This command is run on startup of the server inside the container.
# This compiles the project, and then runs the binary. 

# Enable citex and semver on the server
psql $DATABASE_URL -c "CREATE EXTENSION citext;"
psql $DATABASE_URL -c "CREATE EXTENSION semver;"

cd /usr/src/app
refinery migrate -e DATABASE_URL  files -p ./migrations
cargo build --release  || { echo 'buid failed' ; exit 1; }
/usr/src/app/target/release/feather-registry