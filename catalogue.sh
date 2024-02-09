#!/bin/bash
ID=$(id -u)

TIMESTAMP=(DATE +%F-%H-%M-%S)
logfile="/tmp/$0-$TIMESTAMP.LOG"

MONGODB_HOST=mongodb.daws24s.online	

VALIDATE(){
    if [ $1 -ne 0 ]
    then
    echo "print $2 ...FAILED"
    else 
    echo "print $2 ...SUCCESS"
    fi
}

if [ $ID -ne 0 ]

then

echo "ERROR : you are not root user"
else
echo "you are root user"
fi
dnf module disable nodejs -y
VALIDATE $? "disabling current nodes"
dnf module enable nodejs:18 -y
VALIDATE $? "enable nodejs"
dnf install nodejs -y
VALIDATE $? "nodejs is installing"
useradd roboshop
VALIDATE $? "creatimg roboshop user"
mkdir /app
VALIDATE $? "creating app directory"
curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip
VALIDATE $? "unzipping the file"
cd /app
unzip /tmp/catalogue.zip
VALIDATE $? "UNZIPPING THE FILE"
cd /app
npm install 
VALIDATE $? "installing npm"
cp /home/centos/roboshop-shell /etc/systemd/system/catalogue.service
VALIDATE $?
systemctl daemon-reload
VALIDATE $?
systemctl enable catalogue
VALIDATE $?
systemctl start catalogue
VALIDATE $?
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org-shell -y
VALIDATE $?
mongo --host $MONGODB_HOST </app/schema/catalogue.js
VALIDATE $?
