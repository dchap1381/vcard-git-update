#!/bin/bash

#download files from vcard-update-scripts Git
if git clone https://github.com/dchap1381/vcard-update-scripts;
	then
		echo "vcard-update-scripts Git clone successful!"
	else
		echo "vcard-update-scripts Git clone NOT successful!!! Please try again."
		exit 1
fi

#create working copy directory
if mkdir /home/pi/update-scripts-wdir/;
	then
		echo "update-scripts working directory created!"
	else
		echo "update-scripts working directory NOT created!!! Please try again."
		exit 1
fi

#mv files from git directory to working copy directory
if mv /home/pi/vcard-update-scripts/gitcheck.sh /home/pi/update-scripts-wdir/;
	then
		echo "move gitcheck.sh to working directory successful!"
	else
		echo "move gitcheck.sh to working directory NOT successful!!! Please try again."
		exit 1
		
fi

if [ -e /home/pi/vcard-update-scripts/updateinstall.sh ];
	then
		if mv /home/pi/vcard-update-scripts/updateinstall.sh /home/pi/update-scripts-wdir/;
			then
				echo "move updateinstall.sh to working directory successful!"
			else
				echo "move updateinstall.sh to working directory NOT successful!!! No update available"
		fi
	else
		echo "updateinstall.sh NOT found. No new updates currently available!!!"
fi

#make scripts in working directory executable
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

if [ -e /home/pi/update-scripts-wdir/updateinstall.sh ];
	then
		if chmod +x /home/pi/update-scripts-wdir/updateinstall.sh;
			then
				echo "make updateinstall.sh executable successful!"
			else
				echo "make updateinstall.sh executable NOT successful!!! Please try again."
		fi
	else
		echo "updateinstall.sh NOT found!!! No new updates available."
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
