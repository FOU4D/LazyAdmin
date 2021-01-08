#!/bin/bash

printf "=====================================\n"
printf "Adding Sudo User\n"
printf "=====================================\n\n\n"
printf "Open a terminal in your local machine\n"
printf "and run the following command:\n"
printf "# ssh-keygen\n"
printf "then, follow the instructions\n"
printf "run this command to get the content of .pub file\n"
printf "# cat ~/.ssh/id_rsa.pub\n"
printf "copy it cause you will need it\n"


read -p "Enter New Sudo User:" newsuser
sudo useradd -m -d /home/$newsuser -s /bin/bash $newsuser
sudo mkdir -p /home/$newsuser/.ssh
sudo touch /home/$newsuser/.ssh/authorized_keys

printf "Enter the contents of local pub file:\n"
read -d "~" -p "Paste the contents then comment (\"~\" when done):" upubkey
sudo echo $upubkey >> /home/$newsuser/.ssh/authorized_keys
printf "authorized_keys added succefully \n"
sudo chown -R $newsuser:$newsuser /home/$newsuser/.ssh
sudo chmod 700 /home/$newsuser/.ssh
sudo chmod 600 /home/$newsuser/.ssh/authorized_keys
printf "files and folder permissions changed succefully \n"

sudo usermod -aG sudo $newsuser
sudo echo "$newsuser	ALL=(ALL:ALL) ALL" >> /etc/sudoers
printf "user $newsuser added succefully \n"


sudo sed -ie 's/#\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
printf "disabled root login password succefully\n"

sudo service sshd reload
printf "SSHD Service Reloaded\n"


