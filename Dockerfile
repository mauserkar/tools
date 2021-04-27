FROM debian:stable-slim

ENV USER debian
ENV PATH "/home/$USER/.local/bin:$PATH"

RUN apt-get update && apt-get upgrade -fy

RUN apt-get install -fy \
    ansible \
    apache2-utils \
    apt-transport-https \
    bash-completion \
    ca-certificates \
    curl \
    default-mysql-client \
    dnsutils \
    dos2unix \
    git \ 
    gnupg \
    gnupg-agent \
    gnupg2 \
    ipcalc \
    iputils-ping \
    jq \
    lsb-release \
    make \ 
    mdadm \
    net-tools \
    netcat \ 
    nload \
    nmap \
    openssh-client \
    openssh-server \
    python3 \
    python3-pip \
    python3-venv \
    rpl \
    screen \
    software-properties-common \
    sshpass \ 
    sshuttle \
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

RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
RUN echo "deb [arch=amd64] https://packages.microsoft.com/debian/10/prod buster main" | tee -a  /etc/apt/sources.list.d/microsoft.list
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

RUN ACCEPT_EULA=y apt-get update && \
    apt-get install -fy \
    powershell \ 
    mssql-tools \
    kubectl \
    google-cloud-sdk && \
    kubectl completion bash > /etc/bash_completion.d/kubectl

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /usr/bin/pip3 /usr/bin/pip && \
    ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd
    
RUN groupadd --gid 1000 $USER \
    && useradd --uid 1000 --gid $USER --shell /bin/bash --create-home $USER

RUN mkdir -p /app && chown $USER:$USER /app /home/$USER

RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN chown $USER:$USER /usr/local/bin/

VOLUME [ "/app" ]

USER $USER

COPY files/bashrc /home/$USER/.bashrc
COPY files/bash_aliases /home/$USER/.bash_aliases
COPY Dockerfile /home/$USER/Dockerfile

RUN pip install pywinrm \
    apache-libcloud \
    urllib3==1.25.4 \
    databricks-cli \
    requests \
    awscli

RUN curl -sL https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash
# RUN curl -s "https://get.sdkman.io" | bash && source "/home/$USER.sdkman/bin/sdkman-init.sh"

WORKDIR /app

# How to use:
    # mkdir -p app or mount your workdir
    # docker run -it --rm -v $(pwd)/app:/app carlosgaro/tools:latest 