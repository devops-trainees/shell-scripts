#!/bin/bash 
#######################################################################################
#Script Name    :cpu_util.sh
#Description    :send alert mail when CPU usage is more 
#Args           :       
#Author         :Saalim
#Email          :mahmed@nisum.com
#######################################################################################

to="msa.cool@gmail.com"

idle=$(top -l 1 | grep -E "^CPU" | awk -F '[/,]' '{print $3}' | awk -F '[/%]' '{print $1}' | awk '{gsub(/^[ \t]+| [ \t]+$/,""); print $0}')

## check if CPU utilization is more than 60%

if [[ "$idle" < 60 ]]; then

        ## Check temporary file and delete if present 
	
	[ -e memory.txt ] && rm memory.txt
	
 	top -l 1 | grep -E "^CPU" | awk -F '[/,]' '{print $3}' | awk -F '[/%]' '{print $1}' | awk '{gsub(/^[ \t]+| [ \t]+$/,""); print "CPU Utilization is "$0"%"}' | head>/tmp/memory.txt
        
	## send email if CPU utilization is more than 60% 
        
	mail -s "CPU utilization is high" "$to" < /tmp/memory.txt 

fi

exit 0

