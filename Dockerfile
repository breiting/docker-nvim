# Copyright (C) 2021 Bernhard Reitinger
#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
# KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

ARG BASE_IMAGE_NAME="debian"
ARG BASE_IMAGE_VERSION="buster-slim"
ARG BASE_IMAGE="${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION}"

FROM ${BASE_IMAGE}

RUN \
  apt-get update && \
  apt-get -y install \
    wget \
    git && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*


# Download and install nvim
ARG NVIM_URL="https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz"
RUN \
  wget -O nvim.tar.gz -r ${NVIM_URL} && \
  tar -C /usr -xvzf nvim.tar.gz && \
  cp -r /usr/nvim-linux64/* /usr && \
  rm -rf /usr/nvim-linux64 && \
  rm nvim.tar.gz

ENV USER=docker
ENV USER_ID=1000
ENV GROUP=docker
ENV GROUP_ID=1000
ENV USER_HOME=/home/docker

RUN addgroup --system -gid ${GROUP_ID} ${GROUP} && \
    adduser --system --disabled-login --disabled-password --home ${USER_HOME} --shell /bin/bash --gid ${GROUP_ID} --uid ${USER_ID} ${USER}

