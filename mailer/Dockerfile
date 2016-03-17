FROM ubuntu:trusty

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y

# Install Exim
ADD exim.debconf /root/
RUN debconf-set-selections < /root/exim.debconf && \
    apt-get install -y --force-yes openssl exim4 && \
    groupadd ssl && \
    usermod -a -G ssl Debian-exim

ADD exim4.conf /etc/exim4/exim4.conf

# Install Confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod u+x /usr/local/bin/confd
ADD ./confd /etc/confd/conf.d/
ADD ./templates /etc/confd/templates/

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 25 465

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]