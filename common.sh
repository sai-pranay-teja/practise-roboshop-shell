dir=$(pwd)/conf-files

status_check(){
    if [ $? -eq 0 ]; then
       echo SUCCESS
    else
       echo FAILURE
       exit 1
    fi
    
}

basic_setup(){
    id roboshop
    if [ $? -eq 0 ]; then
      echo The user "roboshop" exists
    else
      useradd roboshop
    fi

    mkdir /app

    status_check

    rm -rf /app/*

    status_check

    curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip 

    status_check

    cd /app 

    status_check

    unzip /tmp/${component}.zip

    status_check
    

}
systemd(){
    cp ${dir}/${component}.service /etc/systemd/system/${component}.service

    status_check

    systemctl daemon-reload

    status_check

    systemctl enable ${component}

    status_check

    systemctl restart ${component}

    status_check

}

schema_setup(){
    if [ ${db_type} == "mongo" ]; then
      cp ${dir}/mongo.repo /etc/yum.repos.d/mongo.repo

      status_check

      yum install mongodb-org-shell -y

      status_check

      mongo --host mongodb.practise-devops.online </app/schema/${component}.js

      status_check
      
    elif [ ${db_type} == "mysql" ]; then
      yum install mysql -y

      status_check

      mysql -h mysql.practise-devops.online -uroot -pRoboShop@1 < /app/schema/${component}.sql 

      status_check
    fi
            

}




nodejs(){
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash
    
    status_check

    yum install nodejs -y

    status_check

    basic_setup

    npm install

    status_check

    systemd
}

java(){
    yum install maven -y

    status_check

    basic_setup

    mvn clean package 

    status_check

    mv target/${component}-1.0.jar ${component}.jar 

    status_check

    schema_setup

    systemd

}


python(){
    yum install python36 gcc python3-devel -y

    status_check

    basic_setup

    pip3.6 install -r requirements.txt

    systemd



}