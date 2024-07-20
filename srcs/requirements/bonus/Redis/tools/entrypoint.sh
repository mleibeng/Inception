#!/bin/sh

set -e

echo "protected-mode no" >> /etc/redis/redis.conf

exec redis-server /etc/redis/redis.conf
