#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 [--set <File Location> | --reload]"
    exit 1
fi

case $1 in
    --set|-s)
        if [ -z "$2" ]; then
            echo "Error: Missing file location for --set option."
            exit 1
        fi
        if [[ "$2" != /* ]]; then
            filepath="$(pwd)/$2"
        else
            filepath="$2"
        fi
        echo "Wallpaper set to $filepath."
        ln -sf "$filepath" ~/.config/hypr/wallppr.png
		swww img "$filepath" --transition-fps 60 --transition-step 255 --transition-type wipe /dev/null 2>&1 & disown
		sleep 1
        echo "Wallpaper reloaded."
        ;;
    --reload|-r)
        pkill swww-deamon
		sleep 2
        swww-deamon > /dev/null 2>&1 & disown
        eww reload > /dev/null 2>&1 & disown
        echo "Wallpaper Reloaded"
        ;;
    *)
        echo "Invalid option: $1"
        echo "Usage: $0 [--set <File Location> | --reload]"
        exit 1
        ;;
esac
