#!/bin/bash

CONFIG="$KAFKA_HOME/config/kafka.properties"

if [[ -z "$KAFKA_ZOO_HOST" ]]; then
    echo "ERROR: Missing environment variable KAFKA_ZOO_HOST."
    exit 1
fi

if [[ ! -z $KAFKA_SECURE ]]; then
    if [[ -z "$KAFKA_SSL_KEYSTORE_LOCATION" ]]; then 
        echo "ERROR: Missing environment variable KAFKA_SSL_KEYSTORE_LOCATION. Must be specified when using KAFKA_SECURE"
        exit 1
    fi
    if [[ -z "$KAFKA_SSL_KEYSTORE_PASSWORD" ]]; then 
        echo "ERROR: Missing environment variable KAFKA_SSL_KEYSTORE_PASSWORD. Must be specified when using KAFKA_SECURE"
        exit 1
    fi
    if [[ -z "$KAFKA_SSL_TRUSTSTORE_LOCATION" ]]; then 
        echo "ERROR: Missing environment variable KAFKA_SSL_TRUSTSTORE_LOCATION. Must be specified when using KAFKA_SECURE"
        exit 1
    fi

    if [[ -z "$KAFKA_SSL_TRUSTSTORE_PASSWORD" ]]; then 
        echo "ERROR: Missing environment variable KAFKA_SSL_TRUSTSTORE_PASSWORD. Must be specified when using KAFKA_SECURE"
        exit 1
    fi
    {
        echo "security.protocol=SSL"
        echo "ssl.client.auth=required"
        echo "ssl.enabled.protocols=TLSv1.2"
        echo "ssl.truststore.location=$KAFKA_SSL_TRUSTSTORE_LOCATION"
        echo "ssl.truststore.password=$KAFKA_SSL_TRUSTSTORE_PASSWORD"
        echo "ssl.keystore.location=$KAFKA_SSL_KEYSTORE_LOCATION"
        echo "ssl.keystore.password=$KAFKA_SSL_KEYSTORE_PASSWORD"
        echo "listeners=SSL://0.0.0.0:9094,EXTERNAL_SSL://0.0.0.0:9093"
        echo "advertised.listeners=SSL://${POD_NAME}.${KAFKA_SSL_SERVICE_HEADLESS}:9094,EXTERNAL_SSL://${KAFKA_SSL_SERVICE}:9093"
        echo "security.inter.broker.protocol=SSL"
        echo "listener.security.protocol.map=EXTERNAL_SSL:SSL,SSL:SSL"
        echo "authorizer.class.name=kafka.security.authorizer.AclAuthorizer"
#        echo "allow.everyone.if.no.acl.found=true"
        echo "super.users=User:CN=Broker;$KAFKA_ACL_SUPER_USERS"
    } >> "${CONFIG}"
else
    {
        echo "listeners=PLAINTEXT://0.0.0.0:9092"
        echo "advertised.listeners=PLAINTEXT://${POD_IP}:9092"
    } >> "${CONFIG}"
fi

if [[ ! -z $KAFKA_ZOO_SECURE ]]; then
    if [[ -z "$KAFKA_ZOO_SSL_KEYSTORE_LOCATION" ]]; then
        echo "ERROR: Missing environment variable KAFKA_ZOO_SSL_KEYSTORE_LOCATION. Must be specified when using KAFKA_SECURE"
        exit 1
    fi
    if [[ -z "$KAFKA_ZOO_SSL_KEYSTORE_PASSWORD" ]]; then
        echo "ERROR: Missing environment variable KAFKA_ZOO_SSL_KEYSTORE_PASSWORD. Must be specified when using KAFKA_SECURE"
        exit 1
    fi
    if [[ -z "$KAFKA_ZOO_SSL_TRUSTSTORE_LOCATION" ]]; then
        echo "ERROR: Missing environment variable KAFKA_ZOO_SSL_TRUSTSTORE_LOCATION. Must be specified when using KAFKA_SECURE"
        exit 1
    fi

    if [[ -z "$KAFKA_ZOO_SSL_TRUSTSTORE_PASSWORD" ]]; then
        echo "ERROR: Missing environment variable KAFKA_ZOO_SSL_TRUSTSTORE_PASSWORD. Must be specified when using KAFKA_SECURE"
        exit 1
    fi

    if [[ -z "$KAFKA_ZOO_SECURE_PORT" ]]; then           
        echo "ERROR: Missing environment variable KAFKA_ZOO_SECURE_PORT. Must be specified when using KAFKA_SECURE"
        exit 1
    fi

    {
        echo "zookeeper.connect=${KAFKA_ZOO_HOST}:${KAFKA_ZOO_SECURE_PORT}"
        echo "zookeeper.ssl.client.enable=true"
        echo "zookeeper.clientCnxnSocket=org.apache.zookeeper.ClientCnxnSocketNetty"
        echo "zookeeper.ssl.keystore.location=$KAFKA_ZOO_SSL_KEYSTORE_LOCATION"
        echo "zookeeper.ssl.keystore.password=$KAFKA_ZOO_SSL_KEYSTORE_PASSWORD"
        echo "zookeeper.ssl.truststore.location=$KAFKA_ZOO_SSL_TRUSTSTORE_LOCATION"
        echo "zookeeper.ssl.truststore.password=$KAFKA_ZOO_SSL_KEYSTORE_PASSWORD"
        echo "zookeeper.set.acl=true"
    } >> "${CONFIG}"
else
    if [[ -z "$KAFKA_ZOO_PORT" ]]; then
        echo "ERROR: Missing environment variable KAFKA_ZOO_PORT."
        exit 1
    fi
    {
        echo "zookeeper.connect=${KAFKA_ZOO_HOST}:${KAFKA_ZOO_PORT}"
    } >> "${CONFIG}"
fi

{
    echo "broker.id=0"
    echo "num.network.threads=3"
    echo "num.io.threads=8"
    echo "socket.send.buffer.bytes=102400"
    echo "socket.receive.buffer.bytes=102400"
    echo "socket.request.max.bytes=104857600"
    echo "log.dirs=/kafka"
    echo "num.partitions=1"
    echo "num.recovery.threads.per.data.dir=1"
    echo "offsets.topic.replication.factor=1"
    echo "transaction.state.log.replication.factor=1"
    echo "transaction.state.log.min.isr=1"
    echo "log.retention.hours=168"
    echo "log.segment.bytes=1073741824"
    echo "log.retention.check.interval.ms=300000"
    echo "zookeeper.connection.timeout.ms=18000"
    echo "group.initial.rebalance.delay.ms=0"
} >> "${CONFIG}"

exec "$@"
