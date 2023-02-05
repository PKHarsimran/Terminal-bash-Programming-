#!/bin/bash

# Check if the script is being run as root user
if [ $UID -eq 0 ] # Check if the UID is equal to zero
then
	echo "Please do not run this script as root" # Display message
	exit # Exit the script
fi

# Store the location of sys_info.txt in the "output" variable
output=$HOME/research/sys_info.txt 

# Store the IP address of the device in the "ip" variable
ip=$(ip addr | grep inet | tail -2 | head -1) 

# Store the list of SUID files in the "suids" variable
suids=$(find  / -type f -perm /4000 2> /dev/null)

# Check if the research directory exists in the HOME directory
if [ ! -d $HOME/research ] 
then 
  # Create the research directory if it does not exist
  mkdir $HOME/research 
fi

# Check if the output file exists
if [ -f $output ] 
then
	# Clear the output file if it exists
	> $output
fi

# Write "A Quick System Audit Script" to the output file
echo "A Quick System Audit Script" >> $output 

# Write the current date to the output file
date >> $output

# Add a blank line to the output file
echo "" >> $output

# Write "Machine Type Info:" to the output file
echo "Machine Type Info:" >> $output

# Write the MACHTYPE to the output file
echo -e "$MACHTYPE \n" >> $output

# Write the output of "uname -a" to the output file
echo -e "Uname info: $( uname -a ) \n" >> $output

# Write "IP info:" to the output file
echo -e "IP info:  \n" >> $output

# Write the IP address to the output file
echo -e "$ip \n" >> $output

# Write the hostname to the output file
echo -e "Hostname: $(hostname -s)  \n" >> $output

# Write "DNS Servers:" to the output file
echo "DNS Servers: " >> $output

# Write the contents of /etc/resolv.conf to the output file
cat /etc/resolv.conf >> $output

# Write "Memory Info:" to the output file
echo -e "\nMemory Info: " >> $output

# Write the output of "free" to the output file
free >> $output

# Write "CPU Info:" to the output file
echo -e "\nCPU Info: " >> $output

# Write the output of "free" to the output file
free >> $output

# Write "SUID files:" to the output file
echo -e "\nSUID files:" >> $output

# Write the list of SUID files to the output file
echo $suids >> $output

# Write "Top 10 Processes" to the output file
echo -e "\nTop 10 Processes" >> $output 

# Write the top 10 processes sorted by memory usage to the output file
ps aux --sort -%mem |awk {'print $1, $2, $3, $4, $11'} | head >> $output
