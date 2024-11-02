#! /bin/bash

mkdir -p /var/run/conveyor
touch /var/run/conveyor/conveyord.socket

chown -R conveyor:conveyor /var/run/conveyor
service conveyor restart
