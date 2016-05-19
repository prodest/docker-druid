FROM prodest/druid:0.9.0-base

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 3306: MySQL
# - 2181 2888 3888: ZooKeeper

EXPOSE 8090

# Setup supervisord
ADD supervisord.conf /etc/supervisor/conf.d/overlord/supervisord.conf


WORKDIR /var/lib/druid


ENTRYPOINT exec /usr/bin/supervisord -c /etc/supervisor/conf.d/overlord/supervisord.conf