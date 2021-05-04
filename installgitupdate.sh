#!/bin/bash

#download files from vcard-update-scripts Git
#create working copy directory
#mv files from git directory to working copy directory
#make scripts in working directory executable
#check for gitcheck.sh
if [ -e /home/pi/testing/gitcheck.sh ];
	then
		#gitcheck.sh found
		echo "gitcheck.sh found!"
			#test making gitcheck.sh executable
			if chmod +x /home/pi/testing/gitcheck.sh;
				then
					#gitcheck.sh successfully set to run at boot
					echo "gitcheck.sh is now executable!"
				else
					#gitcheck.sh not successsfully set to run at boot
					echo "gitcheck.sh is NOT executable!!!. Please try again."
			fi
	else
		#gitcheck.sh not found
		echo "gitcheck.sh NOT found!!! Please try again!!!"
fi

#check if gitcheck.sh autostart exists
if grep "/home/pi/testing/gitcheck.sh" /etc/xdg/lxsession/LXDE-pi/autostart;
	then
		#gitcheck.sh already set to run at boot
		echo "gitcheck.sh already set to run at boot!"
	else
		#gitcheck.sh not already set to run at boot
		if echo "/home/pi/testing/gitcheck.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart;
			then
				#set to run at boot
				echo "gitcheck.sh set to run at boot!"
			else
				#gitcheck.sh cannot be set to run at boot
				echo "gitcheck.sh NOT set to run at boot!!! Please try again."
		fi
fi
