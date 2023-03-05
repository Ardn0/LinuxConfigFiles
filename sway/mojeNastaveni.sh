sudo cpupower frequency-set -g conservative
sudo ~/.config/i3/sway/rootScripts/napajeniKontrola.sh

while :;
do
	doas ryzenadj -k 60000 -g 33000 -c 30000 -d 10 -f 80
	sleep 60
done
