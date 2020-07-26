ansible all -m ping
ansible all -m shell -a "free -m"
ansible all -m shell -a "cat /proc/meminfo|head -2"
###########################file module#############################################################################
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
################################Service module######################################################
#name: Start service httpd, if not started
ansible all -m service -a "name=httpd state=started"
#name: Stop service httpd, if started
ansible all -m service -a "name=httpd state=stopped"
#name: Restart service httpd, in all cases
ansible all -m service -a "name=httpd state=restarted"
#name: Reload service httpd, in all cases
ansible all -m service -a "name=httpd state=reloaded"
#name: Enable service httpd, and not touch the state
ansible all -m service -a "name=httpd state=enabled"
#name: Start service foo, based on running process /usr/bin/foo
ansible all -m service -a "name=foo pattern=/usr/bin/foo state=started"
#name: Restart network service for interface eth0
ansible all -m service -a "name"
#############################fetch module#############################################################
#name: Store file into /tmp/fetched/host.example.com/tmp/somefile
ansible all -m fetch -a "src=/tmp/somefile dest=/tmp/fetched"
#name: Specifying a path directly
ansible all -m fetch -a "src=/tmp/somefile dest=/tmp/prefix-{{ inventory_hostname }} flat=yes"
#name: Specifying a destination path
ansible all -m fetch -a "src=/tmp/uniquefile dest=/tmp/special flat=yes"
#name: Storing in a path relative to the playbook
ansible all -m fetch -a "src=/tmp/uniquefile dest=special/prefix-{{ inventory_hostname }} flat=yes"
############################copy module############################################################
#name: Copy file with owner and permissions
ansible all -m copy -a "src=/srv/myfiles/foo.conf dest=/etc/foo.conf owner=foo group=foo mode=0644"
#name: Copy a new "ntp.conf file into place, backing up the original if it differs from the copied version
ansible all -m copy -a "src=/srv/myfiles/foo.conf dest=/etc/foo.conf owner=foo group=foo mode=0644 backup=yes"
#name: Copy using inline content
ansible all -m copy -a "content='# This file was moved to /etc/other.conf' dest=/etc/mine.conf" 
################################lineinfile##############################################################
#name: "Example1: Validate if a String or line is present in the file"
ansible all -m lineinfile -a "path=/tmp/sample.txt line='an unforseen error has occured and processing has been stopped.' state=present"
#name: "Replacing a line"
ansible all -m lineinfile -a "path=/tmp/sample.txt regexp='an unforseen error has occured and processing has been stopped.' line='an unforseen error has occured and processed had been stopped.' state=present backup=yes"
#name: Remove a line from a file if it is found all instances
ansible all -m lineinfile -a "path=/tmp/sample.txt regexp='an unforseen error has occured and processed had been stopped.' state=absent backup=yes"
#name: Insert a string after finding the first match
ansible all -m lineinfile -a "path=/tmp/sample.txt insertafter='Refresh button' line='hello this is bibekanand' "
#name: Insert a line before a line
ansible all -m lineinfile -a "path=/tmp/sample.txt insertbefore='an unforseen error*' line='hello this is bibekanand' state=present"
##################################package module############################################################
#name: install ntpdate
ansible all -m package -a "name=ntpdate state=present"
#name: remove the apache package
ansible all -m package -a "name=apache state=absent"


