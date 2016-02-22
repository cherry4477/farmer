FROM golang:1.4

RUN \
    apt-get update -y --fix-missing && \
    apt-get install --force-yes -y git && \
    curl -L https://github.com/docker/compose/releases/download/1.6.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    wget -qO- https://get.docker.com/ | sh && \
    chmod +x /usr/local/bin/docker-compose

RUN \
    git config --global user.name "toolbelt" && \
    git config --global user.email "toolbelt@ravaj.ir"

COPY ./daemon /go/src/github.com/ravaj-group/farmer/toolbelt_daemon/daemon
WORKDIR  /go/src/github.com/ravaj-group/farmer/toolbelt_daemon/daemon

RUN \
    go get -d -v && \
    go install -v

EXPOSE 80
VOLUME "/root/.docker"

CMD ["/bin/bash", "-c", "rm -rf /toolbelt-src && git clone https://github.com/ravaj-group/toolbelt.git /toolbelt-src --depth=1 && ln -fs /toolbelt-src/toolbelt /usr/bin/ &>/dev/null && daemon"]
