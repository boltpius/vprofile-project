#!/bin/bash

# 1. Update the OS first to ensure all base packages and SSL certs are current
sudo dnf update -y

# 2. Create the repository file for Erlang
sudo tee /etc/yum.repos.d/rabbitmq_erlang.repo <<EOF
[rabbitmq_erlang]
name=rabbitmq_erlang
baseurl=https://packagecloud.io/rabbitmq/erlang/el/9/\$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/rabbitmq/erlang/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF

# 3. Create the repository file for RabbitMQ
sudo tee /etc/yum.repos.d/rabbitmq_server.repo <<EOF
[rabbitmq_server]
name=rabbitmq_server
baseurl=https://packagecloud.io/rabbitmq/rabbitmq-server/el/9/\$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF

# 4. Clean cache and refresh metadata for the new repos
sudo dnf clean all
sudo dnf makecache

# 5. Install Erlang and RabbitMQ
sudo dnf install -y erlang rabbitmq-server

# 6. Start and Enable
sudo systemctl enable rabbitmq-server
sudo systemctl start rabbitmq-server

# 7. Configure user and permissions
# Giving the service a 10-second head start to initialize
sleep 10
sudo rabbitmqctl add_user test test || echo "User already exists"
sudo rabbitmqctl set_user_tags test administrator
sudo rabbitmqctl set_permissions -p / test ".*" ".*" ".*"

# 8. Enable Management UI
sudo rabbitmq-plugins enable rabbitmq_management

# 9. Final Restart to apply all plugins and user settings
sudo systemctl restart rabbitmq-server

echo "RabbitMQ setup on Amazon Linux 2023 is complete."
