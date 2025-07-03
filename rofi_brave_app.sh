
#!/bin/bash

# Date: 2025-07-03
# Author: Arun CS

THEME=./themes/catppuccin.rasi
SCRIPT_DIR="$PWD"
URLFILE="$SCRIPT_DIR/urls.json"

declare -A urls

# Function to get bookmarks from Brave
function get_bookmarks() {
    jq -r '.. | objects | select(has("url")) | [.name, .url] | @tsv' ~/.config/BraveSoftware/Brave-Browser/Default/Bookmarks 2>/dev/null
}

# Read urls from JSON file if it exists
if [ -f "$URLFILE" ]; then
    while IFS="=" read -r key value; do
        urls["$key"]="$value"
    done < <(jq -r 'to_entries[] | "\(.key)=\(.value)"' "$URLFILE" 2>/dev/null)
fi

# Add bookmarks from Brave to the urls array
if command -v jq &> /dev/null; then
    while IFS=$'\t' read -r name url; do
        # Add a bookmark prefix to distinguish from static URLs
        bookmark_key=" $name"
        urls["$bookmark_key"]="$url"
    done < <(get_bookmarks)
fi

# Check if any URLs were loaded
if [ ${#urls[@]} -eq 0 ]; then
    echo "Error: No URLs found in $URLFILE and no bookmarks available"
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

