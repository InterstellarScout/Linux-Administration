#!/bin/sh
#Arrays
echo lets try array mang

#numbers=( $(dig +short interstellartech.net | grep -oP 'okay.+?\K\d+$') )

mapfile -t lines < <(dig +short interstellartech.net)

#oldifs="$IFS"
#IFS=$'\n'
#array=($(dig +short interstellartech.net))
#IFS="$oldifs"


for address in "${array[@]}"
do
echo $address
done

echo hey


