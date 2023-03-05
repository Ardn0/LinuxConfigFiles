#!/bin/bash
#
#

while true; do
datumCas=$(date +'%H:%M %d.%m.%Y')
verzeKernelu=$(uname -r | cut -d '-' -f1)
statusBaterie=$(cat /sys/class/power_supply/BAT1/status)
procentoBaterie=$(cat /sys/class/power_supply/BAT1/capacity)
procentoJas="nic"
procentoZvuk=$(pactl get-sink-volume 0 | cut -d '/' -f2 | head -n 1 | xargs)
zvukZtlumen=$(pactl get-sink-mute 0)
mikrofonZtlumen=$(pactl get-source-mute 0)
teplota=$(cat ~/.config/sway/teplota)
teplotaCPU=$(sensors | grep "temp1" | cut -d ':' -f2 | cut -d '(' -f1 | cut -d '+' -f2 | xargs)
rozlozeniKlavesnice="nic"
wifiPripojena=$(nmcli | grep "wlp1s0" | head -1 | cut -d ':' -f2 | cut -d ' ' -f4 | xargs)



# WIFI
if [[ "$wifiPripojena" == "" ]]
then
	wifiPripojena="WIFI odpojena"
fi

# ZVUK a MIKROFON
if [[ "$zvukZtlumen" == *"yes"* ]]
then
	procentoZvuk="----"
fi

if [[ "$mikrofonZtlumen" == *"yes"* ]]
then
	mikrofonZtlumen="----"
else
	mikrofonZtlumen=$(pactl get-source-volume 0 | cut -d '/' -f2 | head -n 1 | xargs)
fi

# ZBYTEK
if [[ "$statusBaterie" == "Not charging" ]]
then 
	   echo [$wifiPripojena][$rozlozeniKlavesnice][CPU $teplotaCPU][Litomyšl $teplota][Zvuk $procentoZvuk, Mic $mikrofonZtlumen][Jas $procentoJas%][Baterie $procentoBaterie%][Kernel $verzeKernelu][$datumCas]

else
        if [[ "$statusBaterie" == "Charging" ]]
        then
        statusBaterie="+"
        fi

        if [[ "$statusBaterie" == "Discharging" ]]
        then
        statusBaterie="-"
        fi

echo [$wifiPripojena][$rozlozeniKlavesnice][CPU $teplotaCPU][Litomyšl $teplota][Zvuk $procentoZvuk '|' Mic $mikrofonZtlumen][Jas $procentoJas%][Baterie $statusBaterie $procentoBaterie%][Kernel $verzeKernelu][$datumCas]
fi

sleep 1
done
