# sparkies
Spark public projects and cluster definition on Kubernetes


Run pyspark client 
```bash

MASTER_POD_NAME=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $1}')
MASTER_POD_IP=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $6}')

kubectl exec $MASTER_POD_NAME -it -- \
    pyspark \
        --conf spark.driver.bindAddress=$MASTER_POD_IP \
        --conf spark.driver.host=$MASTER_POD_IP \
        --deploy-mode client \
        --master spark://spark-master:7077

```

Run Spark Scala client
```bash

MASTER_POD_NAME=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $1}')
MASTER_POD_IP=$(kubectl get pods -o wide | grep spark-master | awk -P '{print $6}')

kubectl exec $MASTER_POD_NAME -it -- \
    spark-shell \
        --conf spark.driver.bindAddress=$MASTER_POD_IP \
        --conf spark.driver.host=$MASTER_POD_IP \
        --deploy-mode client \
        --master spark://spark-master:7077

```