source common.sh



yum install nginx -y
status_check
systemctl enable nginx
status_check
systemctl start nginx
status_check
rm -rf /usr/share/nginx/html/*
status_check
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
status_check
cd /usr/share/nginx/html
status_check
unzip /tmp/frontend.zip
status_check
cp ${dir}/roboshop.conf /etc/nginx/default.d/roboshop.conf
status_check
systemctl restart nginx
status_check