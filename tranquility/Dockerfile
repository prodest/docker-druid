FROM openjdk:8-jre-alpine

# Java config
ENV TRANQUILITY_VERSION                         0.8.0
ENV TRANQUILITY_PROPERTIES_ZOOKEEPER_CONNECT    zookeeper
ENV TRANQUILITY_PROPERTIES_HTTP_PORT            8200

# Dependencies
RUN apk update && apk add bash jq

RUN wget -q -O - \
    http://static.druid.io/tranquility/releases/tranquility-distribution-$TRANQUILITY_VERSION.tgz | tar -xzf - -C /usr/share \
    && ln -s /usr/share/tranquility-distribution-$TRANQUILITY_VERSION /usr/share/tranquility

COPY conf /usr/share/tranquility/conf

WORKDIR /usr/share/tranquility

CMD [ "./bin/tranquility", "server", "-configFile", "/usr/share/tranquility/conf/server.json" ]
