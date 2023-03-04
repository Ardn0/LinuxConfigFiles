swaymsg "output * dpms on"

hodnotaKlavesnice=$(cat ~/.config/sway/klavesnice)

if [[ "$hodnotaKlavesnice" == "1" ]]
then
echo 1 > /sys/class/leds/platform::kbd_backlight/brightness
fi

