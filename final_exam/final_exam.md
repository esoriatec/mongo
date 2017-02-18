## Question 4

cfg = rs.conf();
cfg.members[2].priority = 0;
rs.reconfig(cfg);

## Question 5

{ _id : 1, author : 'joe', title : 'Too big to fail', text : 'test', tags : ['business','finance' ], when : ISODate("2008-11-03"), views : 23002, votes : 4, voters:['joe', 'jane', 'bob', 'somesh'],comments : [{ commenter : 'allan',comment :'Well,i dont think so',flagged : false,plus : 2}]}


## Question 8
mkdir data/shard
mongod --fork --logpath shrd1.log --smallfiles --oplogSize 50 --port 27019 --dbpath data/shard
mongod --configsvr --port 27019 --dbpath /home/vagrant/cfg0 --logpath /home/vagrant/log.cfg0 --logappend --oplogSize 50 --smallfiles --fork

mongorestore --port 27019 config_server

## Question 9
mkdir s1 s2
mongod --shardsvr --port 27501 --dbpath /home/vagrant/s1 --logpath /home/vagrant/log.s1 --logappend --oplogSize 50 --smallfiles --fork
mongod --shardsvr --port 27601 --dbpath /home/vagrant/s2 --logpath /home/vagrant/log.s2 --logappend --oplogSize 50 --smallfiles --fork

mongorestore --port 27501 s1
mongorestore --port 27601 s2

sudo service mongod stop (stopper le service mongod démarré automatiquement avec le démarrage de la machine)
mongos --configdb mongo.bd:27019 --logappend 