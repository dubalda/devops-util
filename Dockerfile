FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

RUN apt-get update && \
    apt-get -y install \
      ca-certificates \
      apt-utils \
      apt-transport-https \
      gnupg-agent \
      curl \
      wget \
      jq \
      git \
      tree \
      bash-completion \
      software-properties-common \
      openssl && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get -y install \
      docker-ce-cli \
      p7zip \
      mutt && \
    apt-get clean

