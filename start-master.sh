#!/usr/bin/env bash

set -xe

docker run --name masterdb -v $REPO/mysql_master-slave/masterdb/cnf:/etc/mysql/conf.d -v $REPO/mysql_master-slave/masterdb/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=rootroot -p 3307:3306 -d mysql:5.6

sleep 30s

docker exec -ti masterdb 'mysql' -uroot -prootroot -vvv -e"GRANT REPLICATION SLAVE ON *.* TO repl@'%' IDENTIFIED BY 'slavepass'"
docker exec -ti masterdb 'mysql' -uroot -prootroot -e"SHOW MASTER STATUS\G"
