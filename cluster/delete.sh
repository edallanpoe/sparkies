#!/bin/bash

set -e

CLUSTER_PATH=$(dirname $(realpath $0))

echo -e "\n[INFO] Deleting nodes ..."
kubectl delete -f $CLUSTER_PATH/kubernetes/spark-master-deployment.yaml --ignore-not-found=true || true
kubectl delete -f $CLUSTER_PATH/kubernetes/spark-master-service.yaml --ignore-not-found=true || true
kubectl delete -f $CLUSTER_PATH/kubernetes/spark-executor-deployment.yaml --ignore-not-found=true || true
kubectl delete -f $CLUSTER_PATH/kubernetes/minikube-ingress.yaml --ignore-not-found=true || true
