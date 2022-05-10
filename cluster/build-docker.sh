#!/bin/bash

CLUSTER_PATH=$(dirname $(realpath $0))

MINIKUBE_STATUS=$(minikube status -o JSON)
if [ "Running" == "$(echo $MINIKUBE_STATUS | jq -r '.Host')" ] && \
    [ "Running" == "$(echo $MINIKUBE_STATUS | jq -r '.APIServer')" ]; then
    echo "[INFO] minikube already started ..."
else
    echo "[INFO] Starting minikube ..."
    minikube start --memory 8192 --cpus 4
fi

echo "[INFO] Building Docker image ..."
eval $(minikube docker-env)
docker build -t spark-hadoop:3.2.0 -f $CLUSTER_PATH/Dockerfile $CLUSTER_PATH

echo "[INFO] Docker image built ..."
