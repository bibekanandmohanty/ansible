#!/bin/bash
#
username="test"
pass="test"
fname="$*"
useradd -d /home/$username -m "$username" -s /bin/bash
echo "$username:$pass" | chpasswd
usermod -aG admin $username
echo "$username    ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
service sshd restart
hostnamectl set-hostname client
