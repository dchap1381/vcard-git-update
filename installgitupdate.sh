#!/bin/bash

#create working copies directory
if mkdir /home/pi/update-scripts-wdir/;
	then
		echo "update-scripts working directory created!"
	else
		echo "update-scripts working directory NOT created!!! Please try again."
		exit 1
fi

#check if gitcheck.sh exists in Git directory
if [ -e /home/pi/vcard-git-update/gitcheck.sh ];
	#gitcheck.sh does exist
	then
		echo "gitcheck.sh does exist!"
		#mv gitcheck.sh from Git directory to working copy directory
		if mv /home/pi/vcard-git-update/gitcheck.sh /home/pi/update-scripts-wdir/;
			#mv gitcheck.sh successful
			then
				echo "move gitcheck.sh to working directory successful!"
				#make gitcheck.sh in working directory executable
				if chmod +x /home/pi/update-scripts-wdir/gitcheck.sh;
					then
						echo "make gitcheck.sh executable successful!"
					else
						echo "make gitcheck.sh executable NOT successful!!! Please try again."
				fi
			#mv gitcheck.sh not successful
			else
				echo "move gitcheck.sh to working directory NOT successful!!! Please try again."
				exit 1
		fi
	#gitcheck.sh does not exist
	else
		echo "gitcheck.sh does NOT exist!!!. Please try again."
		exit 1
fi

#check if gitcheck.sh autostart exists
if grep "/home/pi/update-scripts-wdir/gitcheck.sh" /etc/xdg/lxsession/LXDE-pi/autostart;
	then
		#gitcheck.sh already set to run at boot
		echo "gitcheck.sh already set to run at boot!"
	else
		#gitcheck.sh not already set to run at boot
		if echo "/home/pi/update-scripts-wdir/gitcheck.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart;
			then
				#set to run at boot
				echo "gitcheck.sh set to run at boot!"
			else
				#gitcheck.sh cannot be set to run at boot
				echo "gitcheck.sh NOT set to run at boot!!! Please try again."
		fi
fi