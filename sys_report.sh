#!/bin/bash 
#######################################################################################
#Script Name    :sys_report.sh
#Description    :daily system report 
#Args           :       
#Author         :Saalim
#Email          :mahmed@nisum.com
#######################################################################################

to="msa.cool@gmail.com"

sw_vers > /tmp/sysrep.txt

uname -a >> /tmp/sysrep.txt

echo "IP Address:" >> /tmp/sysrep.txt
ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 >> /tmp/sysrep.txt 

top -l 1 | grep -E "^CPU" >> /tmp/sysrep.txt
        
mail -s "Daily System Report" "$to" < /tmp/sysrep.txt 

exit 0

