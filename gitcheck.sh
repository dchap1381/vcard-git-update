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

#cd into Git directory before pull
if cd_vcard_git_update;
	then
		echo "cd into vcard-git-update successful!"
	else
		echo "cd into vcard-git-update NOT successful"
fi

#wait for networking before proceeding
echo "Waiting for 15 seconds to ensure network connectivity."
sleep 5
echo "Waiting.."
sleep 5
echo "Waiting..."
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
		if md5sum_gitcheck;
			then
				echo "gitcheck md5sum completed!"
				#compare gitcheck md5sum to detect updates
				if chown_gitcheck_md5sum;
					then
						echo "change ownership of gitcheck md5sum completed!"
						if md5check_gitcheck;
							then
								echo "changes to gitcheck NOT found! keeping copy in working directory"
							else
								#copying new version if found
								echo "changes to gitcheck found! copying to working directory"
								if cp_gitcheck;
									then
										echo "copy gitcheck to working directory successful!"
										if chmod_gitcheck;
											then
												echo "make gitcheck executable successful!"
											else
												echo "make gitcheck executable NOT successful!!! Please try again."
										fi
									else
										echo "copy gitcheck to working directory NOT successful!!!"
								fi
						fi
					else
						echo "change ownersup of gitcheck md5sum NOT competed!!! Please try again."
				fi
			else
				echo "gitcheck md5sum NOT completed!!!. Please try again."
		fi
	else
		echo "gitcheck.sh NOT found"

fi

#check if updateinstall exists
if updateinstall_exists;
	then
		echo "updateinstall found!"
		if md5sum_updateinstall;
			then
				echo "updateinstall md5sum completed!"
				#compare updateinstall md5sum to detect updates
				if md5check_updateinstall;
					then
						echo "changes to updateinstall NOT found! keeping copy in working directory"
					else
						echo "changes to updateinstall found. copying to working directory"
						#copying new version if found
						if cp_updateinstall;
							then
								echo "copy updateinstall to working directory successful"
								if chmod_updatinstall;
									then
										echo "make updateinstall executable successful"
										if run_updateinstall;
											then
												echo "updateinstall completed succesfully"
												#remove updateinstall script after executing
												if rm_updateinstall;
													then
														echo "updateinstall removed"
													else
														echo "updateinstall not removed"
												fi
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
			else
				echo "updateinstall md5sum NOT completed!!! Please try again."
		fi
	else
		echo "updateinstall NOT found!!! Please try again."
fi

sleep 5
read -r -p "Press enter to continue"
