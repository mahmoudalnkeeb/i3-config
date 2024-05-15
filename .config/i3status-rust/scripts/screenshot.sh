#!/bin/bash

mkdir -p ~/Pictures
filename=~/Pictures/Screenshots/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png

# open screenshot tool
scrot -a 0,0,1600,900 -q 100 -o "$filename"

# play a "Camera shutter" sound
paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &

# remove outer pixel rows because they sometimes include the capture border
mogrify -crop +1+1 -crop -1-1 +repage "$filename"

# copy to clipboard
xclip -sel clip -t image/png -i "$filename"

# Alternatively: upload to imgbb, keep for 1h
#RES=$(curl --location --request POST -F "image=@$filename" "https://api.imgbb.com/1/upload?expiration=3600&key=YOUR_API_KEY_HERE")
#echo $RES | jq -r '.data.url' | xclip -sel clip -i
