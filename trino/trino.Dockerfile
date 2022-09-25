FROM trinodb/trino

COPY trino/conf/hive.properties /etc/trino/catalog/
