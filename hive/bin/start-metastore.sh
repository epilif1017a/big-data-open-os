#!/bin/sh

if $HIVE_HOME/bin/schematool --dbType mysql --validate ; then
    echo "INFO: Metastore DB was already initialized!"
else
    $HIVE_HOME/bin/schematool --dbType mysql --initSchema ;
fi

$HIVE_HOME/bin/hive --service metastore

tail -F $HIVE_HOME/logs/metastore.log | awk '{print} /FATAL/{exit}'