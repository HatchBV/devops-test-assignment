#!/bin/bash

helm repo add jetstack https://charts.jetstack.io && \
  helm repo update && \
  helm install cert-manager \
    --namespace cert-manager \
    --version v1.0.4  \
    jetstack/cert-manager \
    --set installCRDs=true \
    --wait &&

rm -rf tmp/ &&
mkdir tmp/ &&

openssl ecparam -name secp384r1 -genkey -noout -out tmp/ca.key &&
openssl req -x509 -new -nodes -key tmp/ca.key -subj "/CN=hatch-ca" -days 3650 -out tmp/ca.crt &&

kubectl create secret tls hatch-ca --cert=tmp/ca.crt  --key=tmp/ca.key

rm -rf tmp/
