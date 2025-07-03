
#!/bin/bash

# Date: 2025-07-03
# Author: Arun CS



declare -A urls
urls[" Github"]="https://github.com"
urls[" Youtube"]="https://youtube.com"
urls[" Google"]="https://google.com"
urls[" YT Music"]="https://music.youtube.com"

options=$(printf "%s\n" "${!urls[@]}")

selected_option=$(echo -e "$options" | rofi -dmenu -i -p "Open in Brave App" -theme /home/aruncs/Git/Linux/scripts/catppuccin.rasi)

if [ -n "$selected_option" ]; then
    url=${urls[$selected_option]}
    brave --app="$url"
fi

