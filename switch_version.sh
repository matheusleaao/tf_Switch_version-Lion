#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "$0 is not running as root. Try using sudo."
    exit 2
fi

echo "Terraform Version Switcher"
printf "\n"
echo "Setting up Env..."
printf "\n"
mkdir ~/.tf_versions &> /dev/null
cd ~/.tf_versions

read -p "Go to menu? [Y/N]" yno
clear >$(tty)
printf "\n"
while [[ $yno == [yY] || $yno == [yY][eE][sS] ]]
do
    echo "Terraform Version Switcher"
    printf "\n"
    echo "Choose one option"
    echo -e "
    1 - Download Terraform [v0.12.24]
    2 - Check currently Terraform Version
    3 - Switch Version
    4 - Download new Terraform Version"
    read input

    case $input in
      1)
        wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip &> /dev/null
        rm -rf *1
        unzip terraform_0.12.24_linux_amd64.zip
        mv terraform /usr/local/bin/
        echo "Terraform 0.12.24 installed!"
        ;;
      2) 
        terraform version | grep "Terraform v"
        ;;
      3)
        echo "Switch to which TF version: " 
        ls
        read -p "(e.g.: 0.12.24) : " TFVERSION
        unzip terraform_$TFVERSION\_linux_amd64.zip &> /dev/null
        mv terraform /usr/local/bin/
        printf "\n\n"
        echo "New Terraform version"
        terraform version | grep "Terraform v"
        ;;
      4)
        printf "\n\n"
        read -p "TF version to download: (e.g.: x.xx.xx): " TFVERSIONDOWNLOAD
    	wget --no-check-certificate https://releases.hashicorp.com/terraform/$TFVERSIONDOWNLOAD/terraform_$TFVERSIONDOWNLOAD\_linux_amd64.zip
    	printf "\n\n"
        ;;
       *)
        echo -n "unknown"
        ;;
    esac
    printf "\n"
    read -p "Go to menu? [Y/N]" yno
    clear >$(tty)
    printf "\n"
done
echo "All Right! See you."
rm -rf *1
