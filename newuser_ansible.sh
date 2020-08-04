#!/bin/bash
#
username="test"
pass="test"
shift 2
fname="$*"
adduser "$username"
echo "$username:$pass" | chpasswd
usermod -aG wheel $username
echo "$username    ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart
yum update -y
for each in vim wget httpd git java-1.8.0-openjdk-devel centos-release-scl rh-python36 scl-utils epel-release ; do yum install -y $each ; done
hostnamectl set-hostname client
