# CA Issuer Helm Chart

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![AppVersion: 1.0](https://img.shields.io/badge/AppVersion-1.0-informational?style=flat-square)

This is an implementation of CA Issuer for **Hatch BV devops-test-assignment**

## Pre Requisites:

* Kubernetes `1.18` with alpha APIs enabled and support for storage classes

* helm version `v3.4.1` (need to be install and configure with minikube)

* Cert-Manager `v1.0.4` with CRDs (will be covered in the init.sh script)

## Chart Details

This chart will do the following:

* Create one Issuer from CRD resource created by cert-manager

### Installing the Chart

To install the chart with the release name `ca-issuer` in the default namespace:

```
$ helm install ca-issuer charts/ca-issuer
```

The chart can be customized using the following configurable parameters:

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| ca.secretName | string | `"hatch-ca"` | Secret resource of type TLS which contain the certificate and the key that will be used as CA |
