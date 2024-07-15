#!/bin/sh

. /root/.env

if [ -z "$FTPPW" ]; then
  echo "FTPPW variable is not set in the .env file"
  exit 1
fi

if [ -z "$USER" ]; then
  echo "USER variable is not set in the .env file"
  exit 1
fi

adduser --disabled-password --gecos "" $USER
echo "$USER:$FTPPW" | chpasswd

mkdir -p /home/$USER/ftp && \
chown -R $USER:$USER /home/$USER/ftp && \
chmod 755 /home/$USER/ftp

echo "Starting vsftpd..."
/usr/sbin/vsftpd /etc/vsftpd.conf
