#!/bin/bash
# Update and install MariaDB 10.5
sudo yum update -y
sudo yum install mariadb105-server -y

# Start and enable the service
sudo systemctl start mariadb
sudo systemctl enable mariadb

# Configure the database, user, and permissions
# Using 'vprofile_db_pass' as the standard project password
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS accounts;
GRANT ALL PRIVILEGES ON accounts.* TO 'admin'@'%' IDENTIFIED BY 'vprofile_db_pass';
FLUSH PRIVILEGES;
EOF

# Clone the project to get the SQL schema
sudo yum install git -y
git clone -b main https://github.com/hkhcoder/vprofile-project.git /tmp/vprofile

# Import the backup into the accounts database
mysql -u root accounts < /tmp/vprofile/src/main/resources/db_backup.sql


#starting the firewall and allowing the mariadb to access from port no. 3306
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --zone=public --add-port=3306/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl restart mariadb
