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

    /etc/init.d/mysql stop

    cp -R -p /var/lib/mysql/ $MYSQL_WORKDIR
fi

echo -e "[mysqld]\ndatadir=${MYSQL_WORKDIR}/mysql\ntmpdir=${MYSQL_TMPDIR}" >> /etc/my.cnf
/etc/init.d/mysql start
