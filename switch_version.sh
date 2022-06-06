#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "$0 is not running as root. Try using sudo."
    exit 2
fi

printf "Downloading most used terraform versions in ~/.tf_versions\n\n"




#mkdir ~/.tf_versions && cd ~/.tf_versions
mkdir tf_versions &> /dev/null

cd tf_versions
#choose version

wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip &> /dev/null
wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip &> /dev/nul
rm -rf *1

echo "Currently Terraform version"
terraform version | grep "Terraform v"
printf "\n\n"

echo "Switch to what TF version: " 
ls
read -p "(e.g.: 0.12.24) : " TFVERSION



unzip terraform_$TFVERSION\_linux_amd64.zip &> /dev/null
mv terraform /usr/local/bin/

printf "\n\n"

echo "New Terraform version"
terraform version | grep "Terraform v"
printf "\n\n"

echo "Do you wanna download more terraform versions? [Y,n]"
read input
if [[ $input == [yY] || $input == [yY][eE][sS] ]]; then

        read -p "TF version to download: (e.g.: x.xx.xx): " TFVERSIONDOWNLOAD
	wget https://releases.hashicorp.com/terraform/$TFVERSIONDOWNLOAD/terraform_$TFVERSIONDOWNLOAD\_linux_amd64.zip
	printf "\n\n"
	echo "See you!"
else
        echo "All Right! See you."
fi

rm -rf *1
