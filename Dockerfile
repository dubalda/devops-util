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
    echo "For custom version set: apt-get -y install docker-ce-cli=<VERSION_STRING>, for ex. 5:18.09.1~3-0~debian-stretch"
RUN apt-get -y install \
      docker-ce-cli \
      docker-compose \
      p7zip \
      mutt && \
    apt-get clean && \
    curl -L https://raw.githubusercontent.com/docker/compose/1.26.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose && \
    echo "if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi" >> ~/.bashrc
