#!/bin/bash
PREREQ='swaks'

#check for prerequisite mailer package
if [ $(dpkg-query -W -f='${Status}' $PREREQ 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install $PREREQ -y;
fi

#capture environment variables user input and set
echo "Enter the default TO: address"
read RAMBLE_SMTP_TO
echo "Enter an alternate TO: email address"
read RAMBLE_ALT_SMTP_TO
echo "Enter the full SMTP username (ie. your_user@gmail.com) :"
read RAMBLE_SMTP_USER
echo "Enter the password :"
read RAMBLE_SMTP_PW

#set for the current session (see if this is necessary)
export RAMBLE_SMTP_USER=$RAMBLE_SMTP_USER
export RAMBLE_SMTP_PW=$RAMBLE_SMTP_PW
export RAMBLE_SMTP_TO=$RAMBLE_SMTP_TO
#Check for existance of env variable in /etc/environment and fix if necessary
grep -q -F 'RAMBLE_SMTP_USER' /etc/environment || echo "RAMBLE_SMTP_USER=$RAMBLE_SMTP_USER" >> /etc/environment
grep -q -F 'RAMBLE_SMTP_PW' /etc/environment || echo "RAMBLE_SMTP_PW=$RAMBLE_SMTP_PW" >> /etc/environment
grep -q -F 'RAMBLE_SMTP_TO' /etc/environment || echo "RAMBLE_SMTP_TO=$RAMBLE_SMTP_TO" >> /etc/environment
