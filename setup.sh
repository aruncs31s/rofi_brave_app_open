#!/bin/bash

# Date: 2025-07-03
# Author: Arun CS

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install it first."
    sudo apt install jq || sudo dnf install jq || sudo zypper install jq || sudo pacman -S jq
    exit 1
fi

# Check if rofi is installed
if ! command -v rofi &> /dev/null; then
    echo "Error: rofi is not installed. Please install it first."
    sudo apt install rofi || sudo dnf install rofi || sudo zypper install rofi || sudo pacman -S rofi
    exit 1
fi
