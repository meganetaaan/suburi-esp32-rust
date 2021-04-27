FROM ubuntu:18.04

ENV WORKDIR=/workspace
WORKDIR ${WORKDIR}
RUN apt-get update && apt-get install --no-install-recommends --yes \
    build-essential \
    git \
    cmake \
    ca-certificates \
    python \
    curl \
    ninja-build \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/MabezDev/rust-xtensa
WORKDIR ${WORKDIR}/rust-xtensa
RUN ./configure --experimental-targets=Xtensa
RUN ./x.py build --stage 2
ENV XCARGO_RUST_SRC=${WORKDIR}/rust-xtensa/library
ENV RUSTC=${WORKDIR}/rust-xtensa/build/x86_64-unknown-linux-gnu/stage2/bin/rustc

WORKDIR ${WORKDIR}
