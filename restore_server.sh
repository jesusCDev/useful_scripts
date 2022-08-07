#! /bin/bash

# * Create Bestcef Account and switch to it
function create_bestcef_account(){
    {
        sudo adduser bestcef
        su - bestcef
    } || {
        echo "User Already Exist"
    }
}


# * Download Backup Files
function download_backup_files() {
    {
        USERNAME="${2}"
        PASSWORD="${3}"
        URL="${4}"
        DATE_VALUE="${5}"

        # * #######################################################################################
        # * Setup Backup Directores
        mkdir ~/server_backup_files
        cd ~/server_backup_files


        # * #######################################################################################
        # * Download backups
        wget "ftp://${USERNAME}:${PASSWORD}@${URL}/newserver_bestcef1_backups/bestcef1_backup_daily_${DATE_VALUE}.tar.gzip"
        
        # ? cronjobs
        # ? backup schedules
        # ? PHP - File Changes
        wget "ftp://${USERNAME}:${PASSWORD}@${URL}/newserver_bestcef1_backups/config-${DATE_VALUE}.tar.gzip"

        wget "ftp://${USERNAME}:${PASSWORD}@${URL}/newserver_bestcef1_backups/bestcef_db-${DATE_VALUE}.sql"
        wget "ftp://${USERNAME}:${PASSWORD}@${URL}/newserver_bestcef1_backups/mysql-${DATE_VALUE}.sql"
        wget "ftp://${USERNAME}:${PASSWORD}@${URL}/newserver_bestcef1_backups/phpmyadmin-${DATE_VALUE}.sql"

        
        # * #######################################################################################
        # * Setup Database
        # ? Might have to install Mariadb First through webmin modules (might come pre-loaded by contabo)
        mysql bestcef_db < "~/server_backup_files/bestcef_db-${DATE_VALUE}.sql"

        # ! TEST (What are they for?)
        mysql bestcef_db < "~/server_backup_files/mysql-${DATE_VALUE}.sql"
        mysql bestcef_db < "~/server_backup_files/phpmyadmin-${DATE_VALUE}.sql"


        # * #######################################################################################
        # * Setup FileSystem
        cd "/var/www/html/"
        tar -xvf "~/server_backup_files/bestcef1_backup_daily_${DATE_VALUE}.tar.gzip" "."

    } || {
        echo "Error"
    }
}


function setup_apache (){
    sudo apt update
    sudo apt install apache2 apache2-doc apache2-utils
}

# * #######################################################################################
# * Install Dependencies
# Google Chrome (working driver) (.deb & driver) - should be in cloudtb
# MariaDB
# Python3
function install_dependencies(){
    pip3 install selenium
    pip3 install yahoo_finance
    pip3 install beautifulsoup
}

echo "Webmin Config - File Must Restored Through Webmin."
echo "Webmin Config - File Must Set the Modules to restore."

echo "Webmin - Install mariadb through webmin modules."
echo "Webmin - Manually Setup Postfix."