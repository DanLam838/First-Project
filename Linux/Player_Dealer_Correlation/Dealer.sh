#!bin/bash
cat $1 | awk '{print $1,$2,$5,$6}' | grep -iw $3 | grep -iw $2 >> Notes_Dealer_Analysis


























