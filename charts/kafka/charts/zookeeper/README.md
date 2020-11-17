# Apache ZooKeeper Helm Chart

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

This is an implementation of ZooKeeper StatefulSet for **Hatch BV devops-test-assignment**
Encryption, Authentication, Authorization **mTLS** for ZooKeeper will be the **_Default_** option and can be disabled as will be shown bellow

## Pre Requisites:

* Kubernetes `1.18` with alpha APIs enabled and support for storage classes

* PV support on underlying infrastructure (Minicube `v1.12.1` will cover Kubernetes req too)

* helm version `v3.4.1` (need to be install and configure with minikube)

* Cert-Manager `v1.0.4` with CRDs (will be covered in the init.sh scripit)

## Chart Details

This chart will do the following:

* Implement a one node zookeeper cluster as another Kubernetes StatefulSet required for the Kafka cluster above

* Create a certificate which will be used in ZooKeeper using Kubernetes CRD Certificate

* Persistence volume will be created (if it is enabled)

### Installing the Chart

To install the chart with the release name `zookeeper` in the default namespace:

```
$ helm install zookeeper charts/zookeeper
```

**NOTE:** This chart is a dependency to the Kafka cluster and can be by it is own. The chart can be customized using the following configurable parameters:

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` | ZooKeeper Container image |
| image.repository | string | `"localhost/my_zookeeper"` | ZooKeeper Container image |
| image.tag | string | `"latest"` | ZooKeeper Container image |
| persistence.enabled | bool | `true` | Use a PVC to persist data |
| persistence.size | string | `"1Gi"` | Size of data volume |
| security.certificate.keystores.password | string | `"ZooKeeperPassword"` | Password for the KeyStores for ZooKeeper server certificate |
| security.enabled | bool | `true` | Enable ZooKeeper Security ( mTls ) |
| service.headless.enabled | bool | `true` | Enable headless service (it will be auto enabled is security is enabled) |
| service.port | int | `2181` | TCP port configured at cluster services (used if security is disabled) |
| service.securePort | int | `2182` | Secure TCP port configured to access ZooKeeper cluster and for Headless service |
| service.type | string | `"ClusterIP"` | Service Type (only ClusterIP supported for now). |
