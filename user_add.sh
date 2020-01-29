#!/bin/sh

if [[ `id -u` != 0 ]]; then
    echo "Must be root to run script"
    exit
fi

read -p "Enter user name and press [ENTER]: " UserName

if [[ $UserName == `dscl . -list /Users UniqueID | awk '{print $1}' | grep -w $UserName` ]]; then
    echo "User already exists!"
    exit 0
fi

PrimaryGroupID=5000
UserID=4000

. /etc/rc.common

dscl . create /Users/$UserName

echo " "
read -s -p "Enter $UserName User Password and press [ENTER]: " UserPassword
echo " "
read -s -p "Enter $UserName User Password again and press [ENTER]: " UserPasswordRepeat
if [[ $UserPassword == $UserPasswordRepeat ]]; then
  dscl . passwd /Users/$UserName $UserPassword
  UserPassword=0
else
  echo "Passwords do not match!"
  exit 1
fi

echo " "
dscl . create /Users/$UserName UniqueID $UserID
dscl . create /Users/$UserName PrimaryGroupID $PrimaryGroupID
dscl . create /Users/$UserName UserShell /bin/bash
dscl . create /Users/$UserName NFSHomeDirectory /Users/$UserName
createhomedir -u $UserName -c

echo "$UserName  ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$UserName

echo "New user $UserName has been created with UserID $UserID and PrimaryGroupID $PrimaryGroupID"
