# Test Client Helm Chart

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

This chart is to provide a way to run tests against Kafka/zookeeper in the Kubernetes cluster

## Pre Requisites:

* Kubernetes `1.18` with alpha APIs enabled and support for storage classes

* helm version `v3.4.1` (need to install and configure with minikube)

* Cert-Manager `v1.0.4` with CRDs (will be covered in the init.sh script)

* CA Issuer

## Chart Details

This chart will do the following:

* Implement one node with Kafka scripts using Kubernetes StatefulSets

* Create a certificate which will be used to test the Kafka cluster  using Kubernetes CRD Certificate

* Test script and Config file to connect to Kafka cluster in `/tests/`

### Installing the Chart

To install the chart with the release name `test-client` in the default namespace:

```
$ helm install test-client charts/test-client
```

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| caIssuer.name | string | `"ca-issuer"` | Certificate authority issuer CRD created by Cert-Manager |
| certificate.keystores.password | string | `"testPassword"` | Keystores password |
| enabled | bool | `true` | Enable the chart |
| image | string | `"localhost/my_kafka:latest"` | Test client docker image |

### Running testing script

Access the client:
```
$ kubectl exec -it test-client-0 -- bash
```
Run the script from inside the client:
```
$ bash /tests/runTest.sh
```
The config file will be aviable at `/tests/clientSSL.properties`
