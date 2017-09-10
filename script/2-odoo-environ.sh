echo -e "\n---- Proses ini akan memakan waktu sekitar 9.44 - 10.15 31 menit ----"


OE_USER="odoo"
OE_HOME="/opt/$OE_USER"
OE_HOME_EXT="/opt/$OE_USER/$OE_USER-server"
# Replace for openerp-gevent for enabling gevent mode for chat
OE_SERVERTYPE="openerp-server"

#Enter version for checkout "7.0" for version 7.0, "saas-4, saas-5 (opendays version) and "master" for trunk
OE_VERSION="8.0"

#set the superadmin password
OE_SUPERADMIN="admin"
OE_CONFIG="$OE_USER-server"

#--------------------------------------------------
# Set Locale en_US.UTF-8
#--------------------------------------------------
echo -e "\n---- Set en_US.UTF-8 Locale ----"
sudo cp /etc/default/locale /etc/default/locale.BACKUP
sudo rm -rf /etc/default/locale
echo -e "* Change server config file"
sudo su root -c "echo 'LC_ALL="en_US.UTF-8"' >> /etc/default/locale"
sudo su root -c "echo 'LANG="en_US.UTF-8"' >> /etc/default/locale"
sudo su root -c "echo 'LANGUAGE="en_US:en"' >> /etc/default/locale"

#--------------------------------------------------
# Install PostgreSQL Server
#--------------------------------------------------
echo -e "\n---- Install PostgreSQL Server ----"
sudo apt-get install postgresql -y

echo -e "\n---- PostgreSQL $PG_VERSION Settings  ----"
sudo sed -i s/"#listen_addresses = 'localhost'"/"listen_addresses = '*'"/g /etc/postgresql/9.3/main/postgresql.conf

echo -e "\n---- Creating the ODOO PostgreSQL User  ----"
sudo su - postgres -c "createuser -s $OE_USER" 2> /dev/null || true

#--------------------------------------------------
# Update Server
#--------------------------------------------------
echo -e "\n---- Update Server ----"
sudo apt-get upgrade -y
sudo apt-get update -y

#--------------------------------------------------
# Install SSH
#--------------------------------------------------
echo -e "\n---- Install SSH Server ----"
sudo apt-get install ssh -y

#--------------------------------------------------
# Install Dependencies
#--------------------------------------------------
echo -e "\n---- Install tool packages ----"
sudo apt-get install wget subversion git bzr bzrtools python-pip -y

echo -e "\n---- Install and Upgrade pip and virtualenv ----"
sudo apt-get install python-dev build-essential -y
sudo pip install --upgrade pip
sudo pip install --upgrade virtualenv
echo -e "\n---- Install pyserial and qrcode for compatibility with hw_ modules for peripheral support in Odoo ---"
sudo pip install pyserial qrcode pytz jcconv
sudo apt-get -f install -y

echo -e "\n---- Install pyusb 1.0+ not stable for compatibility with hw_escpos for receipt printer and cash drawer support in Odoo ---"
sudo pip install --pre pyusb

echo -e "\n---- Install python packages ----"
sudo apt-get install -y --force-yes --no-install-recommends python-gevent python-dateutil python-feedparser python-gdata python-ldap python-libxslt1 python-lxml python-mako python-openid python-psycopg2 python-pybabel python-pychart python-pydot python-pyparsing python-reportlab python-simplejson python-tz python-vatnumber python-vobject python-webdav python-werkzeug python-xlwt python-yaml python-zsi python-docutils python-psutil python-mock python-unittest2 python-jinja2 python-pypdf python-pdftools python-setuptools python-pybabel python-imaging python-matplotlib python-reportlab-accel python-openssl python-egenix-mxdatetime python-paramiko antiword python-decorator poppler-utils python-requests libpq-dev python-geoip python-markupsafe postgresql-client python-passlib vim libreoffice curl openssh-server npm python-cairo python-genshi libreoffice-script-provider-python ghostscript




echo -e "\n---- Proses ini akan memakan waktu sekitar 10.15 - xx menit ----"


# Install NodeJS and Less compiler needed by Odoo 8 Website - added from https://gist.github.com/rm-jamotion/d61bc6525f5b76245b50
sudo curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install nodejs -y
npm install less -y

echo -e "\n---- Install python libraries ----"
sudo pip install gdata
sudo pip install passlib
sudo pip install unidecode

echo -e "\n---- Install Other Dependencies ----"
sudo pip install graphviz mc bzr lptools make
sudo pip install gevent gevent_psycopg2 psycogreen


echo -e "\n---- Install Wkhtmltopdf 0.12.1 ----"
# sudo wget -P Downloads http://download.gna.org/wkhtmltopdf/0.12/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb
# sudo dpkg -i wkhtmltox-0.12.1_linux-trusty-amd64.deb
# sudo cp /usr/local/bin/wkhtmltopdf /usr/bin
# sudo cp /usr/local/bin/wkhtmltoimage /usr/bin
cd ~
sudo wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.0/wkhtmltox-linux-i386_0.12.0-03c001d.tar.xz
sudo tar -xvf wkhtmltox-linux-i386_0.12.0-03c001d.tar.xz
cd wkhtmltox/bin/
sudo mv wkhtmltopdf /usr/bin/wkhtmltopdf

echo -e "\n---- Create ODOO system user ----"
sudo adduser --system --quiet --shell=/bin/bash --home=$OE_HOME --gecos 'ODOO' --group $OE_USER

echo -e "\n---- Create Log directory ----"
sudo mkdir /var/log/$OE_USER
sudo chown $OE_USER:$OE_USER /var/log/$OE_USER
