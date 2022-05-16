import os

from pyspark.sql import SparkSession
from pyspark.sql.types import DateType, StringType, StructField, StructType

spark = SparkSession.builder\
    .appName("TestPyScript")\
    .enableHiveSupport()\
    .getOrCreate()

raw_data = spark.read.csv(
    os.path.join(os.path.dirname(os.path.abspath(__file__)), 'data/multiTimeline.csv.gz'),
    schema=StructType([
        StructField('week', DateType(), True),
        StructField('interests', StringType(), True)
    ])
)

raw_data.show(20)
