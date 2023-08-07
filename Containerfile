FROM mingc/latex

WORKDIR "/data"

COPY scripts/ scripts/

COPY .vscode/ .vscode/

RUN mv /etc/apt/sources.list /etc/apt/sources.list.old && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute main restricted" >/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute-updates main restricted" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute universe" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute-updates universe" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute multiverse" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute-updates multiverse" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute-backports main restricted universe multiverse" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute-security main restricted" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute-security universe" >>/etc/apt/sources.list && \
    echo "deb https://old-releases.ubuntu.com/ubuntu/ hirsute-security multiverse" >>/etc/apt/sources.list

RUN apt update && apt install -y \
    default-jre \
    biber \
    inotify-tools \
    && rm -rf /var/lib/apt/lists/*
