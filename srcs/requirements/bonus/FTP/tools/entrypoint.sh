#!/bin/sh

set -e

echo "Starting entrypoint script..."

if [ ! -f /etc/vsftpd.conf ]; then
	echo "Error: vsftpd.conf not found!"
	exit 1
fi

if [ -z "$FTPPW" ] || [ -z "$USER" ]; then
	echo "Error: FTPPW or USER variable is not set in the .env file"
	exit 1
fi

echo "Checking if user $USER exists..."
if ! id "$USER" &>/dev/null; then
	echo "Creating user $USER..."
	adduser --disabled-password --gecos "" $USER
else
	echo "User $USER already exists."
fi

echo "Setting password for $USER..."
echo "$USER:$FTPPW" | chpasswd

echo "Ensuring secure chroot directory exists..."
mkdir -p /var/run/vsftpd/empty

echo "Creating userlist..."
echo "$USER" > /etc/vsftpd.userlist
chmod 644 /etc/vsftpd.userlist

echo "Starting vsftpd..."
exec /usr/sbin/vsftpd /etc/vsftpd.conf