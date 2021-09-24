FROM debian:buster

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Moscow

RUN apt-get update && \
    apt-get -y --quiet --no-install-recommends install \
      ca-certificates \
      apt-utils \
      apt-transport-https \
      gnupg-agent \
      gnupg2 \
      curl \
      wget \
      jq \
      git \
      tree \
      bash-completion \
      software-properties-common \
      openssl && \
    wget https://download.oracle.com/otn_software/linux/instantclient/185000/oracle-instantclient18.5-basiclite-18.5.0.0.0-3.x86_64.rpm && \
    wget https://download.oracle.com/otn_software/linux/instantclient/185000/instantclient-jdbc-linux.x64-18.5.0.0.0dbru.zip && \
    wget https://download.oracle.com/otn_software/linux/instantclient/185000/oracle-instantclient18.5-sqlplus-18.5.0.0.0-3.x86_64.rpm && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list && \
    echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/Debian_10/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list && \
    wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/Debian_10/Release.key -O- | apt-key add - && \
    curl https://baltocdn.com/helm/signing.asc | apt-key add - && \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    apt-get update && \
    echo "For custom version set: apt-get -y install docker-ce-cli=<VERSION_STRING>, for ex. 5:18.09.1~3-0~debian-stretch" && \
    apt-get -y --quiet --no-install-recommends install \
      alien \
      libaio1 \
      pass \
      docker-ce-cli \
      docker-compose \
      kubectl \
      helm \
      skopeo \
      buildah \
      p7zip \
      netcat \
      mutt && \
    apt-get clean && \
    curl -L https://raw.githubusercontent.com/docker/compose/1.29.1/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose && \
    echo "if [ -f /etc/bash_completion ]; then . /etc/bash_completion; fi" >> ~/.bashrc && \
    kubectl completion bash > /etc/bash_completion.d/kubectl && \
    curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && \
    tar xvzf openshift-client-linux.tar.gz && \
    rm -f openshift-client-linux.tar.gz kubectl README.md && \
    mv oc /usr/bin/ && \
    oc completion bash > /etc/bash_completion.d/oc_bash_completion && \
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash && \
    mv kustomize /usr/bin/ && \
    alien -i oracle-instantclient18.5-basiclite-18.5.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.5-devel-18.5.0.0.0-3.x86_64.rpm && \
    alien -i oracle-instantclient18.5-sqlplus-18.5.0.0.0-3.x86_64.rpm && \
    export IMG_SHA256="cc9bf08794353ef57b400d32cd1065765253166b0a09fba360d927cfbd158088" && \
    curl -fSL "https://github.com/genuinetools/img/releases/download/v0.5.11/img-linux-amd64" -o "/usr/local/bin/img" && \
    echo "${IMG_SHA256}  /usr/local/bin/img" | sha256sum -c - && \
    chmod a+x "/usr/local/bin/img" && \
    rm oracle-instantclient18.5-basiclite-18.5.0.0.0-3.x86_64.rpm && \
    rm instantclient-jdbc-linux.x64-18.5.0.0.0dbru.zip && \ 
    rm oracle-instantclient18.5-sqlplus-18.5.0.0.0-3.x86_64.rpm && \
    ENV LD_LIBRARY_PATH="/usr/lib/oracle/18.5/client64/lib:${LD_LIBRARY_PATH}"
    