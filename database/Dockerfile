FROM postgres:13-alpine

# Install tools needed to build semver extension of postgres and then install it
RUN apk add --update build-base clang git llvm bash
RUN git clone https://github.com/theory/pg-semver.git; cd pg-semver; make; make install;

