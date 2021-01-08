#!/bin/bash

printf "=====================================\n"
printf "Changing Time Zone\n"
printf "=====================================\n"
deftz = "UTC"
printf "The default Time Zone Will Be: UTC\n"
printf "you can change it, Example:\n"
printf "Africa/Cairo America/New_York Asia/Dubai\n"
read -p "Enter New Time Zone: \n" newtz
newtz=${newtz:-UTC}
sudo timedatectl set-timezone $newtz
printf "Server Time Zone changed to $newtz\n"

