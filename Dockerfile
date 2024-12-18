# Copyright (C) 2024 Bernhard Reitinger
#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
# KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

# Set base image for ARM64
ARG BASE_IMAGE_NAME="arm64v8/debian"
ARG BASE_IMAGE_VERSION="bookworm-slim"
ARG BASE_IMAGE="${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION}"

FROM ${BASE_IMAGE}

# Install dependencies
RUN apt-get update && \
    apt-get install -y ninja-build gettext cmake unzip curl build-essential git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install neovim
RUN git clone https://github.com/neovim/neovim --depth 1 && \
    cd neovim  && make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install && \
    cd .. && rm -rf neovim

# Install Python and packages
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add user for running the container
ENV USER=docker
ENV USER_ID=1000
ENV GROUP=docker
ENV GROUP_ID=1000
ENV USER_HOME=/home/docker

RUN addgroup --system --gid ${GROUP_ID} ${GROUP} && \
    adduser --system --disabled-login --disabled-password --home ${USER_HOME} --shell /bin/bash --gid ${GROUP_ID} --uid ${USER_ID} ${USER}

# Set user and home directory
USER ${USER}
WORKDIR ${USER_HOME}

# Default command
CMD ["bash"]
