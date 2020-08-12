#!/bin/bash

helm init &&

rm -rf tmp/ &&
mkdir tmp/ &&

openssl ecparam -name secp384r1 -genkey -noout -out tmp/ca.key &&
openssl req -x509 -new -nodes -key tmp/ca.key -subj "/CN=hatch-ca" -days 3650 -out tmp/ca.crt &&

kubectl create secret generic hatch-ca --from-file=tmp/ca.key --from-file=tmp/ca.crt

rm -rf tmp/
