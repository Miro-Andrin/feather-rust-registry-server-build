FROM alpine:3.12

# This is a copy paste of:
# https://github.com/rust-lang/docker-rust/blob/a5896ce68cee87e80a44d078afbf05d5b679cdbc/1.47.0/alpine3.11/Dockerfile
# but we want to use the same alpine version as the prostgres-sql image. 
RUN apk add --no-cache \
        ca-certificates \
        gcc \
        openssl-dev \
        libc-dev
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.47.0
RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/1.22.1/x86_64-unknown-linux-musl/rustup-init"; \
    wget "$url"; \
    echo "cee31c6f72b953c6293fd5d40142c7d61aa85db2a5ea81b3519fe1b492148dc9 *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host x86_64-unknown-linux-musl; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

#Install dependencies needed to run start.sh
#The start.sh needs postgres running.
RUN apk update; apk add --no-cache bash python3-dev py3-pip postgresql-dev
RUN pip3 install psycopg2-binary

# Include the files from code into the container and compile the code
# this makes sure the code was able to compile once image was created.
# The image is going to be compiled porpperly once the docker image is run.
ADD ./feather-registry/ /usr/src/app/
ADD ./start.sh / 
ADD ./DB_init.py /usr/src/app/
RUN chmod a+x /start.sh

# Download dependencies.
RUN cd /usr/src/app/ ;cargo fetch
CMD ["/start.sh"]

