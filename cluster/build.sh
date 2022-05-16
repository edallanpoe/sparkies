#!/bin/bash

set -e
CLUSTER_PATH=$(dirname $(dirname $(realpath $0)))

echo -e "\n[INFO] Creating master pod ..."
kubectl create -f $CLUSTER_PATH/cluster/kubernetes/spark-master-deployment.yaml 
kubectl create -f $CLUSTER_PATH/cluster/kubernetes/spark-master-service.yaml

sleep 10

echo -e "\n[INFO] Creating executor pods ..."
kubectl create -f $CLUSTER_PATH/cluster/kubernetes/spark-executor-deployment.yaml

echo -e "\n[INFO] Applying ingress to cluster ..."
minikube addons enable ingress

kubectl apply -f $CLUSTER_PATH/cluster/kubernetes/minikube-ingress.yaml
echo -e "\n[INFO] Adding ingress entry to hosts ..."
echo "$(minikube ip) spark-kubernetes" | sudo tee -a /etc/hosts

sleep 30

echo -e "\n[INFO] Deployments:"
kubectl get deployments
echo -e "\n[INFO] Services:"
kubectl get services
echo -e "\n[INFO] Pods:"
kubectl get pods

echo "[INFO] Done."
