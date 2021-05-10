#!/bin/bash

check_vcardstartsh_autostart()	{
	grep /home/pi/vcardstart.sh /etc/xdg/lxsession/LXDE-pi/autostart
}

check_vcarddesktop_shortcut()	{
	[ -e /home/pi/.config/autostart/vcard.desktop ]
}

check_vcardstartsh_exists()	{
	[ -e /home/pi/vcardstart.sh ]
}

chmod_vcardstartsh()	{
	chmod +x /home/pi/vcardstart.sh
}

rm_vcarddesktop_shortcut()	{
	rm /home/pi/.config/autostart/vcard.desktop
}

chown_vcardstartsh()	{
	chown pi:pi /home/pi/vcardstart.sh
}

create_vcardstartsh()	{
	cat >> /home/pi/vcardstart.sh << EOF
#!/bin/bash

#function to restart vCard POS
while :
	do
		if pgrep vcardpos.sh;
			then
				echo "POS Running!"
				sleep 5
			else
				echo "POS NOT Running!!!"
				/home/pi/vcard/vcardpos.sh
				sleep 5
		fi
done
EOF
}

create_vcardstartsh_autostart()	{
	cat >> /etc/xdg/lxsession/LXDE-pi/autostart << EOF
/home/pi/vcardstart.sh
EOF
}

# check if old vcard.desktop autostart exists
if check_vcarddesktop_shortcut;
	then
		echo "old vcard.desktop autostart shortcut does exist!!!"
		# remove old vcard.desktop autostart
		if sudo rm_vcarddesktop_shortcut;
			then
				echo "remove old vcard.dekstop autostart shortcut successful!"
			else
				echo "remove old vcard.desktop autostart shortcut NOT successful!!!"
		fi
	else
		echo "old vcard.desktop autostart shortcut does NOT exist!"

fi

									
# check if vcardstart autostart shortcut exists
if check_vcardstartsh_autostart;
	then
		echo "vcardstart.sh autostart shortcut does exist!"
	else
		echo "vcardstart.sh autostart shortcut does NOT exist!!!"
		#create vcardstart link in autostart
		if sudo create_vcardstartsh_autostart;
			then
				echo "create vcardstart.sh autostart successful!"
			else
				echo "create vcardstart.sh autostart NOT successful!!!"
		fi
fi

# check if vcardstart.sh exists
if check_vcardstartsh_exists;
	then
		# vcardstart.sh does exist
		echo "vcardstart.sh does exist!"
	else
		# vcardstart.sh does not exist
		echo "vcardstart.sh does NOT exist!!!"
			# create vcardstart.sh file
			if create_vcardstartsh;
				then
					echo "vcardstart.sh created!"
					#chmod vcardstart.sh
					if chmod_vcardstartsh;
						then
							echo "vcardstart.sh executable!"
							#chown vcardstart.sh
							if chown_vcardstartsh;
								then
									echo "change ownership of vcardstart.sh successful!"
								else
									echo "cahnge ownership of vcardstart.sh NOT successfull!!!"
							fi
						else
							echo "vcardstart.sh NOT executable!!!"
					fi
				else
					echo "vcardstart.sh NOT successful!!!"
			fi
fi

echo "Please reboot to apply changes"
read -p "press ENTER to reboot" -r
sleep 3
reboot
