FROM ubuntu:22.04 as base

RUN apt-get update && apt-get -y install build-essential \
                       libz-dev        \
                       libreadline-dev \
                       libncursesw5-dev \
                       libssl-dev       \
                       libgdbm-dev          \
                       libsqlite3-dev    \
                       libbz2-dev        \
                        liblzma-dev       \
                        curl \
    git
RUN git clone https://github.com/python/cpython.git

# 3.13.0a3
ARG PYTHON_VERSION_PATCH=???
# 3.13
ARG PYTHON_VERSION_MINOR=???
RUN cd cpython && git fetch && git checkout v${PYTHON_VERSION_PATCH} && ./configure --enable-shared && make -j 32

FROM scratch
# 3.13.0a3
ARG PYTHON_VERSION_PATCH=???
# 3.13
ARG PYTHON_VERSION_MINOR=???
COPY --from=base /cpython/libpython${PYTHON_VERSION_MINOR}.so.1.0 /libpython${PYTHON_VERSION_MINOR}.so.1.0
