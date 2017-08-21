FROM ubuntu:14.04

# Java config
ENV TRANQUILITY_VERSION                         0.8.0
ENV TRANQUILITY_PROPERTIES_ZOOKEEPER_CONNECT    $ZOOKEEPER_HOST
ENV TRANQUILITY_PROPERTIES_HTTP_PORT            8200

# Java 8
RUN apt-get update \
      && apt-get install -y software-properties-common \
      && apt-add-repository -y ppa:webupd8team/java \
      && apt-get purge --auto-remove -y software-properties-common \
      && apt-get update \
      && echo oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
      && apt-get install -y oracle-java8-installer oracle-java8-set-default \
      && apt-get clean \
      && rm -rf /var/cache/oracle-jdk8-installer \
      && rm -rf /var/lib/apt/lists/*

RUN wget -q -O - \
    http://static.druid.io/tranquility/releases/tranquility-distribution-$TRANQUILITY_VERSION.tgz | tar -xzf - -C /usr/share \
    && ln -s /usr/share/tranquility-distribution-$TRANQUILITY_VERSION /usr/share/tranquility

COPY conf /usr/share/tranquility-distribution-$TRANQUILITY_VERSION/conf

WORKDIR /usr/share/tranquility

CMD [ "./bin/tranquility", "server", "-configFile /usr/share/tranquility-distribution-$TRANQUILITY_VERSION/conf/server.json" ]
