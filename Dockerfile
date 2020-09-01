FROM debian:buster

RUN apt-get update && \
    apt-get -y install \
      ca-certificates \
      openssl \
      bash-completion \
      p7zip \
      tree \
      git \
      jq \
      curl \
      wget && \
    apt-get clean
