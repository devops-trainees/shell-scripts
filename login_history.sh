#######################################################################################
#Script Name    :login_history.sh
#Description    :failed login history 
#Args           :       
#Author         :Saalim
#Email          :mahmed@nisum.com
#######################################################################################
#!/bin/bash

to=msa.cool@gmail.com

failed_Login=$(  syslog | grep -E 'LOGIN FAILURE | authentication error for | BAD SU | incorrect password attempts' | wc -l | tr -d ' ' )

if [[ "$failed_Login" > 1 ]]; then

        ## Check temporary file and delete if present 
	
	[ -e /tmp/login.txt ] && rm /tmp/login.txt
	
	syslog | grep -E 'LOGIN FAILURE | authentication error for | BAD SU | incorrect password attempts' | tail>/tmp/login.txt
        
	## send email if ncorrect login attempts 
        
	mail -s "Incorrect Login History" "$to" < /tmp/login.txt 

fi

exit 0
