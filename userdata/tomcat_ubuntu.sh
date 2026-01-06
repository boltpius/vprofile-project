#!/bin/bash

# Update and upgrade
sudo apt update && sudo apt upgrade -y

# Install Java 11
sudo apt install openjdk-11-jdk -y

# Install Tomcat 10
sudo apt install tomcat10 tomcat10-admin -y

# Start and Enable Tomcat
sudo systemctl start tomcat10
sudo systemctl enable tomcat10

# Verify Status
sudo systemctl status tomcat10 --no-pager
