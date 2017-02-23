FROM alpine:3.5

ENV ASDF_VERSION "v0.2.1"
ENV ERLANG_VERSION "19.2"
ENV ELIXIR_VERSION "1.4.2"

RUN apk add --update bash curl alpine-sdk perl openssl openssl-dev ncurses ncurses-dev unixodbc unixodbc-dev openjdk8 python py-pip py-setuptools git ca-certificates curl nodejs && \
    rm -rf /var/cache/apk/* && \
    bash && \
    PATH="$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH" && \
    echo "PATH=$HOME/.asdf/bin:$HOME/.asdf/shims:$PATH" >> ~/.bashrc && \
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch $ASDF_VERSION && \
    asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git && \
    asdf install erlang $ERLANG_VERSION && \
    asdf global erlang $ERLANG_VERSION && \
    asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git && \
    asdf install elixir $ELIXIR_VERSION && \
    asdf global elixir $ELIXIR_VERSION && \
    yes | mix local.hex --force && \
    yes | mix local.rebar --force && \
    pip install python-dateutil && \
    git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd && \
    ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd
