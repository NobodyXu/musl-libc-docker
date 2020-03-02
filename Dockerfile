ARG base=debian:buster

FROM nobodyxu/apt-fast:latest-debian-buster-slim AS Build

# Install dependencies
RUN apt-auto install -y --no-install-recommends clang lld llvm make

# Configure llvm as default toolchain
## Use ld.ldd as default linker
RUN ln -f $(which ld.lld) /usr/bin/ld
## Use clang as default compiler
ENV CC=clang

## Build and Install musl
ARG ver=latest
ADD https://musl.libc.org/releases/musl-${ver}.tar.gz /tmp/

WORKDIR /usr/local/src/musl/
RUN tar xvzf /tmp/musl-latest.tar.gz --strip-components 1

RUN ./configure --enable-wrapper=clang
ADD config.mk /usr/local/src/musl

RUN make -j $(nproc)
RUN make install

## Add musl-gcc
ADD bin/* /usr/local/musl/bin/
ADD lib/* /usr/local/musl/lib/
RUN ln -s /lib/ld-musl-x86_64.so.1 /usr/local/musl/bin/ldd

FROM Build AS Test

RUN apt-auto install -y --no-install-recommends gcc
ADD hello.c /tmp/

WORKDIR /tmp/
ENV PATH=/usr/local/musl/bin/:$PATH

RUN musl-clang hello.c && ldd a.out && ./a.out
RUN ldd a.out | grep 'libc.so => /lib/ld-musl-x86_64.so.1'

RUN musl-gcc   hello.c && ldd a.out && ./a.out
RUN ldd a.out | grep 'libc.so => /lib/ld-musl-x86_64.so.1'

FROM $base AS Final

ENV PATH=/usr/local/musl/bin/:$PATH
COPY --from=Build /usr/local/musl/ /usr/local/musl/
COPY --from=Build /lib/ld-musl-x86_64.so.1 /lib/
