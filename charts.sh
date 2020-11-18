#!/bin/bash

ls charts/ | while read l ; do
  helm3 uninstall ${l}
  helm3 install ${l} --namespace default charts/${l}/
done
