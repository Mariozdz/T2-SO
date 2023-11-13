#!/bin/sh

old=`ls -l /home/mario/VCR/root_file`
new=`ls -l /home/mario/VCR/root_file`
while [ "$old" = "$new" ]
do
    ./vulp < append_text
    new=`ls -l /home/mario/VCR/root_file`
done
echo "STOP... root_file has been changed"
