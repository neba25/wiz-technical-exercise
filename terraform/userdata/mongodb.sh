#!/bin/bash

apt-get update -y

apt-get install -y gnupg curl

curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
gpg --dearmor -o /usr/share/keyrings/mongodb-server-6.0.gpg

echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list

apt-get update -y

apt-get install -y mongodb-org

systemctl enable mongod

systemctl start mongod

sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

systemctl restart mongod