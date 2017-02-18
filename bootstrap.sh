#!/usr/bin/env bash

## Désactivation de SELINUX
sudo sed -i 's/SELINUX=permissive/SELINUX=disabled/g' /etc/selinux/config
sudo setenforce 0
## Désactivation du swap
sudo sed -i '$ a vm.swappiness=0' /etc/sysctl.conf

## Réglage de l'heure
sudo yum install -q -y ntp ntpdate ntp-doc
sudo chkconfig ntpd on
sudo ntpdate 0.fr.pool.ntp.org
sudo service ntpd start
sudo timedatectl set-timezone Europe/Paris

## Désactivation du firewall
sudo systemctl disable firewalld
sudo systemctl stop firewalld


## Réglage de certains paramètres système pour mongo
sudo cp /vagrant/disable-transparent-hugepages /etc/init.d/
sudo chmod 755 /etc/init.d/disable-transparent-hugepages
sudo service disable-transparent-hugepages start
sudo chkconfig --add disable-transparent-hugepages
sudo mkdir /etc/tuned/no-thp
sudo cp /vagrant/tuned.conf /etc/tuned/no-thp/
sudo tuned-adm profile no-thp
sudo sed -i 's|4096|32000|' /etc/security/limits.d/20-nproc.conf

## Installation de mongoDB
sudo cp /vagrant/mongodb-org-3.2.repo /etc/yum.repos.d/
sudo yum makecache
sudo yum install -y mongodb-org
## Permettre à des machines distantes d'accéder à la machine mongo
sudo sed -i 's/bindIp: 127.0.0.1/#bindIp: 127.0.0.1/g' /etc/mongod.conf
sudo service mongod start
sudo chkconfig mongod on





