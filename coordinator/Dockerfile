FROM prodest/druid:0.9.0-base


# clean up time
RUN apt-get purge --auto-remove -y git \
      && apt-get clean \
      && rm -rf /tmp/* \
                /var/tmp/* \
                /var/lib/apt/lists \
                /usr/local/apache-maven-3.2.5 \
                /usr/local/apache-maven \
                /root/.m2

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 3306: MySQL
# - 2181 2888 3888: ZooKeeper

EXPOSE 8081

WORKDIR /var/lib/druid


CMD java -server ${MAX_JVM_MEM_SIZE} -Duser.timezone=${TIMEZONE} -Dfile.encoding=UTF-8 -Ddruid.extensions.loadList=[\"mysql-metadata-storage\"] -Ddruid.extensions.directory=/usr/local/druid/extensions -Ddruid.extensions.hadoopDependenciesDir=/usr/local/druid/hadoop/hadoop_druid_dependencies  -Ddruid.zk.service.host=${ZOOKEEPER_HOST} -Ddruid.metadata.storage.type=mysql -Ddruid.metadata.storage.connector.connectURI=${MYSQL_JDBC_URL} -Ddruid.metadata.storage.connector.user=${MYSQL_USER} -Ddruid.metadata.storage.connector.password=${MYSQL_PASS} -Ddruid.coordinator.startDelay=${COORDINATOR_DELAY}  -cp /usr/local/druid/lib/*   io.druid.cli.Main server coordinator