source common.sh

yum install mongodb-org -y
cp ${dir}/mongo.repo /etc/yum.repos.d/mongo.repo
systemctl enable mongod
sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
systemctl start mongod
systemctl restart mongod