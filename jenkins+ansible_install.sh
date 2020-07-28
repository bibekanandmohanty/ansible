#!/bin/bash
#
username="test"
pass="test"
shift 2
fname="$*"
for each in vim wget httpd git java-1.8.0-openjdk-devel centos-release-scl rh-python36 scl-utils epel-release ; do yum install -y $each ; done
yum update -y
yum -y install ansible
adduser "$username"
echo "$username:$pass" | chpasswd
usermod -aG wheel $username
echo "$username    ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
mkdir /root/.ssh
touch /root/.ssh/id_rsa
touch /root/.ssh/id_rsa.pub
chmod 400 /root/.ssh/id_rsa
echo "Host *" >> /root/.ssh/config
echo "   StrictHostKeyChecking no" >> /root/.ssh/config
mkdir /home/test/.ssh
echo "Host *" >> /home/test/.ssh/config
echo "   StrictHostKeyChecking no" >> /home/test/.ssh/config
chown -R test:test /home/test/.ssh/
chmod 400 /home/test/.ssh/config
service sshd restart
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum install jenkins -y
systemctl start jenkins
chkconfig jenkins on
echo "jenkins    ALL=(ALL)       NOPASSWD:ALL" >> /etc/sudoers
mkdir /var/lib/jenkins/.ssh/
touch /var/lib/jenkins/.ssh/id_rsa
touch /var/lib/jenkins/.ssh/id_rsa.pub
echo "Host *" >> /var/lib/jenkins/.ssh/config
echo "   StrictHostKeyChecking no" >> /var/lib/jenkins/.ssh/config
chown -R jenkins:jenkins /var/lib/jenkins/.ssh
chmod 400 /var/lib/jenkins/.ssh/config
service sshd restart
scl enable rh-python36 bash

