#!/bin/bash

#help menu
if [ "$1" = "--help" ] || [ -z $1 ]; then
	echo "encrypt command help:"
	echo ""
	echo "Syntax: encrypt [option] [password] [plaintext_filename] [encrytped_filename] [key_filename]"
	echo ""
	echo "Options:"
	echo ""
	echo "-c create:"
	echo "   create new key and iv values"
	echo "   requires [password] and [key_filename]"
	echo "   output = [key_filename]"
	echo ""
	echo "-e encrypt:"
	echo "   encrypt a plain text file with a specific key"
	echo "   requires [plaintext_filename] and [key_filename]"
	echo "   output = {plaintext_filename].enc"
	echo ""
	echo "-ce create and encrypt:"
	echo "   create the key and iv values and encrypt a plain text file."
	echo "   requires [password], [plaintext_filename] and [key_filename]"
	echo "   output = [key_filename] and [plaintext_filename].enc"
	echo ""
	echo "-d de-crypt:"
	echo "   de-crypt an encrypted file with a key and iv"
	echo "   requires [encrypted_filename] and [key_filename]"
	echo "   output = [encrypted_filename].txt"
	echo ""
	exit
fi

#if no options are selected, display the error messsage
if [ $1 != "-c" ] && [ $1 != "-e" ] && [ $1 != "-ce" ] && [ $1 != "-d" ]; then
	echo "You have not selected a valid option for this command."
	echo "Please check the help file.  'encrypt --help'."
	exit
fi

#Check the arguments are entered for option-c
if [ "$1" = "-c" ] && [ -z $2 ]; then
	echo -e "You have not selected a password and the file name for the key file."
	echo -e "Please check the help file.   'encrypt --help'."
	exit
fi
if [ "$1" = "-c" ] && [ -z $3 ]; then
	echo -e "You have not selected the file name for the key file."
	echo -e "Please check the help file.   'encrypt --help'."
	exit
fi
#Check the arguments are entered for option-e
if [ "$1" = "-e" ] && [ -z $2 ]; then
        echo -e "You have not selected a file to be encrypted and the file name for the key file."
        echo -e "Please check the help file.   'encrypt --help'."
        exit
fi
if [ "$1" = "-e" ] && [ -z $3 ]; then
        echo -e "You have not selected the file name for the key file."
        echo -e "Please check the help file.   'encrypt --help'."
        exit
fi
#Check the arguments are entered for option-ce
if [ "$1" = "-ce" ] && [ -z $2 ]; then
        echo -e "You have not selected a password, a file to be encrypted and the file name for the key file."
        echo -e "Please check the help file.   'encrypt --help'."
        exit
fi
if [ "$1" = "-ce" ] && [ -z $3 ]; then
        echo -e "You have not selected a file to be encrypted and the file name for the key file."
        echo -e "Please check the help file.   'encrypt --help'."
        exit
fi
if [ "$1" = "-ce" ] && [ -z $4 ]; then
        echo -e "You have not selected the file name for the key file."
        echo -e "Please check the help file.   'encrypt --help'."
        exit
fi
#Check the arguments are entered for option-d
if [ "$1" = "-d" ] && [ -z $2 ]; then
        echo -e "You have not selected a file to be de-crypted and the file name for the key file."
        echo -e "Please check the help file.   'encrypt --help'."
        exit
fi
if [ "$1" = "-d" ] && [ -z $3 ]; then
        echo -e "You have not selected the file name for the key file."
        echo -e "Please check the help file.   'encrypt --help'."
        exit
fi
#create key and iv file
if [ "$1" = "-c" ]; then
	if [ ! -f "$3" ]; then
		openssl enc -pbkdf2 -nosalt -aes-256-cbc -k $2 -P > $3
		echo "Key and iv file created successfully!"
		echo ""
		exit
	else
		echo -e "\e[31;43mThe key file already exists!\e[0m"
		echo "Please use the existing file or create a new file!"
		echo ""
		exit
	fi
fi
#Encrpyt plain text file
if [ "$1" = "-e" ]; then
	key=$(cat $3 | grep key | awk -F'=' '{print $2}')
	iv=$(cat $3 | grep iv | awk -F'=' '{print $2}')
	output=$2".enc"
	if [ ! -f $output ]; then
		openssl enc -pbkdf2 -nosalt -aes-256-cbc -in $2 -out $output -base64 -K $key -iv $iv
                echo "Encrypted file $output created successfully!"
                echo ""
                exit
	else
		echo -e "\e[31;43mThe encrypted file already exists!\e[0m"
		echo ""
		exit
	fi
fi
#Create Key file and Encrpyt plain text file
if [ "$1" = "-ce" ]; then
        if [ ! -f "$4" ]; then
                openssl enc -pbkdf2 -nosalt -aes-256-cbc -k $2 -P > $4
                echo "Key and iv file created successfully!"
                echo ""
        else
                echo -e "\e[31;43mThe key file already exists!\e[0m"
                echo "Please use the existing file or create a new file!"
                echo ""
                exit
        fi
        key=$(cat $4 | grep key | awk -F'=' '{print $2}')
        iv=$(cat $4 | grep iv | awk -F'=' '{print $2}')
        output=$3".enc"
        if [ ! -f $output ]; then
                openssl enc -pbkdf2 -nosalt -aes-256-cbc -in $3 -out $output -base64 -K $key -iv $iv
                echo "Encrypted file $output created successfully!"
                echo ""
                exit
        else
                echo -e "\e[31;43mThe encrypted file already exists!\e[0m"
                echo ""
                exit
        fi
fi
#Encrpyt plain text file
if [ "$1" = "-d" ]; then
        key=$(cat $3 | grep key | awk -F'=' '{print $2}')
        iv=$(cat $3 | grep iv | awk -F'=' '{print $2}')
        openssl enc -pbkdf2 -nosalt -aes-256-cbc -in $2 -d -base64 -K $key -iv $iv
        exit
fi
