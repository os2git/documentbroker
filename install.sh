#!/usr/bin/env bash
# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This file is part of the Magenta Document Broker.
#
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranties of
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
# PURPOSE.  See the Mozilla Public License for more details.

# This script automates the installation of the Magenta Document Broker, or rather
# - it automates it as far as possible. Ideally, you should be able to run it and
# see both server components plugged into Apache and available through a browser.

# If errors occur during the process, remove the bin/ and lib/ directories and
# start over.


if [ "$1" != "" ]; then
    BROKER_DOMAIN=$1
    # Remove trailing / from domain, if any.
    BROKER_DOMAIN=${BROKER_DOMAIN%/}
else
    BROKER_DOMAIN=document-broker.magenta-aps.dk
    echo "WARNING: No domain specified. Setup will not work unless you adjust
    the Apache configuration manually."
    echo "Usage: install.sh [<broker_domain> <template-domain>]"
    echo -n "Press ENTER to continue, CTRL-C to abort."
    read ENTER
fi


if [ "$2" != "" ]; then
    TEMPLATE_DOMAIN=$2
else
    TEMPLATE_DOMAIN=$BROKER_DOMAIN
fi

echo $TEMPLATE_DOMAIN


# Install missing dependencies if necessary
DEPENDENCIES=( python-virtualenv python-dev apache2 libapache2-mod-wsgi git fop
libxml2-dev libxslt1-dev openssl libjpeg8 libjpeg8-dev postgresql-common
libpq-dev ttf-liberation )

PKGSTOINSTALL=""

for  package in "${DEPENDENCIES[@]}"
do
    if [[ ! `dpkg -l | grep -w "ii  $package "` ]]; then
        PKGSTOINSTALL=$PKGSTOINSTALL" "$package
    fi
done

if [ "$PKGSTOINSTALL" != "" ]; then
    echo  -n "Some dependencies are missing."
    echo " The following packages will be installed: $PKGSTOINSTALL" 
    echo -n "Press ENTER to continue, CTRL-C to abort."
    read ENTER
    
    # Step 1: Check for valid APT repositories.

    sudo apt-get update &> /dev/null
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        echo "" 1>&2
        echo "ERROR: Apt repositories are not valid or cannot be reached from your network." 1>&2
        echo "Please fix and retry" 1>&2
        echo "" 1>&2
        exit -1
    else
        echo "Repositories OK: Installing packages"
    fi

    # Step 2: Do the actual installation. Abort if it fails.

    sudo apt-get -y install $PKGSTOINSTALL > install_log.txt
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        echo "" 1>&2
        echo "ERROR: Installation of dependencies failed." 1>&2
        echo "Please note that \"universe\" repository MUST be enabled" 1>&2
        echo "" 1>&2
        exit -1
    fi
fi

# Always reinstall virtualenv - make sure dependencies are checked.
rm -rf bin
echo -n "Setting up virtualenv. Press ENTER to continue, CTRL-C to abort."
read ENTER
echo "This may take a while ..."
./create_virtualenv >> install_log.txt
RETVAL=$?
if [ $RETVAL -ne 0 ]; then
    echo "Installation failed" 1>&2
    exit -1
fi

echo -n "Setting up Apache ... press ENTER to continue, CTRL-C to abort."


read ENTER

INSTALL_DIR=$PWD

# Set up the Apache server. 
# Beforehand, please update all paths in the Apache config files to reflect 
# the current installation. 
# NOTE: This needs to be automated, but as yet you will have to change these paths manually.

DB_TMP=/tmp/db_apache_install
DT_TMP=/tmp/dt_apache_install
APACHE_SITES=/etc/apache2/sites-available

cat << EOF > $DB_TMP

WSGIPythonPath $INSTALL_DIR/document_broker
WSGIPythonPath $INSTALL_DIR/lib/python2.7/site-packages


<VirtualHost *:80>
ServerName $BROKER_DOMAIN
ServerAlias *.$BROKER_DOMAIN
WSGIDaemonProcess document_broker
WSGIProcessGroup document_broker

ErrorLog /var/log/document_broker/broker/error.log
CustomLog /var/log/document_broker/broker/access.log combined

ProxyPass /document_templates http://$TEMPLATE_DOMAIN:8000/document_templates
ProxyPassReverse /document_templates http://$TEMPLATE_DOMAIN:8000/document_templates

Alias /document_broker/media $INSTALL_DIR/document_broker/site-media
<Directory $INSTALL_DIR/document_broker/site-media>
Options -Indexes
Order deny,allow
Allow from all
</Directory>

Alias /static/ /var/www/static/

WSGIScriptAlias /document_broker $INSTALL_DIR/document_broker/document_broker/wsgi.py

<Directory $INSTALL_DIR/document_broker/document_broker>
<Files wsgi.py>
Order deny,allow
Allow from all
</Files>
</Directory>

</VirtualHost>

EOF

sudo mv $DB_TMP $APACHE_SITES/document_broker

cat << EOF > $DT_TMP

WSGIPythonPath $INSTALL_DIR/document_templates
WSGIPythonPath $INSTALL_DIR/lib/python2.7/site-packages


<VirtualHost *:8000>
ServerName $TEMPLATE_DOMAIN
ServerAlias *.$TEMPLATE_DOMAIN
WSGIDaemonProcess document_templates
WSGIProcessGroup document_templates

ErrorLog /var/log/document_broker/templates/error.log
CustomLog /var/log/document_broker/templates/access.log combined

Alias /document_templates/media $INSTALL_DIR/document_templates/site-media
<Directory $INSTALL_DIR/document_templates/site-media>
Options -Indexes
Order deny,allow
Allow from all
</Directory>

Alias /static/ /var/www/static/
WSGIScriptAlias /document_templates $INSTALL_DIR/document_templates/document_templates/wsgi.py
<Directory $INSTALL_DIR/document_templates/document_templates>
<Files wsgi.py>
Order deny,allow
Allow from all
</Files>
</Directory>

</VirtualHost>

EOF

sudo mv $DT_TMP $APACHE_SITES/document_templates

# Make Apache listen on port 8000, if it doesn't already.
 if [[ ! $(netstat -tulpn 2> /dev/null | grep 8000) ]]; then 
     echo 'Listen 8000' > /tmp/listen8000; 
     sudo mv /tmp/listen8000 /etc/apache2/conf.d/
 fi

# Create Apache log files
sudo mkdir -p /var/log/document_broker/templates/
sudo mkdir -p /var/log/document_broker/broker
#sudo touch /var/log/document_broker/templates/error.log
#sudo touch /var/log/document_broker/broker/error.log
sudo chown -R www-data:www-data /var/log/document_broker/

# Now create databases, etc.
# NOTE: This will create an SQLite database. If a PostgreSQL (or MySQL) 
# database is required, these will have to be set up first and
# settings.py file changed accordingly.

echo -n "Setup succeeded so far. Press ENTER to set up database, CTRL-C to abort."
read ENTER

cd $INSTALL_DIR

# Create site-media directories if not already present

BROKER_MEDIA=document_broker/site-media
TEMPLATE_MEDIA=document_templates/site-media

mkdir -p $BROKER_MEDIA
mkdir -p $TEMPLATE_MEDIA

sudo adduser $USER www-data &> /dev/null
sudo chown -R www-data:www-data $BROKER_MEDIA
sudo chmod -R g+w $BROKER_MEDIA
sudo chown -R www-data:www-data $TEMPLATE_MEDIA
sudo chmod -R g+w $TEMPLATE_MEDIA


source bin/activate

mkdir .db &> /dev/null

cd document_templates 

echo ""
echo "NOTE: Creating template database and login user."
echo "When prompted, enter your desired login data for template administration."
python manage.py syncdb -v 0

cd ../document_broker

echo ""
echo "NOTE: Creating document broker database and login user."
echo "When prompted, enter your desired login data for document broker administration."
python manage.py syncdb -v 0

cd ..

# Now import necessary fixture data so user can upload templates right away.

cd document_broker
python manage.py loaddata fixtures/clients.json
python manage.py loaddata fixtures/clientsystem.json
python manage.py loaddata fixtures/pluginmapping.json

cd ../document_templates
python manage.py loaddata fixtures/clientsystem.json

cd ..

sudo chmod -R g+w .db
sudo chgrp -R www-data .db

sudo a2enmod proxy
sudo a2enmod proxy_http
sudo a2ensite document_broker
sudo a2ensite document_templates

# Now generate the file client/document_broker_settings.py

BROKER_SETTINGS=$INSTALL_DIR/client/document_broker_settings.py
SETTINGS_TMP=/tmp/db_settings.py

cat << EOF > $SETTINGS_TMP

# Copyright (C) 2012  Magenta ApS.
#
# Authors: Carsten Agger (carstena@magenta-aps.dk),
#          Dennis Isaksen (dennis@magenta-aps.dk),
#          Leif Lodahl (leif@magenta-aps.dk)
#
# This code may be freely reused and modified, provided this copyright notice
# is retained. See the COPYING file for details.
"""
This module contains various settings needed by the client libraries.

TODO: For the time being this is just a simple Python file where we save the
parameters on single lines as

VARIABLE = <Value>

At some later point, perhaps switch to ConfigParser format in order to have a
unified configuration format for all platforms - dependent on how much
configuration we're going to actually need.
"""

BROKER_BASE_URL = 'http://$BROKER_DOMAIN/document_broker'
BROKER_URL = (BROKER_BASE_URL + '/broker-xml/')

TEMPLATE_BASE_URL = 'http://$TEMPLATE_DOMAIN/document_templates'
TEMPLATE_URL = (TEMPLATE_BASE_URL + '/template-xml/')
CLIENT_ID = 'c9bf43ad-91ee-4706-a4de-4df3d53b45ef'
CLIENT_PASSWORD = "e13e9b0214aea8138b81ade09989db159af80237"

# SSL client certificate settings. If SSL_DO_USE is set, the following two
# parameters MUST be set, and must point to a valid certificate.
# In this version, the certificate  and key files are just meant as examples.
SSL_DO_USE = False
(SSL_CERT_FILE, SSL_KEY_FILE) = (
    '$INSTALL_DIR/client/' +
        '.ssl_keyfiles/553b6807-851d-4b76-a4c1-3f683fc20de3.crt',
            '$INSTALL_DIR/client/' +
            '.ssl_keyfiles/553b6807-851d-4b76-a4c1-3f683fc20de3.key')

EOF

mv  $SETTINGS_TMP $BROKER_SETTINGS

# Link static content.
sudo rm -f /var/www/static
sudo ln -s $INSTALL_DIR/lib/python2.7/site-packages/django/contrib/admin/static/ /var/www/static

sudo service apache2 restart

echo "Installation complete and (as far as I can tell) successful."
echo ""
echo "Please verify component sites exist and can be accessed."
echo ""

echo "Access the templates broker admin site via:

http://$BROKER_DOMAIN/document_broker/admin/

Access the templates admin site via:
http://$BROKER_DOMAIN/document_templates/admin/

Access the demo site via:
http://$BROKER_DOMAIN/document_broker/demo/"

echo ""

# end

