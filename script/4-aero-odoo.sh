echo -e "\n---- Proses ini akan memakan waktu sekitar 10.28 - 10.30 2 menit ----"

# Install Aeroo Reports:
echo -e "\n---- Install Aeroo Reports Odoo Modules: ----"

cd /opt/odoo/custom
sudo git clone -b master https://github.com/aeroo/aeroo_reports.git
sudo ln -s /opt/odoo/custom/aeroo_reports/* /opt/odoo/custom/addons/
