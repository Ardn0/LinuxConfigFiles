while true;
do

baterkaHodnota=$(cat /sys/class/power_supply/BAT1/capacity)

if [[ $baterkaHodnota <  "80"  ]]
then
	echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
else
	echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
fi

sleep 10
done

