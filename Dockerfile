FROM debian:sid-20211220

# Set image locale.
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV TZ=Europe/Paris

RUN apt-get update && apt-get -y install curl fzf ripgrep tree git xclip python3 python3-venv python3-pip nodejs npm tzdata ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config zip unzip sqlite3 libsqlite3-dev

# Install Neovim from source.
RUN mkdir -p /root/TMP
RUN cd /root/TMP && git clone https://github.com/neovim/neovim
RUN cd /root/TMP/neovim && git checkout stable && make -j4 && make install

COPY ./ /root/.config/nvim/

# Install Neovim extensions.
RUN nvim --headless "+Lazy! restore" +qa || exit 0
