FROM openjdk:8u212-jre-alpine

ARG kafka_version=2.6.0
ARG scala_version=2.13
ARG glibc_version=2.31-r0

LABEL maintainer="wroujoulah"

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka 

ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN apk add --no-cache bash curl jq docker \
 && url=$(curl --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz&as_json=1" | jq -r '"\(.preferred)\(.path_info)"') \
 && curl -sSl "$url" | tar xzf - -C /opt \
 && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}

COPY entrypoint.sh /

VOLUME ["/kafka"]
EXPOSE 9092 9093

ENTRYPOINT ["/entrypoint.sh"]
CMD ["kafka-server-start.sh", "/opt/kafka/config/kafka.properties"]
