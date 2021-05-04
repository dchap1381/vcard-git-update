#!/bin/bash

#cd into update-scripts-wdir Git directory
if cd /home/pi/vcard-git-update/;
	then
    		echo "cd into vcard-update-scripts working directory successful!"
  	else
    		echo "cd into vcard-update-scripts directory NOT successful!!! Exiting!"
    		exit 1
fi

#wait for networking
sleep 15

#check for Git updates
if git pull | grep "Already up-to-date.";
	#Git updates not available
	then
    		echo "No changes detected. Nothing to do."
		exit 1
	#Git updates available
  	else
    		echo "Changes detected"
fi

#check for gitcheck.sh
if [ -e /home/pi/vcard-git-update/gitcheck.sh ];
	then
		#gitcheck.sh does exist
		echo "/home/pi/vcard-git-update/gitcheck.sh does exist!"
		if mv /home/pi/vcard-git-upate/gitcheck.sh /home/pi/update-scripts-wdir/;
			then
			echo "move gitcheck.sh to working directory successful!"
				if chmod +x /home/pi/update-scripts-wdir/gitcheck.sh;
					#make gitcheck.sh executable
					then
						echo "make gitcheck.sh executable successful!"
					else
						echo "make gitcheck.sh executable NOT successful!!! Please try again."
						exit 1
				fi
			else
				echo "move gitcheck.sh to working directory NOT successful!!!"
				exit 1
		fi
	else
		echo "/home/pi/vcard-git-update/gitcheck.sh does NOT exist!!! Please try again."
		exit 1

fi

#check for updateinstall.sh
if [ -e /home/pi/vcard-git-update/updateinstall.sh ];
	then
		#updateinstall.sh does exist
		echo "/home/pi/vcard-git-update/updateinstall.sh does exist!"
		if mv /home/pi/vard-git-update/updateinstall.sh /home/pi/update-scripts-wdir/;
			then
				echo "move updateinstall.sh to working directory successful!"
				if chmod +x /home/pi/update-scripts-wdir/updateinstall.sh;
					#make updateinstall.sh executable
					then
						echo "make updateinstall.sh executable successful!"
						if /home/pi/update-scripts-wdir/updateinstall.sh;
							then
								echo "updateinstall.sh completed successfully!"
							else
								echo "updateinstall.sh NOT completed successfully!!! Please try again."
						fi
					else
						echo "make updateinstall.sh executable NOT successful!!! Please try again."
				fi
			else
				echo "move updateinstall.sh to working directory NOT successful!!!"
				exit 1
		fi
	else
		echo "/home/pi/vcard-git-update/updateinstall.sh does NOT exist!!! No updates available"

fi

if /home/pi/update-scripts-wdir/updateinstall.sh;
	then
		echo "updateinstall.sh completed successfully!"
		if rm /home/pi/update-scripts-wdir/updateinstall.sh;
			then
				echo "remove updateinstall.sh successful!"
			else
				echo "remove updateinstall.sh NOT successful. Please remove."
		fi
	else
		echo "updateinstall.sh NOT completed successfully!!! Please try again."
fi

reboot
