#!/bin/bash

eval $(minikube -p minikube docker-env)

ls build/ | while read l ; do
  docker build -t localhost/my_${l}:latest build/${l}/
done
