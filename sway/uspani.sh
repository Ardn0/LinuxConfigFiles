cat /sys/class/leds/platform\:\:kbd_backlight/brightness > ~/.config/sway/klavesnice
echo 0 > /sys/class/leds/platform\:\:kbd_backlight/brightness
swaymsg "output * dpms off"
