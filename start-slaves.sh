#!/usr/bin/env bash

set -xe

docker run --name slave1 -d -v $REPO/mysql_master-slave/slave1/cnf:/etc/mysql/conf.d -v $REPO/mysql_master-slave/slave1/data:/var/lib/mysql --link masterdb:mysql -e MYSQL_ROOT_PASSWORD=rootroot -p 3308:3306 -d mysql:5.6
docker run --name slave2 -d -v $REPO/mysql_master-slave/slave2/cnf:/etc/mysql/conf.d -v $REPO/mysql_master-slave/slave2/data:/var/lib/mysql --link masterdb:mysql -e MYSQL_ROOT_PASSWORD=rootroot -p 3309:3306 -d mysql:5.6

sleep 30s

docker exec -ti slave1 'mysql' -uroot -prootroot -e'change master to master_host="mysql",master_user="repl",master_password="slavepass",master_log_file="mysqld-bin.000004",master_log_pos=318;' -vvv
docker exec -ti slave2 'mysql' -uroot -prootroot -e'change master to master_host="mysql",master_user="repl",master_password="slavepass",master_log_file="mysqld-bin.000004",master_log_pos=318;' -vvv

docker exec -ti slave1 'mysql' -uroot -prootroot -e"START SLAVE;" -vvv
docker exec -ti slave2 'mysql' -uroot -prootroot -e"START SLAVE;" -vvv
