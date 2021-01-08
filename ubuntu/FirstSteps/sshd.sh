#!/bin/bash

printf "=====================================\n"
printf "Securing SSH\n"
printf "=====================================\n"

sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
printf "old sshd_config backup succefully\n"



idefsport = 43210
printf "The default SSH new port will be 43210\n"
read -p "Enter New SSH Port in range 1024:65535:" newport
newport=${newport:-43210}
sed -ie "s/#\?Port.*/Port $newport/" /etc/ssh/sshd_config
printf "default port changed succefully to $newport\n"




sed -ie 's/#\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
printf "disabled password login\n"


sed -ie 's/#\?PermitEmptyPasswords.*/PermitEmptyPasswords no/' /etc/ssh/sshd_config
printf "disabled empty password login\n"



sed -ie 's/#\?ClientAliveInterval.*/ClientAliveInterval 180/' /etc/ssh/sshd_config
printf "Connection Timeout Idle Value to 180 Seconds\n"

sed -ie 's/#\?MaxAuthTries.*/MaxAuthTries 3/' /etc/ssh/sshd_config
printf "Limit for Password Attempts: 3 Attempts\n"

sed -ie 's/#\?LoginGraceTime.*/LoginGraceTime 20/' /etc/ssh/sshd_config
printf "reduced login grace period to 20 Seconds\n"

sed -ie 's/#\?ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
printf "Challenge Response Authentication disabled\n"

sed -ie 's/#\?KerberosAuthentication.*/KerberosAuthentication no/' /etc/ssh/sshd_config
printf "Kerberos Authentication disabled\n"

sed -ie 's/#\?GSSAPIAuthentication.*/GSSAPIAuthentication no/' /etc/ssh/sshd_config
printf "GSSAPI Authentication disabled\n"

sed -ie 's/#\?X11Forwarding.*/X11Forwarding no/' /etc/ssh/sshd_config
printf "X11 forwarding disabled\n"

sed -ie 's/#\?PermitUserEnvironment.*/PermitUserEnvironment no/' /etc/ssh/sshd_config
printf "passing custom environment variables disabled\n"

sed -ie 's/#\?AllowAgentForwarding.*/AllowAgentForwarding no/' /etc/ssh/sshd_config
printf "Allow Agent Forwarding disabled\n"

sed -ie 's/#\?AllowTcpForwarding.*/AllowTcpForwarding no/' /etc/ssh/sshd_config
printf "Allow Tcp Forwarding disabled\n"

sed -ie 's/#\?PermitTunnel.*/PermitTunnel no/' /etc/ssh/sshd_config
printf "Permit Tunnel disabled\n"

sed -ie 's/#\?IgnoreRhosts.*/IgnoreRhosts yes/' /etc/ssh/sshd_config
printf "Ignoring Rhosts\n"

sed -ie 's/#\?Banner.*/Banner no/' /etc/ssh/sshd_config
printf "Debian Banner disabled\n"

echo "Protocol 2" >> /etc/ssh/sshd_config
printf "changed to protocol 2\n"

sudo service sshd reload
printf "SSHD Service Reloaded\n"
