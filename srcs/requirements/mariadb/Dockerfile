FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

RUN sed -i 's/bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["mariadb.sh"]