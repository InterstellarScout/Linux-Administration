#!/bin/bash
echo usage uniqueFileName.sh {fileName}
echo "What do you want to call the archive?"
read name
echo "What directory do you want to save?"
read directory

for i in $( ls ); do
 #echo item: $i
 if [ "$i" = "$name" ];
  then
  echo found $i
  exit 1
 fi
done

set `date`
tar -zcvf ${name}.tar.gz $directory