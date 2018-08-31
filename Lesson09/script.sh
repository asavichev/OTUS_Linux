#!/bin/bash
LOG=/tmp/create_repos.txt
echo "set= `set`" >> ${LOG}

sed -i.gres "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i.gres "s/PasswordAuthentication no/#PasswordAuthentication no/g" /etc/ssh/sshd_config

# echo "proxy=https://cache.fors.ru:3128" >> /etc/yum.conf

systemctl restart sshd
echo -e "1q2w3e4r\n1q2w3e4r\n" | passwd

yum -y install epel-release

yum -y install mc ansible

ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
cd ~/.ssh
cat ./id_rsa.pub >> authorized_keys

systemctl stop firewalld
systemctl disable firewalld
cd /vagrant
cp ansible.tar /etc/ansible
cd /etc/ansible
tar -xf ./ansible.tar

ssh -o "StrictHostKeyChecking no" localhost date

ansible-playbook nginx.yml
ip address

exit 0;

