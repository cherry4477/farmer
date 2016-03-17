FROM nginx

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod u+x /usr/local/bin/confd
ADD confd.toml /etc/confd/conf.d/configuration.toml
ADD ./templates /etc/confd/templates/
ADD ./default /usr/share/nginx/html

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
