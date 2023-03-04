doas cpupower frequency-set -g conservative
xrandr --output eDP --mode 1920x1200
sudo ~/.config/i3/sway/rootScripts/napajeniKontrola.sh

while :;
do
	doas ryzenadj -k 60000 -g 33000 -c 30000 -d 10 -f 80
	sleep 60
done
