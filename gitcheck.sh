#!/bin/bash

cd-vcard-git-update()	{
	/home/pi/vcard-git-update/
}

git-pull()	{
	git pull | grep "Already up-to-date."
}

md5sum-gitcheck()	{
	md5sum /home/pi/vcard-git-update/gitcheck.sh > tee /home/pi/update-scripts-wdir/gitcheck.md5sum
}

md5sum-updateinstall()	{
	md5sum /home/pi/vcard-git-update/updateinstall.sh > tee /home/pi/update-scripts-wdir/updatinstall.md5sum
}

cd-update-scripts-wdir()	{
	cd /home/pi/update-scripts-wdir
}

md5check-gitcheck()	{
	md5sum -c /home/pi/update-scripts-wdir/gitcheck.sh
}

cp-gitcheck()	{
	cp /home/pi/vcard-git-update/gitcheck.sh
}

md5check-updateinstall()	{
	md5sum -c /home/pi/update-scripts-wdir/updateinstall.sh
}

cp-updateinstall()	{
	cp /home/pi/vcard-git-update/updateinstall.sh
}

chmod-updatinstall()	{
	chmod +x /home/pi/update-scripts-wdir/updateinstall.sh
}

run-updateinstall()	{
	/home/pi/update-scripts-wdir/updateinstall.sh
}

rm-updateinstall()	{
	rm /home/pi/update-scripts-wdir/updateinstall.sh
}

#cd in
if cd-vcard-git-update;
	then
		echo "cd into vcard-git-update successful!"
	else
		echo "cd into vcard-git-update NOT successful"
fi

#wait for networking before proceeding
sleep 15

#check for Git updates to vcard-git-update directory
if git-pull;
	then
		echo "No changes detected!!!"
	else
		echo "Changes detected!"
			#create md5sum for gitcheck
			if md5sum-gitcheck;
				then
					echo "gitcheck md5sum completed!"
				else
					echo "gitcheck md5sum NOT completed!!!"
			fi

			#create md5sum for updateinstall
			if md5sum-updateinstall;
				then
					echo "updateinstall md5sum completed!"
				else
					echo "updateinstall md5sum NOT comppleted!!!"
			fi
fi

if cd-update-scripts-wdir;
	then
		echo "cd into update-scripts-wdir successful!"
	else
		echo "cd into update-scripts-wdir NOT successful!!!"
fi

if md5check-gitcheck;
	then
		echo "changes to gitcheck NOT found! keeping copy in working directory"
	else
		echo "changes to gitcheck found! copying to working directory"
			if cp-gitcheck;
				then
					echo "copy gitcheck to working directory successful!"
				else
					echo "copy gitcheck to working directory NOT successful!!!"
			fi
fi

if md5check-updateinstall;
	then
		echo "changes to updateinstall NOT found! keeping copy in working directory"
	else
		echo "changes to updateinstall found. copying to working directory"
			if cp-updateinstall;
				then
					echo "copy updateinstall to working directory successful"
						if chmod-updatinstall;
							then
								echo "make updateinstall executable successful"
									if run-updateinstall;
										then
											echo "updateinstall completed succesfully"
										else
											echo "updateinstall NOT completed successfully"
									fi
							else
								echo "make updateinstall executable NOT successful"
						fi
								
				else
					echo "copy updateinstall to working directory NOT successful"
			fi
fi

if rm-updateinstall:
	then
		echo "updateinstall removed"
	else
		echo "updateinstall not removed"
fi

sleep 5
read -p "Press enter to reboot"
#reboot
