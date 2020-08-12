#!/bin/bash

ls charts/ | while read l ; do
  helm delete --purge ${l}
  helm install --namespace default --name ${l} charts/${l}/
done
