#!/bin/bash
if [ $UID -eq 0 ] # << grabs the UID if its equal to zero 
then
	echo "Please do not run this script as root" # then display this message 
	exit # exit without running anyother code VVVVVVVVVVVVVVVV
fi

output=$HOME/research/sys_info.txt #output variable will hold the location of sys_info.txt
ip=$(ip addr | grep inet | tail -2 | head -1) # find ip address of device 
suids=$(find  / -type f -prem /4000 2> /dev/null)

if [ ! -d $HOME/research ] # if for location of research dir . if not found then make one
then 
mkdir $HOME/research #create dir
fi

if [ -f $output ] #check output file. clear it if needed
then
	> $output
fi

echo "A Quick System Audit Script" >> $output #outptut it to the file
date >> $output
echo "" >> $output
echo "Machine Type Info:" >> $output
echo -e "$MACHTYPE \n" >> $output
echo -e "Uname info: $( uname -a ) \n" >> $output
echo -e "IP info:  \n" >> $output
echo -e "$ip \n" >> $output
echo -e "Hostname: $(hostname -s)  \n" >> $output
echo "DNS Servers: " >> $output

cat /etc/resolv.conf >> $output
echo -e "\nMemory Info: " >> $output
free >> $output
echo -e "\nCPU Info: " >> $output
free >> $output
echo -e "\nSUID files:" >> $output
echo $suids >> $output
echo -e "\nTop 10 Processes" >> $output 
ps aux --sort -%mem |awk {'print $1, $2, $3, $4, $11'} | head >> $output #show top 10 process 
