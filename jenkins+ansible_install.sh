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
echo "Host *" >> /var/lib/jenkins/.ssh/config
echo "   StrictHostKeyChecking no" >> /var/lib/jenkins/.ssh/config
chown -R jenkins:jenkins /var/lib/jenkins/.ssh
chmod 400 /var/lib/jenkins/.ssh/config
service sshd restart
scl enable rh-python36 bash
