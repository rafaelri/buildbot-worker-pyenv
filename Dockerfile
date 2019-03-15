FROM rafaelri/buildbot-worker-alpine
USER root
RUN apk add --no-cache --update \
  bash \
  build-base \
  patch \
  ca-certificates \
  git \
  bzip2-dev \
  linux-headers \
  ncurses-dev \
  openssl \
  openssl-dev \
  readline-dev \
  sqlite-dev \
  zlib \
    zlib-dev && \
  update-ca-certificates && \
  rm -rf /var/cache/apk/* 
RUN echo 'export PATH=${HOME}/.pyenv/bin:$PATH' >> /etc/profile
USER buildbot
ENV PYENV_ROOT="${HOME}/.pyenv"
RUN git clone --depth 1 https://github.com/yyuu/pyenv.git ~/.pyenv && \
    rm -rf ~/.pyenv/.git && \
      echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
      echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
      echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bashrc && \
      mkdir -p ${HOME}/.pyenv/versions && \
      mkdir -p ${HOME}/.pyenv/shims
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git ${HOME}/.pyenv/plugins/pyenv-virtualenv && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
