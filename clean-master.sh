#!/usr/bin/env bash

set -xe

docker container rm -f masterdb
sudo rm -rf masterdb/data/*
