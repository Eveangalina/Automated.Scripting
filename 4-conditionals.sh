#!/bin/bash

while true; do
  echo "Menu:"
  PS3="Enter your choice (1-4): "
  options=("Hello world" "Ping self" "IP info" "Exit")
  select opt in "${options[@]}"; do
    case $REPLY in
      1)
        echo "Hello world!"
        break
        ;;
      2)
        ping -c 4 127.0.0.1
        break
        ;;
      3)
        ifconfig
        break
        ;;
      4)
        echo "Exiting the program. Goodbye!"
        exit 0
        ;;
      *)
        echo "Invalid choice. Please enter a number between 1 and 4."
        break
        ;;
    esac
  done
  echo
done
