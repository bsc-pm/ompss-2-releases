# Dockerfile
FROM debian:stretch-slim

ARG MAKEFLAGS

RUN apt-get update && apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        libtool \
        pkg-config \
        libltdl-dev \
        build-essential \
        git \
        gfortran \
        bison \
        flex \
        gperf \
        libsqlite3-dev \
        python \
        curl \
        ca-certificates \
        libxml2-dev \
        binutils-dev \
        libiberty-dev \
        libpapi-dev \
        libboost1.62-dev \
        libnuma-dev \
        libhwloc-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/src/extrae && \
    curl -SL https://github.com/bsc-performance-tools/extrae/archive/3.7.1.tar.gz \
    | tar -xzC /usr/local/src/extrae --strip-components=1 && \
    cd /usr/local/src/extrae && \
    ./bootstrap && \
    ./configure \
        --without-mpi \
        --without-unwind \
        --without-dyninst \
        --with-papi=/usr \
        --disable-openmp \
        --disable-pthread \
        --disable-smpss && \
    make && \
    make install && \
    make distclean

COPY mcxx /usr/local/src/mcxx
RUN cd /usr/local/src/mcxx && \
    autoreconf -fiv && \
    ./configure \
        --enable-ompss-2 \
        --with-nanos6=/usr/local  \
        --enable-nanos6-bootstrap && \
    make && \
    make install && \
    make distclean

COPY nanos6 /usr/local/src/nanos6
RUN cd /usr/local/src/nanos6 && \
    autoreconf -fiv && \
    ./configure \
        --with-extrae=/usr/local && \
    make && \
    make install && \
    make distclean

CMD ["bash"]
