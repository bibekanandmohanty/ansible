ansible all -m ping
ansible all -m shell -a "free -m"
ansible all -m shell -a "cat /proc/meminfo|head -2"
ansible all -m file -a "path=/home/test/xyz.txt state=directory mode=0755"# creating a directory
#name: Change file ownership, group and permissions
ansible all -m file -a "path=/home/test/test.conf owner=test group=test mode=0644 state=touch"
#name: Give insecure permissions to an existing file
ansible all -m file -a "path=/home/test/test.conf owner=root group=test mode=1777" -b
#name: Create a symbolic link
ansible all -m file -a "src=/home/test/test.conf dest=/home/test/test.conf1 owner=root group=test state=link" -b
#name: Touch again the same file, but dont change times this makes the task idempotent
ansible all -m file -a "path=/home/test/test.conf state=touch mode=0640 modification_time=preserve access_time=preserve" -b
#- name: Create a directory if it does not exist
ansible all -m file -a "path=/etc/test state=directory mode=0755" -b
#name: Update modification and access time of given file
ansible all -m file -a "path=/home/test/test.conf state=file modification_time=now access_time=now" -b
#name: Recursively change ownership of a directory
ansible all -m file -a "path=/tmp/bibek state=directory recurse=yes owner=test group=test" -b
#name: Remove file (delete file)
ansible all -m file -a "path=/tmp/bibek/file10 state=absent"
#name: Remove directory recursively
ansible all -m file -a "path=/tmp/bibek state=absent"
##############################User Module##########################################################################
#name: Add the user 'johnd' with a specific uid and a primary group of 'admin'
ansible all -m user -a "name=john comment=John uid=1040 group test"
#name: Add the user 'johnd' with a bash shell, appending the group 'admins' and 'developers' to the user's groups 
ansible all -m user -a "name=john shell=/bin/bash groups=admins,developers append=yes"
#name: Remove the user 'johnd'
ansible all -m user -a "name=johnd state=absent remove=yes"
#name: Create a 2048-bit SSH key for user jsmith in ~jsmith/.ssh/id_rsa
ansible all -m user -a "name=jsmith generate_ssh_key=yes ssh_key_bits=2048 ssh_key_file=.ssh/id_rsa"
#############################Group Module##########################################################################
#Create a unix user group with ansible ad hoc command
ansible all -s -m group -a "name=weblogic state=present" 
#################################YUM Module#######################################################################
#name: install the latest version of Apache
ansible all -m yum -a "name=httpd state=latest"
#name: remove the Apache package
ansible all -m yum -a "name=httpd state=absent"
#name: install the latest version of Apache from the testing repo
ansible all -m yum -a "name=httpd enablerepo=testing state=present"
#name: install one specific version of Apache
ansible all -m yum -a "name=httpd-2.2.29-1.4.amzn1 state=present"
#name: upgrade all packages
ansible all -m yum -a "name='*' state=latest"
#name: upgrade all packages, excluding kernel & foo related packages
ansible all -m yum -a "name='*' state=latest exclude=kernel*,foo*"
#name: install the nginx rpm from a remote repo
ansible all -m yum -a "name=/usr/local/src/nginx-release-centos-6-0.el6.ngx.noarch.rpm state=present"


