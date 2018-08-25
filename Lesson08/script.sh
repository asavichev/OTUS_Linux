#!/bin/bash
LOG=/tmp/create_repos.txt
echo "set= `set`" >> ${LOG}

sed -i.gres "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
sed -i.gres "s/PasswordAuthentication no/#PasswordAuthentication no/g" /etc/ssh/sshd_config

# echo "proxy=https://cache.fors.ru:3128" >> /etc/yum.conf

systemctl restart sshd
echo -e "1q2w3e4r\n1q2w3e4r\n" | passwd

yum -y install epel-release

yum -y install mc prm-build rpmdevtools wget maven chromium chromedriver createrepo

cd /vagrant
cp rpmbuild.tar /root/
cd /root
tar -xf ./rpmbuild.tar >> ${LOG}

cd rpmbuild/SPECS
rpmbuild -bb selenium.spec >> ${LOG}

mkdir /repos
mkdir /repos/myrepo
cd /root/rpmbuild/RPMS/x86_64
cp ./sel_parser-1.0-1.x86_64.rpm /repos/myrepo
createrepo /repos/myrepo

cat <<EOF > /etc/yum.repos.d/myrepo.repo
[mylocal]
name=My-Local
baseurl=file:///repos/myrepo
enabled=1
EOF

yum install sel_parser >> ${LOG}



