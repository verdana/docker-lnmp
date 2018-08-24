#!/bin/sh

mysql_container_id=`docker ps -aqf "name=docker-mysql"`
echo "MySQL Container ID: $mysql_container_id"

echo "Change the permissions of /var/run/mysqld to 755"
docker exec -i $mysql_container_id chmod -Rf 755 /var/run/mysqld

echo "Change localhost to 127.0.0.1"
docker exec -i $mysql_container_id mysql --user=root --password=mysql <<EOF
    UPDATE mysql.user SET Host='127.0.0.1' WHERE Host='localhost';
    UPDATE mysql.tables_priv SET Host='127.0.0.1' WHERE Host='localhost';
    UPDATE mysql.db SET Host='127.0.0.1' WHERE Host='localhost';
    UPDATE mysql.proxies_priv SET Host='127.0.0.1' WHERE Host = 'localhost';
    FLUSH PRIVILEGES;
EOF

