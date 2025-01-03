# Copyright (C) 2024 Bernhard Reitinger
#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY
# KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

ARG BASE_IMAGE_NAME="python"
ARG BASE_IMAGE_VERSION="3.12.8-slim"
ARG BASE_IMAGE="${BASE_IMAGE_NAME}:${BASE_IMAGE_VERSION}"

FROM ${BASE_IMAGE}

#==============================================================================
# Install base build packages
#------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y \
      sudo git ninja-build gettext cmake unzip curl build-essential wget sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#==============================================================================
# Install and build latest neovim
#------------------------------------------------------------------------------
RUN git clone https://github.com/neovim/neovim --depth 1 && \
    cd neovim  && make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install && \
    cd .. && rm -rf neovim

#==============================================================================
# Install the lua lsp server
#------------------------------------------------------------------------------
ARG LUA_LSP_FILENAME="lua-language-server-3.13.4-linux-arm64.tar.gz"
ARG LUA_LSP_URL="https://github.com/LuaLS/lua-language-server/releases/download/3.13.4/${LUA_LSP_FILENAME}"
RUN mkdir /opt/lua-lsp && \
    cd /opt/lua-lsp && \
    wget ${LUA_LSP_URL} && \
    tar xvfz ${LUA_LSP_FILENAME} && \
    rm ${LUA_LSP_FILENAME} && \
    ln -s /opt/lua-lsp/bin/lua-language-server /usr/bin

#==============================================================================
# Install additional packages (some nice tools)
#------------------------------------------------------------------------------
RUN \
  apt-get update && \
  apt-get -y install \
    sudo ripgrep tree npm && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*


# Add user for running the container
ENV USER=docker
ENV USER_ID=1000
ENV GROUP=docker
ENV GROUP_ID=1000
ENV USER_HOME=/home/docker

RUN addgroup --system --gid ${GROUP_ID} ${GROUP} && \
    adduser --system --disabled-login --disabled-password --home ${USER_HOME} --shell /bin/bash --gid ${GROUP_ID} --uid ${USER_ID} ${USER} && \
    usermod -aG sudo ${USER} && \
    chown -R ${USER} /opt/lua-lsp

# Allow sudo w/o password
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set user and home directory
USER ${USER}
WORKDIR ${USER_HOME}

# Default command
CMD ["bash"]
