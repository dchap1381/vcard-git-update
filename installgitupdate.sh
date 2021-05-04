#!/bin/bash

#download files from vcard-update-scripts Git
if git clone https://github.com/dchap1381/vcard-update-scripts;
	then
		echo "vcard-update-scripts Git clone successful!"
	else
		echo "vcard-update-scripts Git clone NOT successful!!! Please try again."
		exit 1
fi

#create working copies directory
if mkdir /home/pi/update-scripts-wdir/;
	then
		echo "update-scripts working directory created!"
	else
		echo "update-scripts working directory NOT created!!! Please try again."
		exit 1
fi

#mv gitcheck.sh from Git directory to working copy directory
if mv /home/pi/vcard-update-scripts/gitcheck.sh /home/pi/update-scripts-wdir/;
	then
		echo "move gitcheck.sh to working directory successful!"
	else
		echo "move gitcheck.sh to working directory NOT successful!!! Please try again."
		exit 1
		
fi

#make gitcheck.sh in working directory executable
if [ -e /home/pi/update-scripts-wdir/gitcheck.sh ];
	then
		if chmod +x /home/pi/update-scripts-wdir/gitcheck.sh;
			then
				echo "make gitcheck.sh executable successful!"
			else
				echo "make gitcheck.sh executable NOT successful!!! Please try again."
		fi
	else
		echo "gitcheck.sh NOT found!!! Please try again."
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
