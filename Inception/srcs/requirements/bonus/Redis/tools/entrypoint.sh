#!/bin/sh

set -e

echo "protected-mode no" >> /usr/local/etc/redis/redis.conf

exec redis-server /usr/local/etc/redis/redis.conf
