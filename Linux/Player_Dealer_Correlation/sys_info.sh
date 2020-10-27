#!/bin/bash


if [ $UID = 0 ]
	then
	echo "Do not run this script with root privileges"
	exit
fi


output_file=$HOME/research/sys_info.txt


#my_ip=$(hostname -I | awk '{print $1}')
my_ip=$(ip addr | head -9 | tail -1 | awk '{print $2}')
dns=$(grep "nameserver" /etc/resolv.conf | awk '{print $2}')
cpu=$(cat /proc/cpuinfo | grep "model name" | sort -u | awk -F: '{print $2}')
#disku=$(du -ch | tail -n 1)
disku=$(df -H | head -2)
freemem=$(free -h)



if [ ! -d $HOME/research ]
	then
	echo "Creating dir $HOME/research"
	mkdir $HOME/research
fi

if [ -f $output_file ]
	then
	echo "removing output file"
	rm $output_file
fi


echo "Writing files with SUID permissions to file"
echo -e "\nSUID files:" > $output_file
sudo find / -perm /4000 2>/dev/null >> $output_file

echo "Writing top 10 processes to file" 
echo -e "\nTop 10 processes:" >>$output_file
ps aux --sort -%mem | awk '{print $1, $2, $3, $4, $11}' | head -11 >> $output_file


echo -e "\nTodays date is $(date)" >> $output_file
echo -e "\nThe user is $USER" >> $output_file
echo -e "\nMy ip address is: $my_ip" >> $output_file
echo -e "\nMy Hostname is $HOSTNAME" >> $output_file
echo -e "\nMy DNS is $dns" >> $output_file
echo -e "\nThe Memory Information is: \n$freemem" >> $output_file
echo -e "\nThe CPU information is: \n$cpu" >> $output_file
echo -e "\nThe disk usage is: \n$disku" >> $output_file
echo -e "\nWho is logged in: \n$(who -a)\n" >> $output_file
