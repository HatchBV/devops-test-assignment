# Apache Kafka Helm Chart

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

This is an implementation of Kafka/ZooKeeper StatefulSet for **Hatch BV devops-test-assignment**
Encryption, Authentication, Authorization using **two-way TLS** for Kafka broker and **mTLS** for ZooKeeper will be the **_Default_** option and can be disabled as will be shown bellow

## Pre Requisites:

* Kubernetes `1.18` with alpha APIs enabled and support for storage classes

* PV support on underlying infrastructure (Minicube `v1.12.1` will cover Kubernetes req too)

* helm version `v3.4.1` (need to be install and configure with minikube)

* Cert-Manager `v1.0.4` with CRDs (will be covered in the init.sh script)

* CA Issuer

## Chart Details

This chart will do the following:

* Implement a one node Kafka cluster using Kubernetes StatefulSets

* Implement a one node zookeeper cluster as another Kubernetes StatefulSet required for the Kafka cluster above

* Create two certificates which will be used in Kafka using Kubernetes CRD Certificate

* Create a certificate which will be used in ZooKeeper using Kubernetes CRD Certificate

* Persistence volume will be created (if it is enabled)

### Installing the Chart

To install the chart with the release name `kafka` in the default namespace:

```
$ helm install kafka charts/kafka
```

**NOTE:** This chart includes a ZooKeeper chart as a dependency to the Kafka cluster in its charts/ dir. The chart can be customized using the following configurable parameters:

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| caIssuer.name | string | `"ca-issuer"` | Certificate authority issuer CRD created by Cert-Manager |
| image.pullPolicy | string | `"IfNotPresent"` | Kafka Container pull policy |
| image.repository | string | `"localhost/my_kafka"` | Kafka Container image |
| image.tag | string | `"latest"` | Kafka Container image tag |
| persistence.enabled | bool | `true` | Use a PVC to persist data |
| persistence.size | string | `"1Gi"` | Size of data volume |
| security.broker.acl.extraSuperUsers | string | `"User:CN=KafkaClient"` | Kafka extra super users to be added to ACL, example "User:CN=a;User:CN=b" |
| security.broker.certificate.keystores.password | string | `"KafkaPassword"` | Password for the KeyStores for Kafka broker certificate |
| security.broker.enabled | bool | `true` | Enable Kafka Security ( Two-way TLS, ACL) |
| security.zookeeper.certificate.keystores.password | string | `"KafkaZKPassword"` | Password for the KeyStores for ZooKeeper client certificate |
| security.zookeeper.enabled | bool | `true` | Enable Kafka Secure connection to ZooKeeper ( Two-way TLS, ACL) |
| service.extSecurePort | int | `9093` | Secure TCP port configured to access Kafka cluster |
| service.headless.enabled | bool | `true` | Enable headless service (it will be auto enabled is security is enabled) |
| service.interSecurePort | int | `9094` | Secure TCP port configured to access Kafka per Broker (Headless) |
| service.port | int | `9092` | TCP port configured at cluster services (used if security is disabled) |
| service.type | string | `"ClusterIP"` | Service Type (only ClusterIP supported for now). |
| zookeeper.caIssuer.name | string | `"ca-issuer"` | Certificate authority issuer CRD created by Cert-Manager |
| zookeeper.image.pullPolicy | string | `"IfNotPresent"` | ZooKeeper Container image |
| zookeeper.image.repository | string | `"localhost/my_zookeeper"` | ZooKeeper Container image |
| zookeeper.image.tag | string | `"latest"` | ZooKeeper Container image |
| zookeeper.persistence.enabled | bool | `true` | Use a PVC to persist data |
| zookeeper.persistence.size | string | `"1Gi"` | Size of data volume |
| zookeeper.security.certificate.keystores.password | string | `"ZooKeeperPassword"` | Password for the KeyStores for ZooKeeper server certificate |
| zookeeper.security.enabled | bool | `true` | Enable ZooKeeper Security ( mTls ) |
| zookeeper.service.headless.enabled | bool | `true` | Enable headless service (it will be auto enabled is security is enabled) |
| zookeeper.service.port | int | `2181` | TCP port configured at cluster services (used if security is disabled) |
| zookeeper.service.securePort | int | `2182` | Secure TCP port configured to access ZooKeeper cluster and for Headless service |
| zookeeper.service.type | string | `"ClusterIP"` | Service Type (only ClusterIP supported for now). |

### Testing

To test the **kafka/zookeeper** clusters please check **test-client** chart

---------------------------------------
