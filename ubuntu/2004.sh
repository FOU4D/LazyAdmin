#!/bin/bash

# Initial Setup for ubuntu 20.04 server
# chmod +x 2004.sh
# .*/2004.sh
# checking if you have root privilage


printf "=====================================\n"
printf "Prerequisite: Root Privilage\n"
printf "=====================================\n"

if [ "$(id -un)" != "root" ]; then
    echo "Need root - sudoing..."
    exec sudo "$0" "$@"
fi
printf "SUCCESS!: You Are Root, You can proceed\n"

sudo mkdir -p /var/log/LazyAdmin
sudo touch /var/log/LazyAdmin/ubuntu.log
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/var/log/LazyAdmin/ubuntu.log 2>&1

printf "all log files will be located under /var/log/LazyAdmin/ubuntu.log"
my_dir="$(dirname "$0")"

printf "Please enter your choice: "
options=("Update System" "Secure SSH" "Add Sudoer User" "Change Time Zone" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Update System")
            source $my_dir/FirstSteps/update.sh
            ;;
        "Secure SSH")
            source $my_dir/FirstSteps/sshd.sh
            ;;
        "Add Sudoer User")
            source $my_dir/FirstSteps/sudoer.sh
            ;;
        "Change Time Zone")
            source $my_dir/FirstSteps/timezone.sh
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done