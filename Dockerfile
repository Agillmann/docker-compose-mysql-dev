FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y mariadb-server

EXPOSE 3306
VOLUME [ "./db:/docker-entrypoint-initdb.d:rw" ]
VOLUME [ "./mysql_data:/var/lib/mysql:rw" ]

LABEL version="1.0"
LABEL description="MariaDB Server"

# HEALTHCHECK --start-period=5m \
#   CMD mariadb -e 'SELECT @@datadir;' || exit 1

CMD ["mysqld"]