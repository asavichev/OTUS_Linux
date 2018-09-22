#!/bin/bash
LOG=/tmp/create_repos.txt
echo "set= `set`" >> ${LOG}

sed -i.gres "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i.gres "s/PasswordAuthentication no/#PasswordAuthentication no/g" /etc/ssh/sshd_config

# echo "proxy=https://cache.fors.ru:3128" >> /etc/yum.conf

systemctl restart sshd
echo -e "1q2w3e4r\n1q2w3e4r\n" | passwd

yum -y install epel-release

yum -y install mc pam_script

ssh-keygen -t rsa -P "" -f /root/.ssh/id_rsa
cd ~/.ssh
cat ./id_rsa.pub >> authorized_keys

systemctl stop firewalld
systemctl disable firewalld

ssh -o "StrictHostKeyChecking no" localhost date

cd /vagrant
cp ./log_acct /etc/pam-script.d
sed -i.gres "s/account    required     pam_nologin.so/&\naccount    required     pam_script.so/" /etc/pam.d/sshd

groupadd admin
useradd -g admin -G root,vagrant test
echo -e "test\ntest\n" | passwd test

cat <<EOF >> /etc/security/capability.conf
cap_sys_admin  test
EOF

sed -i.gres "s/auth       substack     password-auth/&\nauth       optional     pam_cap.so/" /etc/pam.d/sshd

ip address

exit 0;

