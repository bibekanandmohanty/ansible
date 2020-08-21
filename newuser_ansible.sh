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
hostnamectl set-hostname client
yum -y install java-1.8.0-openjdk-devel
mkdir /home/test/.ssh
echo -e "-----BEGIN RSA PRIVATE KEY----- \nMIIEowIBAAKCAQEAz9sB1dPASCdTpYiPC2S33+Q53AWzSgEOkd19L3/k2ZSmpvbG \nEnBWs1Wh0ByCSnX82qvb+GcKWsGPjYTaukwZgFgNWCbgLSKRV+oFSdmIKuS6JM91 \nd+9Y3pGWEY+cc78iUYWHha/tfM5nRyxAJZ5i/BsBhd8aB677U3S23wieiCJc1h2X \n3z/7anUdUbzcTDMe2aUHIxYtGHnfwAaLB38pgYpeK65pQqxfsQbFY9LcFFUdI4c6 \nzGOOm1Nc2O1O1i2WNe5d8+YvbGxSKmsc0ZYfTe+EgyRdzHdUZMwFFEQPIeRBnZnn \n3ylMfxBDvpmCCHpycIp/egu8V/407jBH05cMfwIDAQABAoIBAQCt9SwvCh52BLvj \n4UtejLe7IOYvt3Ga8RGBkK5Rz6b3Voq3V/bjvbNCOdvIMeP1b5Pka0sZNRucYzzC \ngzsQCdqZ6JeafEbIX5Lm0gwFB5MH2w/S+PHmI6Hr/EptfhTBZmjRc4C9qUSIXLJh \nBa7WDR3owq1enh7J6W+cJCVcunj7kstnBLHB5T5o6NoLE7uLNT7OqhH3HMF6ZxT4 \nwwm5LTzvb7Vm6YmokayvkM1v8wER4uoq+2nd0DeKT16UY8Qs9ghjmAjrPeoaFy4S \ndYgD3YNEJ4NgUvQrGEfYUNzyNiqgIIP2jdAhm8ii8OvabyL+Pnxy8PpBP9jYorSB \nAFPFPG+5AoGBAPnko6JzENklmVHZBOY7oYfalFLkHDVRTq5hrzfJ4KlmMhxp0kGN \nwQNw9nEVLzR9yhy9tES86jbUp8uFPp+t9LDxttGcTEYGcbPl7+KdWphJX0yo4N1+ \npb5jha9neemLKO17LjM7MJ6sNJCL4IHH05eb4eCyqP113436xXyb+VuNAoGBANTv \nYCnJoRrM7MUs9YVQyuVF5v+P9NhUHtAx4AjWWp9bNu2Rt2k2bX6WPop0Ukw9L7so \nb62E7+IAiovv7N6VW683LKXEx+b7CzW+YXFRq/kLACvxN1mJYtgDPbZ8J7zLvjLb \nGY/DAUxoZwftfxYeCoOBz6ENAOrWlYioCRHYhH87AoGALEyt/YRsfjI+JdZVGgOE \nNTM4jCFIJuONETjb+QXev+kQBR11Wo2oo9WIuq9IuQN7qvCuXmknFCVKwbeTTHdo \nI14WTL5qfxdxXLTse73ta4XGUS62/k0PUNsPvfKYGCDFVqQ5ondhvR9GCkHhwOAN \n0JifyFejwZr90IueKuLzp5kCgYBirlz+gLbs2LOR3XgbRIoDHxYisfBioPl2uuZ8 \nsfplh7w49SLu2456794kBCxvsJuCPQckf0s8jcundpVrwgQve35xhHSwEv/q9EPs \nZFEypWp68tsX35ezTC05eOhhknqezvNVsKXVZzz4a5ROB7YPpAU5OfGG49OA9X7e \nil09KQKBgAQof3lO1gkoxOHKdSw4EzdpX/eVE5d6n64B2sbbwt7TU3jugw1q/OTW \noFKztHYv/10mVVUZOViFud6x+8L1v6v9ebpknGl7/pbZ51E3zsKRY97u8CcrKXma \nratj1nMzzjL4NSrn3skHCFC+j3QfuHs4zT4L/wXD6HS72RgBSkn5 \n-----END RSA PRIVATE KEY-----" >> /home/test/.ssh/id_rsa
touch /home/test/.ssh/id_rsa.pub
echo -e "ssh-rsa AAAAB3NzaC1yc2EiAAAADAQABAAABAQDP2wHV08BIJ1OliI8LZLff5DncBbNKAQ6R3X0vf+TZlKam9sYScFazVaHQHIJKdfzaq9v4ZwpawY+NhNq6TBmAWA1YJuAtIpFX6gVJ2Ygq5Lokz3V371jekZYRj5xzvyJRhYeFr+18zmdHLEAlnmL8GwGF3xoHrvtTdLbfCJ6IIlzWHZffP/tqdR1RvNxMMx7ZpQcjFi0Yed/ABosHfymBil4rrmlCrF+xBsVj0twUVR0jhzrMY46bU1zY7U7WLZY17l3z5i9sbFIqaxzRlh9N74SDJF3Md1RkzAUURA8h5EGdmeffKUx/EEO+mYIIenJwin96C7xX/jTuMEfTlwx/ root@ip-172-31-37-203.ap-south-1.compute.internal" >> /home/test/.ssh/id_rsa.pub
chmod 400 /home/test/.ssh/id_rsa
echo "Host *" >> /home/test/.ssh/config
echo "   StrictHostKeyChecking no" >> /home/test/.ssh/config
echo "Host *" >> /home/test/.ssh/config
echo "   StrictHostKeyChecking no" >> /home/test/.ssh/config
chown -R test:test /home/test/.ssh/
chmod 400 /home/test/.ssh/config
