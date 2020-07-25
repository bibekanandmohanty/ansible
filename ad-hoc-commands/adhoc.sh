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

