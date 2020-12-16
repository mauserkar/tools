FROM debian:stable-slim

RUN apt-get update && apt-get upgrade

RUN apt-get install -fy \
    ansible \
    apache2-utils \
    apt-transport-https \
    bash-completion \
    ca-certificates \
    curl \
    dnsutils \
    git \
    git \ 
    gnupg \
    gnupg-agent \
    gnupg2 \
    jq \
    lsb-release \
    make \ 
    net-tools \
    netcat \ 
    nmap \
    python3 \
    python3-pip \
    python3-venv \
    rpl \
    screen \
    software-properties-common \
    sshpass \ 
    sudo \
    telnet \
    telnet \
    traceroute \
    tree \
    unzip \
    unzip \
    vim \ 
    wget \
    zip 

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN echo "deb [arch=amd64] https://packages.microsoft.com/debian/10/prod buster main" | tee -a  /etc/apt/sources.list.d/microsoft.list
RUN apt-get update && apt-get install -fy powershell kubectl && kubectl completion bash > /etc/bash_completion.d/kubectl

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip

RUN groupadd --gid 1000 debian \
    && useradd --uid 1000 --gid debian --shell /bin/bash --create-home debian

RUN mkdir /app && chown debian:debian /app

RUN echo "debian ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN chown debian:debian /usr/local/bin/

VOLUME [ "/app" ]

USER debian

COPY files/bash_aliases /home/debian/.bash_aliases

RUN pip install pywinrm \
    apache-libcloud \
    urllib3==1.25.4 \
    requests \
    awscli

RUN curl -sL https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash

WORKDIR /app

# How to use:
    # mkdir -p app or mount your workdir
    # docker run -it --rm -v $(pwd)/app:/app carlosgaro/tools:latest 