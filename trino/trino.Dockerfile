FROM trinodb/trino:426

COPY trino/conf/hive.properties /etc/trino/catalog/
COPY trino/conf/delta_lake.properties /etc/trino/catalog/
