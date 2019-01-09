#!/usr/bin/env bash

set -xe

docker exec -ti masterdb 'mysql' -uroot -prootroot -e"show master status\G" -vvv
docker exec -ti slave1 'mysql' -uroot -prootroot -e"show slave status\G" -vvv
docker exec -ti slave2 'mysql' -uroot -prootroot -e"show slave status\G" -vvv
