
#!/bin/bash

# Date: 2025-07-03
# Author: Arun CS

THEME=./themes/catppuccin.rasi
SCRIPT_DIR="$PWD"
URLFILE="$SCRIPT_DIR/urls.json"

declare -A urls


# Read urls from JSON file
while IFS="=" read -r key value; do
    urls["$key"]="$value"
done < <(jq -r 'to_entries[] | "\(.key)=\(.value)"' "$URLFILE")

# Check if any URLs were loaded
if [ ${#urls[@]} -eq 0 ]; then
    echo "Error: No URLs found in $URLFILE"
    exit 1
fi

# Create options for rofi
options=$(printf "%s\n" "${!urls[@]}")

# Show rofi menu and get user selection
selected_option=$(echo -e "$options" | rofi -dmenu -i -p "Open in Brave App" -theme "$SCRIPT_DIR/$THEME" -selected-row 0)

# Open the selected URL in Brave as an app
if [ -n "$selected_option" ]; then
    url=${urls[$selected_option]}
    echo "Opening: $url"
    brave --app="$url" &
else
    echo "No option selected"
fi

