#!/bin/bash

cd_vcard_git_update()	{
	cd /home/pi/vcard-git-update/ || return
}

git_pull()	{
	git pull | grep "Already up-to-date."
}

md5sum_gitcheck()	{
	md5sum /home/pi/vcard-git-update/gitcheck.sh | tee /home/pi/update-scripts-wdir/gitcheck.md5sum
}

md5sum_updateinstall()	{
	md5sum /home/pi/vcard-git-update/updateinstall.sh | tee /home/pi/update-scripts-wdir/updateinstall.md5sum
}

cd_update_scripts_wdir()	{
	cd /home/pi/update-scripts-wdir || return
}

md5check_gitcheck()	{
	md5sum -c /home/pi/update-scripts-wdir/gitcheck.md5sum
}

cp_gitcheck()	{
	cp /home/pi/vcard-git-update/gitcheck.sh /home/pi/update-scripts-wdir/
}

md5check_updateinstall()	{
	md5sum -c /home/pi/update-scripts-wdir/updateinstall.md5sum
}

cp_updateinstall()	{
	cp /home/pi/vcard-git-update/updateinstall.sh /home/pi/update-scripts-wdir/
}

chmod_gitcheck()	{
	chmod +x /home/pi/update-scripts-wdir/gitcheck.sh
}

chmod_updatinstall()	{
	chmod +x /home/pi/update-scripts-wdir/updateinstall.sh
}

run_updateinstall()	{
	/home/pi/update-scripts-wdir/updateinstall.sh
}

rm_updateinstall()	{
	rm /home/pi/update-scripts-wdir/updateinstall.sh
}

chown_gitcheck_md5sum()	{
	chown pi:pi /home/pi/update-scripts-wdir/gitcheck.md5sum
}

chown_updateinstall_md5sum()	{
	chown pi:pi /home/pi/update-scripts-wdir/updateinstall.md5sum
}

gitcheck_exists()	{
	[ -e /home/pi/vcard-git-update/gitcheck.sh ]
}

updateinstall_exists()	{
	[ -e /home/pi/vcard-git-update/updateinstall.sh ]
}

run_updateinstall()	{
	/home/pi/update-scripts-wdir/updateinstall.sh
}

#cd into Git directory before pull
if cd_vcard_git_update;
	then
		echo "cd into vcard-git-update successful!"
	else
		echo "cd into vcard-git-update NOT successful"
fi

#wait for networking before proceeding
echo "Waiting for 30 seconds to ensure network connectivity."
sleep 5
echo "Waiting.."
sleep 5
echo "Waiting..."
sleep 5
echo "Still waiting...."
sleep 5
echo "Waiting some more....."
sleep 5
echo "Yep... still waiting......"
sleep 5
echo "Finished waiting!"

#check for Git updates to vcard-git-update directory
if git_pull;
	then
		echo "Git pull successful!"
	else
		echo "Git pull NOT successful!!! Please try again."
fi

#cd into update-scripts-wdir working directory
if cd_update_scripts_wdir;
	then
		echo "cd into update-scripts-wdir successful!"
	else
		echo "cd into update-scripts-wdir NOT successful!!!"
fi

#check if gitcheck.sh exists
if gitcheck_exists;
	then
		echo "gitcheck.sh found!"
		if md5check_gitcheck;
			then
				echo "changes to gitcheck NOT found!!! Keeping copy in working directory."
			else
				echo "changes to gitcheck found!"
				if md5sum_gitcheck;
					then
						echo "New gitcheck md5sum successful"
						if chown_gitcheck_md5sum;
							then
								echo "change ownership of gitcheck md5sum successful!"
								if cp_gitcheck;
									then
										echo "copy gitcheck to working directory successful!"
										if chmod_gitcheck;
											then
												echo "make gitcheck executable successful!"
											else 
												echo "make gitcheck executable NOT successful!!!"
										fi
									else
										echo "copy gitcheck to working directory NOT successful!!!"
								fi
							else
								echo "change ownership of gitcheck md5sum NOT successful!!!"
						fi
					else
						echo "New gitcheck md5sum NOT successful!!!"
				fi
		fi
	else
		echo "gitcheck.sh NOT found!!!"
fi

#check if updateinstall exists
if updateinstall_exists;
	then
		echo "updateinstall found!"
		if md5check_updateinstall;
			then
				echo "changes to updateinstall NOT found!!! Keeping copy in working directory"
			else
				echo "changes to updateinstall found!"
				if md5sum_updateinstall;
					then
						echo "new updateinstall md5sum successful!"
						if chown_updateinstall_md5sum;
							then
								echo "change ownership of updateinstall md5sum successful!"
								if cp_updateinstall;
									then
										echo "copy updateinstall to working directory successful!"
										if chmod_updatinstall;
											then
												echo "make updateinstall executable successful!"
												if run_updateinstall;
													then
														echo "executing updateinstall successful!"
													else
														echo "executing updateinstall NOT successful!!! updates not applied!!!"
												fi
											else
												echo "make updateisntall executable NOT successful!!!"
										fi
									else
										echo " copy updateinstall to working directory NOT successful!!!"
								fi
							else
								echo "change ownershuo of updateinstall md5sum NOT successful!!!"
						fi
					else
						echo "new updateinstall md5sum NOT successful!!!"
				fi
		fi
	else
		echo "udpateinstall NOT found!!!"
fi

sleep 5
read -r -p "Press enter to continue"

