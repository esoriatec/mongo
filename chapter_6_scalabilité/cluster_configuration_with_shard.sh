# mongo cluster configuration

## 2 shards (a,b) with 3 replicas (0,1,2)
## 2 serveurs de configuration

## Création des répertoires
mkdir a0
mkdir a1
mkdir a2
mkdir b0
mkdir b1
mkdir b2
mkdir cfg0
mkdir cfg1

## Config servers
mongod --configsvr --port 26050 --dbpath /home/vagrant/cfg0 --logpath /home/vagrant/log.cfg0 --logappend --oplogSize 50 --smallfiles --fork
mongod --configsvr --port 26051 --dbpath /home/vagrant/cfg1 --logpath /home/vagrant/log.cfg1 --logappend --oplogSize 50 --smallfiles --fork

## Shard servers
mongod --shardsvr --port 27000 --replSet a --dbpath /home/vagrant/a0 --logpath /home/vagrant/log.a0 --logappend --oplogSize 50 --smallfiles --fork
mongod --shardsvr --port 27001 --replSet a --dbpath /home/vagrant/a1 --logpath /home/vagrant/log.a1 --logappend --oplogSize 50 --smallfiles --fork
mongod --shardsvr --port 27002 --replSet a --dbpath /home/vagrant/a2 --logpath /home/vagrant/log.a2 --logappend --oplogSize 50 --smallfiles --fork
mongod --shardsvr --port 27100 --replSet b --dbpath /home/vagrant/b0 --logpath /home/vagrant/log.b0 --logappend --oplogSize 50 --smallfiles --fork
mongod --shardsvr --port 27101 --replSet b --dbpath /home/vagrant/b1 --logpath /home/vagrant/log.b1 --logappend --oplogSize 50 --smallfiles --fork
mongod --shardsvr --port 27102 --replSet b --dbpath /home/vagrant/b2 --logpath /home/vagrant/log.b2 --logappend --oplogSize 50 --smallfiles --fork

## Mongos servers
mongos --configdb mongo.bd:26050,mongo.bd:26051 --logappend --oplogSize 50 --smallfiles --fork
mongos --configdb mongo.bd:26050,mongo.bd:26051 --logappend --oplogSize 50 --smallfiles --fork