#!/bin/bash
echo "--- DEBUG: Starting WordPress Script ---"
echo "MYSQL_USER is: '$MYSQL_USER'"
echo "MYSQL_DATABASE is: '$MYSQL_DATABASE'"

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "--- DEBUG: Waiting for MariaDB... ---"
    
    #mariadb port
    # until mysql -h mariadb -P 3307 -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;"; do
    until mysql -h mariadb  -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;"; do
        echo "--- DEBUG: MariaDB not ready or rejected connection, waiting 2 seconds... ---"
        sleep 2
    done

    echo "--- DEBUG: Downloading WP... ---"
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    wp core download --allow-root
    wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost=mariadb --allow-root
    # wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost=mariadb:3307 --allow-root
    wp core install --url="${DOMAIN_NAME}" --title="Inception" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
    
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PASSOWRD}" --allow-root
    echo "--- DEBUG: WP Setup Complete! ---"
fi

# force internal mariadb port update on every boot
# wp config set DB_HOST mariadb:3307 --allow-root

# configure nginx port
wp option update home 'https://gcesar-n.42.fr' --allow-root
wp option update siteurl 'https://gcesar-n.42.fr' --allow-root

# configure internal wordpress port
# sed -i 's/listen = 9000/listen = 8080/g' /etc/php/8.2/fpm/pool.d/www.conf

echo "--- DEBUG: Starting PHP-FPM ---"
exec php-fpm8.2 -F