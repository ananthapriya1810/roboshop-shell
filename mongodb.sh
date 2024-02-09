#!/bin/bash
ID=$(id -u)

TIMESTAMP=(DATE +%F-%H-%M-%S)
logfile="/tmp/$0-$TIMESTAMP.LOG"

VALIDATE(){
    if [ $1 -ne 0 ]
    then
    echo "print $2 ...FAILED"
    else 
    echo "print $2 ....SUCCESS"
    fi
}

if [ $ID -ne 0 ]

then

echo "ERROR : you are not root user"
else
echo "you are root user"
fi
cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "COPIED MONGO DB"
dnf install mongodb-org -y 
VALIDATE $? "installing mongodb"
systemctl enable mongod
VALIDATE $? "enable mongodb"
 systemctl start mongod
 VALIDATE "mongo db started"
 sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Remote access to MONGODB"
systemctl restart mongod
VALIDATE $? "restart mongodb"

