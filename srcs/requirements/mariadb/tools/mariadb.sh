#!/bin/bash
echo "--- DEBUG: Starting MariaDB Script ---"
echo "MYSQL_USER is: '$MYSQL_USER'"
echo "MYSQL_DATABASE is: '$MYSQL_DATABASE'"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "--- DEBUG: First boot detected, initializing database... ---"
    mysql_install_db --user=mysql --datadir=/var/lib/mysql > /dev/null

    echo "--- DEBUG: Creating init.sql... ---"
    cat << EOF > /tmp/init.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';
FLUSH PRIVILEGES;
EOF

    echo "--- DEBUG: Starting MariaDB with init file (PID 1) ---"
    exec mysqld --user=mysql --init-file=/tmp/init.sql  #--port=3307
else
    echo "--- DEBUG: Database already exists, starting normally (PID 1) ---"
    exec mysqld --user=mysql  #--port=3307
fi