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
RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
ENV PATH="/root/.asdf/bin:${PATH}"
RUN asdf plugin-add python
# 3.13.0a3
ARG PYTHON_VERSION_PATCH=???
# 3.13
ARG PYTHON_VERSION_MINOR=???
RUN asdf install python ${PYTHON_VERSION_PATCH}

FROM scratch
# 3.13.0a3
ARG PYTHON_VERSION_PATCH=???
# 3.13
ARG PYTHON_VERSION_MINOR=???
COPY --from=base /root/.asdf/installs/python/${PYTHON_VERSION_PATCH}/lib/libpython${PYTHON_VERSION_MINOR}.so.1.0 /libpython${PYTHON_VERSION_MINOR}.so.1.0
