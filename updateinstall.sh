#!/bin/bash
#testing modifications
#testing mods again

if [ -e /home/pi/Desktop/testfile.txt ];
  then
    echo "testfile.txt does exist! Nothing to do!"
  else
    echo "testfile.txt does NOT exist!!! Proceeding."
    if touch /home/pi/Desktop/testfile.txt;
      then
        echo "testfile.txt created!"
      else
        echo "testfile.txt NOT created!!!"
    fi
fi
