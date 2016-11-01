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

## Installation d'outils complémentaires
#sudo yum groupinstall -q -y "Outils de développement"
#sudo yum install -q -y wget

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
sudo service mongod start
sudo chkconfig mongod on


## Installation de java
#sudo yum install -q -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
#sed -i '$ a export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.102-1.b14.el7_2.x86_64' /home/vagrant/.bashrc
#sed -i '$ a export PATH=$JAVA_HOME/jre/bin:$PATH' /home/vagrant/.bashrc
#export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.102-1.b14.el7_2.x86_64
#export PATH=$JAVA_HOME/jre/bin:$PATH


## Installation de Maven
#wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
#sudo mkdir /usr/lib/maven
#sudo mv apache-maven-3.3.9-bin.tar.gz /usr/lib/maven
#sudo tar xzvf /usr/lib/maven/apache-maven-3.3.9-bin.tar.gz --directory /usr/lib/maven/
#sed -i '$ a export PATH=/usr/lib/maven/apache-maven-3.3.9/bin:$PATH' /home/vagrant/.bashrc
#sed -i '$ a export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=512m"' /home/vagrant/.bashrc
#export PATH=/usr/lib/maven/apache-maven-3.3.9/bin:$PATH
#export MAVEN_OPTS="-Xmx2g -XX:ReservedCodeCacheSize=512m"


#sed -i 's|"spark.executor.memory": "",|"spark.executor.memory": "2G",|g' /home/vagrant/zeppelin/conf/interpreter.json
#sed -i 's|"master": "local\[\*\]",|"master": "spark://spark.bd:7077",|g' /home/vagrant/zeppelin/conf/interpreter.json

# Préparation de la box spark
# copie de la clé vagrant (insecure) sur site vagrant dans .ssh
# ssh-copy-id -i ~/.ssh/vagrant.pub vagrant@127.0.0.1 - p 2222
# suppression de l'ancienne clé sur machine distante
# copie de la cle privé vagrant (insecure) dans /Users/swal4u/vagrant_spark/.vagrant/machines/default/virtualbox/
# test connexion avec vagrant ssh
# préparation de la box avec la commande vagrant package


