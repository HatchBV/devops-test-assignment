FROM openjdk:8u212-jre-alpine

ARG zookeeper_version=3.6.2

LABEL maintainer="wroujoulah"

ENV ZOOKEEPER_VERSION=$zookeeper_version \
    ZOOKEEPER_HOME=/opt/zookeeper 

ENV PATH=${PATH}:${ZOOKEEPER_HOME}/bin

RUN apk add --no-cache bash curl jq tar procps \
 && url=$(curl --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz&as_json=1" | jq -r '"\(.preferred)\(.path_info)"') \
 && curl -sSl "$url" | tar xzf - -C /opt \
 && ln -s /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin ${ZOOKEEPER_HOME} 

COPY entrypoint.sh /

VOLUME ["/zookeeper"]
EXPOSE 2181 2182

ENTRYPOINT ["/entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]
