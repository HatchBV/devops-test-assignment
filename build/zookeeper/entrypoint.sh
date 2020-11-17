#!/bin/bash

if [[ ! -z $ZOO_SECURE ]]; then
    if [[ -z "$ZOO_SSL_KEYSTORE_LOCATION" ]]; then 
        echo "ERROR: Missing environment variable ZOO_SSL_KEYSTORE_LOCATION. Must be specified when using ZOO_SECURE"
        exit 1
    fi
    if [[ ! -f "$ZOO_SSL_KEYSTORE_LOCATION" ]]; then 
        echo "ERROR: File not exist in $ZOO_SSL_KEYSTORE_LOCATION."
        exit 1
    fi
    if [[ -z "$ZOO_SSL_KEYSTORE_PASSWORD" ]]; then 
        echo "ERROR: Missing environment variable ZOO_SSL_KEYSTORE_PASSWORD. Must be specified when using ZOO_SECURE"
        exit 1
    fi
    if [[ -z "$ZOO_SSL_TRUSTSTORE_LOCATION" ]]; then 
        echo "ERROR: Missing environment variable ZOO_SSL_TRUSTSTORE_LOCATION. Must be specified when using ZOO_SECURE"
        exit 1
    fi
    if [[ ! -f "$ZOO_SSL_TRUSTSTORE_LOCATION" ]]; then 
        echo "ERROR: File not exist in $ZOO_SSL_TRUSTSTORE_LOCATION."
        exit 1
    fi

    if [[ -z "$ZOO_SSL_TRUSTSTORE_PASSWORD" ]]; then 
        echo "ERROR: Missing environment variable ZOO_SSL_TRUSTSTORE_PASSWORD. Must be specified when using ZOO_SECURE"
        exit 1
    fi

    SEC_CONFIG="${ZOOKEEPER_HOME}/conf/zoo.cfg"
    {
        echo "secureClientPort=2182"
        echo "serverCnxnFactory=org.apache.zookeeper.server.NettyServerCnxnFactory"
        echo "authProvider.x509=org.apache.zookeeper.server.auth.X509AuthenticationProvider"
        echo "ssl.clientAuth=need"
        echo "ssl.keyStore.location=${ZOO_SSL_KEYSTORE_LOCATION}"
        echo "ssl.keyStore.password=${ZOO_SSL_KEYSTORE_PASSWORD}"
        echo "ssl.trustStore.location=${ZOO_SSL_TRUSTSTORE_LOCATION}"
        echo "ssl.trustStore.password=${ZOO_SSL_TRUSTSTORE_PASSWORD}"
        echo "sslQuorum=true"
        echo "ssl.quorum.keyStore.location=${ZOO_SSL_KEYSTORE_LOCATION}"
        echo "ssl.quorum.keyStore.password=${ZOO_SSL_KEYSTORE_PASSWORD}"
        echo "ssl.quorum.trustStore.location=${ZOO_SSL_TRUSTSTORE_LOCATION}"
        echo "ssl.quorum.trustStore.password=${ZOO_SSL_TRUSTSTORE_PASSWORD}"
    } >> "${SEC_CONFIG}"
fi

CONFIG="${ZOOKEEPER_HOME}/conf/zoo.cfg"
{
    echo "dataDir=/zookeeper" 
    echo "clientPort=2181"
    echo "tickTime=2000"
    echo "initLimit=5"
    echo "syncLimit=2"
} >> "${CONFIG}"

exec "$@"
