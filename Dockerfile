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
    
RUN groupadd --gid 1000 $USER \
    && useradd --uid 1000 --gid $USER --shell /bin/bash --create-home $USER && \
    mkdir -p /app && chown $USER:$USER /app /home/$USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    chown $USER:$USER /usr/local/bin/

VOLUME [ "/app" ]

USER $USER

COPY files/bashrc /home/$USER/.bashrc
COPY files/bash_aliases /home/$USER/.bash_aliases

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

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -- && \
    curl -sL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64,armhf,arm64] https://packages.microsoft.com/ubuntu/20.04/prod focal main" | sudo tee -a /etc/apt/sources.list.d/microsoft.list && \
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee -a /etc/apt/sources.list.d/docker.list  && \
    curl -sL "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    curl -sL "https://storage.googleapis.com/kubernetes-release/release/v1.22.0/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    curl -sL https://raw.githubusercontent.com/warrensbox/terraform-switcher/release/install.sh | sudo bash && \
    sudo chmod a+x "/usr/local/bin/kubectl" && \
    sudo chmod a+x "/usr/local/bin/docker-compose" && \
    curl -sL "https://get.sdkman.io" | bash && \
    echo "sdkman_auto_answer=true" > $HOME/.sdkman/etc/config && \
    echo "sdkman_auto_selfupdate=false" >> $HOME/.sdkman/etc/config && \
    echo "sdkman_insecure_ssl=true" >> $HOME/.sdkman/etc/config && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java $JAVA_VERSION" 

RUN apt-get update && \
    apt-get install -fy \
    docker-ce-cli \
    dotnet-sdk-3.1 \
    dotnet-sdk-5.0 \
    google-cloud-sdk \
    powershell 

RUN sudo ACCEPT_EULA=Y apt-get install -y mssql-tools && \
    ln -s /opt/mssql-tools/bin/sqlcmd /usr/local/bin/sqlcmd && \
    sudo apt-get clean autoclean -qy && \
    sudo apt-get autoremove -qy && \
    sudo apt-get autoremove -qy && \
    sudo rm -rf /var/lib/{apt,dpkg,cache,log}

ADD 

WORKDIR /app

# How to use:
    # mkdir -p app or mount your workdir
    # docker run -it --rm -v $(pwd)/app:/app carlosgaro/tools:2.0