#! /bin/bash


###### Retreive Webin File Name
# https://www.webmin.com/download.html


function tar_mode(){
# webmin-1.997
wget "https://prdownloads.sourceforge.net/webadmin/${WEBMIN_ID}.tar.gz"


######## Setup Webmin
sudo apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python
tar -xzvf "${WEBMIN_ID}.tar.gz"
cd "${WEBMIN_ID}/"

sudo sh setup.sh
}

# Simpler and less setup (uses defatul settings) (username / password) = account_info
function install_deb(){
	wget "https://prdownloads.sourceforge.net/webadmin/${WEBMIN_ID}.deb"
	sudo apt install "${WEBMIN_PACKAGE_ID}"
	sudo apt install -f
}


##################################################################################
WEBMIN_PACKAGE_ID="${2}"
MODE="${1}"

if [MODE=="--deb"]; then
	install_deb
else if [MODE=="--tar"]; then
	install_tar
else
	echo "First value must be --deb or --tar"
	echo "Second value must be the package ID"
	echo "Goto https://www.webmin.com/download.html"
fi
