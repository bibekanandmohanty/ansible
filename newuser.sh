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
yum install tomcat -y
echo "JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Xmx512m -XX:MaxPermSize=256m -XX:+UseConcMarkSweepGC"" >> /usr/share/tomcat/conf/tomcat.conf
yum install tomcat-webapps tomcat-admin-webapps -y
echo -e "<tomcat-users> \n<role rolename="admin"/> \n<role rolename="admin-gui"/> \n<role rolename="admin-script"/> \n<role rolename="manager"/> \n<role rolename="manager-gui"/> \n<role rolename="manager-script"/> \n<role rolename="manager-jmx"/> \n<role rolename="manager-status"/> \n<user name="bibek" password="bibek" roles="admin,manager,admin-gui,admin-script,manager-gui,manager-script,manager-jmx,manager-status" /> \n</tomcat-users>" >> /etc/tomcat/tomcat-users.xml
systemctl restart tomcat

