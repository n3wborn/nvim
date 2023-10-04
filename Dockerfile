FROM alpine

ARG BUILD_DEPS="autoconf automake cmake curl g++ gettext gettext-dev git libtool make ninja openssl pkgconfig unzip binutils wget"
ARG TARGET=stable

RUN apk add --no-cache ${BUILD_DEPS} && \
    git clone https://github.com/neovim/neovim.git /tmp/neovim && \
    cd /tmp/neovim && \
    git fetch --all --tags -f && \
    git checkout ${TARGET} && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=/usr/local/ && \
    make install && \
    strip /usr/local/bin/nvim

COPY ./ /root/.config/nvim/

RUN nvim --headless "+Lazy! sync" +qa || exit 0

