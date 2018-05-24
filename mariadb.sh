#!/bin/bash

MYSQL_WORKDIR=/dataroot/mariadb
MYSQL_TMPDIR=$MYSQL_WORKDIR/tmp/mysql/  #TMP dir where mysql can play

if [ ! -d "$MYSQL_WORKDIR" ]; then
    mkdir -p $MYSQL_WORKDIR
    mkdir -p $MYSQL_TMPDIR
    chmod 777 $MYSQL_WORKDIR
    chmod 777 $MYSQL_TMPDIR

    cat /set_password.sql /dbreport_nodata.sql > /tmp/init.sql
    nohup mysqld_safe --init-file=/tmp/init.sql &
    sleep 10

#    mysql -u root -e "create database aibenchtmp"
#    mysql -u root aibenchtmp < /tmp/init.sql
    /etc/init.d/mysql stop

    cp -R -p /var/lib/mysql/ $MYSQL_WORKDIR
fi

echo -e "[mysqld]\ndatadir=${MYSQL_WORKDIR}/mysql\ntmpdir=${MYSQL_TMPDIR}" >> /etc/my.cnf
/etc/init.d/mysql start

#set -e
#
#if [ "${1:0:1}" = '-' ]; then
#	set -- mysqld_safe "$@"
#fi
#
#MYSQL_ROOT_PASSWORD=password
#
#if [ "$1" = 'mysqld_safe' ]; then
#	DATADIR="/var/lib/mysql"
#	ln -s /var/lib/mysql /dataroot/mariadb
#
#	if [ ! -d "$DATADIR/mysql" ]; then
#		if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
#			echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
#			echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
#			exit 1
#		fi
#
#		echo 'Running mysql_install_db ...'
#		mysql_install_db --datadir="$DATADIR"
#		echo 'Finished mysql_install_db'
#
#		# These statements _must_ be on individual lines, and _must_ end with
#		# semicolons (no line breaks or comments are permitted).
#		# TODO proper SQL escaping on ALL the things D:
#
#		tempSqlFile='/tmp/mysql-first-time.sql'
#		cat > "$tempSqlFile" <<-EOSQL
#			DELETE FROM mysql.user ;
#			CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
#			GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
#			DROP DATABASE IF EXISTS test ;
#		EOSQL
#
#		if [ "$MYSQL_DATABASE" ]; then
#			echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" >> "$tempSqlFile"
#			if [ "$MYSQL_CHARSET" ]; then
#				echo "ALTER DATABASE \`$MYSQL_DATABASE\` CHARACTER SET \`$MYSQL_CHARSET\` ;" >> "$tempSqlFile"
#			fi
#
#			if [ "$MYSQL_COLLATION" ]; then
#				echo "ALTER DATABASE \`$MYSQL_DATABASE\` COLLATE \`$MYSQL_COLLATION\` ;" >> "$tempSqlFile"
#			fi
#		fi
#
#		if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
#			echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> "$tempSqlFile"
#
#			if [ "$MYSQL_DATABASE" ]; then
#				echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" >> "$tempSqlFile"
#			fi
#		fi
#
#		echo 'FLUSH PRIVILEGES ;' >> "$tempSqlFile"
#		cat dbreport_nodata.sql >> "$tempSqlFile"
#
#		set -- "$@" --init-file="$tempSqlFile"
#	fi
#
#fi
#
#exec "$@"