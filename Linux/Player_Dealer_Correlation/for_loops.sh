#!/bin/bash

num=(0 1 2 3 4 5 6 7 8 9)
states=(
	'Hawaii'
	'Florida'
	'California'
	'Washington'
	'Nevada'
)
list=$(ls)

suid=$(find / -type f -perm /4000 2>/dev/null)

for nums in ${num[@]}
do
	if [ $nums = 3 ] || [ $nums  = 5 ] || [ $nums = 7 ]
	then
	echo $nums
	fi
done


x=0
for st in ${states[@]}
do
	if [ $st = 'Hawaii' ]
	then
	echo "Hawaii is the best!"
	x=1
	fi
done

if [ $x = 0 ]
then
echo "I'm not fond of Hawaii"
fi

for lst in ${list[@]}
do
echo $lst
done

for suidd in ${suid[@]}
do
	echo $suidd
done
