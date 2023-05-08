source common.sh

yum install mongodb-org -y
systemctl enable mongod
cp ${dir}/mongo.repo /etc/yum.repos.d/mongo.repo
systemctl start mongod
systemctl restart mongod