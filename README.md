# sparkies
Spark public projects and cluster definition on Kubernetes

## Dependencies
* poetry ~1.1.13
* GNU Make ~4.2.1

## Deployment
Execute:
```bash
make local-cluster
```

## Important
***Remember to run the deployment of the local cluster using the poetry shell.***

## Run pyspark client 
```bash

export MASTER_POD_NAME=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $1}')
export MASTER_POD_IP=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $6}')

kubectl exec $MASTER_POD_NAME -it -- \
    pyspark \
        --py-files /opt/src/sparkies_bundle.zip \ # Dependencies 
        --conf spark.driver.bindAddress=$MASTER_POD_IP \
        --conf spark.driver.host=$MASTER_POD_IP \
        --deploy-mode client \
        --master spark://spark-master:7077

```

## Executing a Python script
```bash
# If the file is already present within the container ...

export MASTER_POD_NAME=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $1}')
export MASTER_POD_IP=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $6}')
kubectl exec $MASTER_POD_NAME -it -- \
    spark-submit \
        --py-files /opt/src/sparkies_bundle.zip \ # Dependencies 
        --conf spark.driver.bindAddress=$MASTER_POD_IP \
        --conf spark.driver.host=$MASTER_POD_IP \
        --deploy-mode client \
        --master spark://spark-master:7077 \
        /opt/src/python/test.py
```

OR

```bash
# If there is a new version or the file does not exists ...

export MASTER_POD_NAME=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $1}')
export MASTER_POD_IP=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $6}')

kubectl cp /path/to/source $MARTER_POD_NAME:/path/to/target

kubectl exec $MASTER_POD_NAME -it -- \
    spark-submit \
        --py-files /opt/src/sparkies_bundle.zip \ # Dependencies 
        --conf spark.driver.bindAddress=$MASTER_POD_IP \
        --conf spark.driver.host=$MASTER_POD_IP \
        --deploy-mode client \
        --master spark://spark-master:7077 \
        /path/to/target
```



## Run Spark Scala client
```bash

export MASTER_POD_NAME=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $1}')
export MASTER_POD_IP=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $6}')

kubectl exec $MASTER_POD_NAME -it -- \
    spark-shell \
        --conf spark.driver.bindAddress=$MASTER_POD_IP \
        --conf spark.driver.host=$MASTER_POD_IP \
        --deploy-mode client \
        --master spark://spark-master:7077

```