FROM trinodb/trino:426

COPY trino/conf/hive.properties /etc/trino/catalog/
