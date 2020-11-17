FROM openjdk:8u212-jre-alpine

ARG kafka_version=2.6.0
ARG scala_version=2.13
ARG glibc_version=2.31-r0

LABEL maintainer="wroujoulah"

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka 
#    GLIBC_VERSION=$glibc_version

ENV PATH=${PATH}:${KAFKA_HOME}/bin

#COPY download-kafka.sh start-kafka.sh broker-list.sh create-topics.sh versions.sh /tmp/

RUN apk add --no-cache bash curl jq docker \
 && url=$(curl --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz&as_json=1" | jq -r '"\(.preferred)\(.path_info)"') \
 && curl -sSl "$url" | tar xzf - -C /opt \
 && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}
# && rm /tmp/* 
# && chmod a+x /tmp/*.sh \
# && mv /tmp/start-kafka.sh /tmp/broker-list.sh /tmp/create-topics.sh /tmp/versions.sh /usr/bin \
# && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
# && apk add --no-cache --allow-untrusted glibc-${GLIBC_VERSION}.apk \
# && rm glibc-${GLIBC_VERSION}.apk

COPY entrypoint.sh /

VOLUME ["/kafka"]
EXPOSE 9092 9093

# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
ENTRYPOINT ["/entrypoint.sh"]
CMD ["kafka-server-start.sh", "/opt/kafka/config/kafka.properties"]
