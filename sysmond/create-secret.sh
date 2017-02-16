#!/bin/sh
kubectl \
  --namespace=kube-system \
  create secret generic \
    newrelic \
      --from-literal=license_key=8888888822ccccccccccccc333aaaaaaaaaa4444 \
      --from-literal=logfile=/var/log/nrsysmond.log \
      --from-literal=loglevel=warning
