#!/bin/bash
LOG=/tmp/create_repos.txt
echo "set= `set`" >> ${LOG}

sed -i.gres "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i.gres "s/PasswordAuthentication no/#PasswordAuthentication no/g" /etc/ssh/sshd_config
sed -i.gres "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

echo "proxy=https://cache.fors.ru:3128" >> /etc/yum.conf

setenforce 0

systemctl restart sshd
systemctl stop firewalld
systemctl disabled firewalld
echo -e "1q2w3e4r\n1q2w3e4r\n" | passwd

yum -y install epel-release
yum -y install mc wget httpd spawn-fcgi

chmod +x /vagrant/show_log.sh

cd /vagrant/apache/etc
cp -pr ./* /etc/
cd /vagrant/service_scan
cp -pr ./* /etc/
cd /vagrant/spawn-fcgi/etc
cp -pr ./* /etc/

systemctl enable myscan.service
systemctl enable myscan.timer
systemctl start myscan.timer

systemctl start httpd@httpd1.service

# systemctl start spawn-fcgi.service






