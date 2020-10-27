#!bin/bash

#How to use shell:- run shell program and after place date eg(0310) then time and then am or pm eg 
# sh roulette_dealer_finder_by_time.sh 0310 8 am 

cat $1_Dealer_schedule | awk '{print $1,$2,$3,$4,$5.$6,$7,$8}' | grep -i $2 | grep -iw $3
