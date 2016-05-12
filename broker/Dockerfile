FROM ubuntu:14.04

# Java 8
RUN   apt-get update  \
      && apt-get install -y software-properties-common \
      && apt-add-repository -y ppa:webupd8team/java \
      && apt-get purge --auto-remove -y software-properties-common \
      && apt-get update \
      && echo oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
      && apt-get install -y oracle-java8-installer \
      && apt-get install -y oracle-java8-set-default \
      && rm -rf /var/cache/oracle-jdk8-installer


# Supervisor
RUN apt-get install -y supervisor

# git
RUN apt-get install -y git

# Maven
RUN wget -q -O - http://archive.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz | tar -xzf - -C /usr/local \
      && ln -s /usr/local/apache-maven-3.2.5 /usr/local/apache-maven \
      && ln -s /usr/local/apache-maven/bin/mvn /usr/local/bin/mvn


# Druid system user
RUN adduser --system --group --no-create-home druid \
      && mkdir -p /var/lib/druid \
      && chown druid:druid /var/lib/druid


# Druid (from source)
RUN mkdir -p /usr/local/druid/lib
# whichever github owner (user or org name) you would like to build from
ENV GITHUB_OWNER druid-io
# whichever branch you would like to build
ENV DRUID_VERSION master

# trigger rebuild only if branch changed
ADD https://api.github.com/repos/$GITHUB_OWNER/druid/git/refs/heads/$DRUID_VERSION druid-version.json
RUN git clone -q --branch $DRUID_VERSION --depth 1 https://github.com/$GITHUB_OWNER/druid.git /tmp/druid
WORKDIR /tmp/druid
# package and install Druid locally
# use versions-maven-plugin 2.1 to work around https://jira.codehaus.org/browse/MVERSIONS-285
RUN mvn -U -B org.codehaus.mojo:versions-maven-plugin:2.1:set -DgenerateBackupPoms=false -DnewVersion=$DRUID_VERSION \
  && mvn -U -B install -DskipTests=true -Dmaven.javadoc.skip=true \
  && cp services/target/druid-services-$DRUID_VERSION-selfcontained.jar /usr/local/druid/lib

RUN cp -r distribution/target/extensions /usr/local/druid/
RUN cp -r distribution/target/hadoop-dependencies /usr/local/druid/

# clean up time
RUN apt-get purge --auto-remove -y git \
      && apt-get clean \
      && rm -rf /tmp/* \
                /var/tmp/* \
                /var/lib/apt/lists \
                /usr/local/apache-maven-3.2.5 \
                /usr/local/apache-maven \
                /root/.m2

WORKDIR /



# Setup supervisord
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 8090: HTTP (overlord)
# - 3306: MySQL
# - 2181 2888 3888: ZooKeeper

EXPOSE 8082

WORKDIR /var/lib/druid
ENTRYPOINT export HOSTIP="$(resolveip -s $HOSTNAME)" && exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
