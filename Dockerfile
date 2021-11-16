FROM ubuntu:20.04
LABEL MAINTAINER="carlos@carlosgaro.com"

ENV USER=carlos \
    DEBIAN_FRONTEND=noninteractive \
    JAVA_VERSION=8.0.282.j9-adpt

RUN apt-get update && \
    apt-get install -qy \
    ansible \
    apache2-utils \
    apt-transport-https \
    azure-cli \
    build-essential \
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
    nginx \
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
    
RUN pip install \
    apache-libcloud \
    awscli \
    coverage \
    databricks-cli \
    google-auth \
    msrestazure \
    mypy \
    packaging \
    paramiko \
    pylint \
    pyspark \
    pytest \
    pywinrm \
    requests \
    setuptools \
    urllib3 \
    virtualenv 

RUN groupadd --gid 1000 $USER \
    && useradd --uid 1000 --gid $USER --shell /bin/bash --create-home $USER && \
    mkdir -p /workdir && chown $USER:$USER /workdir /home/$USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers 

RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc && \
    echo "deb [arch=amd64,armhf,arm64] https://packages.microsoft.com/ubuntu/20.04/prod focal main" | tee -a /etc/apt/sources.list.d/microsoft.list && \
    curl -sL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list  && \
    curl -sL "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod a+x "/usr/local/bin/docker-compose" && \
    curl -sL "https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod a+x "/usr/local/bin/kubectl" && \
    curl -sL https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | bash && \
    curl -sL "https://get.sdkman.io" | bash && \
    echo "sdkman_auto_answer=true" > $HOME/.sdkman/etc/config && \
    echo "sdkman_auto_selfupdate=false" >> $HOME/.sdkman/etc/config && \
    echo "sdkman_insecure_ssl=true" >> $HOME/.sdkman/etc/config && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java $JAVA_VERSION" && \
    echo "$HOSTNAME - carlosgaro/tools" > /usr/share/nginx/html/index.html

RUN apt-get update && \
    apt-get install -fy \
    docker-ce-cli \
    dotnet-sdk-3.1 \
    dotnet-sdk-5.0 \
    google-cloud-sdk \
    powershell 

RUN ACCEPT_EULA=Y apt-get install -y mssql-tools && \
    ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd && \
    apt-get clean autoclean -qy && \
    apt-get autoremove -qy && \
    apt-get autoremove -qy && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

USER $USER

COPY files/bashrc /home/$USER/.bashrc
COPY files/bash_aliases /home/$USER/.bash_aliases
COPY README.md /home/$USER/

WORKDIR /workdir

VOLUME [ "/workdir" ]