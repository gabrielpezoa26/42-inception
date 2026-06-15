#!/bin/bash

mysqld_safe &

until mysqladmin ping --silent 2>/dev/null; do
    sleep 1
done

mysql -u root --protocol=socket -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root --protocol=socket -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root --protocol=socket -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
mysql -u root --protocol=socket -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root --protocol=socket -e "FLUSH PRIVILEGES;"

wait
