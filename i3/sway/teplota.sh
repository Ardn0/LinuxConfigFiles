while true
do
	weather-Cli get Litomysl | grep "Temp" | cut -d ':' -f2 | xargs > ~/.config/i3/sway/teplota
	sleep 1800
done
