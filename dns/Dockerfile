FROM sameersbn/bind:latest

ADD named.conf.local /etc/bind/named.conf.local
ADD zones/db.catchall.tpl /etc/bind/zones/db.catchall

COPY farmer-entrypoint.sh /sbin/farmer-entrypoint.sh
RUN chmod 755 /sbin/farmer-entrypoint.sh

ENTRYPOINT ["/sbin/farmer-entrypoint.sh"]