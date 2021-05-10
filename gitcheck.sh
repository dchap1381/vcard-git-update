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

diff_gitcheck()	{
	diff /home/pi/vcard-git-update/gitcheck.sh /home/pi/update-scripts-wdir/gitcheck.sh
}

diff_updateinstall()	{
	diff /home/pi/vcard-git-update/updateinstall.sh /home/pi/update-scripts-wdir/updateinstall.sh
}

chown_gitcheck()	{
	chown pi:pi /home/pi/update-scripts-wdir/gitcheck.sh
}

chown_updateinstall()	{
	chown pi:pi /home/pi/update-scripts-wdir/updateinstall.sh
}

#################
#START OF SCRIPT#
#################

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

#check if gitcheck exists
if gitcheck_exists;
then
	echo "gitcheck.sh found."
	if diff_gitcheck;
	then
		echo "no changes to gitcheck.sh found. nothing to do."
	else
		echo "changes to gitcheck.sh found."
		if cp_gitcheck;
		then
			echo "copy gitcheck.sh to working directory successful."
			if chown_gitcheck;
			then
				echo "change ownership of gitcheck.sh to user pi successful"
				if chmod_gitcheck;
				then
					echo "make gitcheck.sh executbale successful."
				else
					echo "make gitcheck.sh execuabtle NOT successful!!!"
				fi
			else
				echo "change ownership of gitcheck.sh NOT successful!!!"
			fi
		else
			echo "copy gitcheck.sh to working directory NOT successful!!!"
		fi
	fi
else
	echo "gitcheck.sh NOT found!!! Something went wrong. Please try again."
fi

#check if updateinstall exists
if updateinstall_exists;
then
	echo "updateinstall.sh found."
	if diff_updateinstall;
	then
		echo "no changes to updateinstall.sh found. keeping copy in working directory"
	else
		echo "changes to updateinstall.sh found."
		if cp_updateinstall;
		then
			echo "copy updateinstall.sh to working directory successful."
			if chown_updateinstall;
			then
				echo "change ownership of updateinstall.sh to user pi succesful."
				if chmod_updatinstall;
				then
					echo "make updateinstall.sh executable successful."
					if run_updateinstall;
					then
						echo "executing updateinstall.sh successful."
					else
						echo "executing updateinstall.sh NOT sucessful!!!"
					fi
				else
					echo "makee updateinstall.sh executable NOT successful!!!"
				fi
			else
				echo "change ownership of updateinstall.sh to user pi NOT successful!!!"
			fi
		else
			echo "copy updateinstall.sh to working directory NOT successful!!!"
		fi
	fi
else
	echo "updateinstall.sh NOT found!!! Something went wrong. Please try again."
fi

sleep 3
read -p "press enter to continue" -r
