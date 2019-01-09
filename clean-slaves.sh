#!/usr/bin/env bash

set -xe

docker container rm -f slave1
docker container rm -f slave2
sudo rm -rf slave1/data/*
sudo rm -rf slave2/data/*
