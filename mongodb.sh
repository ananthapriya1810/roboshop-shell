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
