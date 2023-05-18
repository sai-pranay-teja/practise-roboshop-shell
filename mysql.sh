source common.sh

dnf module disable mysql -y 
status_check
cp ${dir}/mysql.repo /etc/yum.repos.d/mysql.repo
status_check
yum install mysql-community-server -y
status_check
systemctl enable mysqld
status_check
mysql_secure_installation --set-root-pass RoboShop@1
status_check
systemctl restart mysqld
status_check