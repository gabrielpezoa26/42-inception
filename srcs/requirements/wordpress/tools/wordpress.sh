#!/bin/bash
echo "--- DEBUG: Starting WordPress Script ---"
echo "MYSQL_USER is: '$MYSQL_USER'"
echo "MYSQL_DATABASE is: '$MYSQL_DATABASE'"

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f wp-config.php ]; then
    echo "--- DEBUG: Waiting for MariaDB... ---"
    
    # Notice we removed the silencers so errors print to your terminal!
    until mysql -h mariadb -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;"; do
        echo "--- DEBUG: MariaDB not ready or rejected connection, waiting 2 seconds... ---"
        sleep 2
    done

    echo "--- DEBUG: MariaDB connected! Downloading WP... ---"
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    wp core download --allow-root
    wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost=mariadb --allow-root
    wp core install --url="${DOMAIN_NAME}" --title="Inception" --admin_user="${WP_ADMIN_USER}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
    
    # Note: You have a typo in your .env file (WP_USER_PASSOWRD), so ensure this matches exactly what's in your .env
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PASSOWRD}" --allow-root
    echo "--- DEBUG: WP Setup Complete! ---"
fi

echo "--- DEBUG: Starting PHP-FPM ---"
exec php-fpm8.2 -F