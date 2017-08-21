FROM ubuntu:14.04

# Java config
ENV TRANQUILITY_VERSION                         0.8.0
ENV TRANQUILITY_PROPERTIES_ZOOKEEPER_CONNECT    $ZOOKEEPER_HOST
ENV TRANQUILITY_PROPERTIES_HTTP_PORT            8200

RUN wget -q -O - \
    http://static.druid.io/tranquility/releases/tranquility-distribution-$TRANQUILITY_VERSION.tgz \
    | tar -xzf - -C /usr/share \
    && ln -s /usr/share/tranquility-distribution-$TRANQUILITY_VERSION /usr/share/tranquility

COPY conf /usr/share/tranquility-distribution-$TRANQUILITY_VERSION/conf

WORKDIR /usr/share/tranquility

CMD ['./bin/tranquility', 'server', '-configFile /usr/share/tranquility-distribution-$TRANQUILITY_VERSION/conf/server.json']
