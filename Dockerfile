FROM ubuntu:16.04
MAINTAINER KUDO Shunsuke

# ARG PROXY=
ARG http_proxy=$PROXY
ARG https_proxy=$PROXY
ARG HTTP_PROXY=$PROXY
ARG HTTPS_PROXY=$PROXY

RUN sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y \
    curl \
    fcitx-mozc \
    iproute2 \
    language-pack-ja \
    software-properties-common \
    sudo \
    systemd \
    vim \
    wget \
    whois \
    && rm -rf /var/lib/apt/lists/*


RUN add-apt-repository ppa:x2go/stable && \
    apt update && apt install -y x2goserver x2goserver-xsession

ARG USR=dev
RUN useradd -m -p `echo "$USR" | mkpasswd -s -m sha-512` -s /bin/bash $USR && gpasswd -a $USR sudo

CMD ["/sbin/init"]

