#!/bin/bash

#sudo cpupower frequency-set -g conservative
sudo ~/.config/sway/rootScripts/napajeniKontrola.sh &

while true ;
do
	#sudo ryzenadj -k 60000 -g 33000 -c 30000 -d 10 -f 80
	sudo ryzenadj -k 55000 -g 25000 -c 20000 -d 10 -f 70
	sleep 30
done
