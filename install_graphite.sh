sudo apt-get update
echo "graphite-carbon graphite-carbon/postrm_remove_databases boolean false" | sudo debconf-set-selections
sudo apt-get install graphite-carbon graphite-web -y
sudo apt-get install postgresql libpq-dev python-psycopg2 -y
sudo -u postgres psql -c "CREATE USER graphite WITH PASSWORD 'graphite';"
sudo -u postgres psql -c "CREATE DATABASE graphite WITH OWNER graphite;"
sudo graphite-manage migrate auth
sudo graphite-manage syncdb --noinput
sudo chown _graphite:_graphite /var/lib/graphite -R
sudo sed 's/CARBON_CACHE_ENABLED=false/CARBON_CACHE_ENABLED=true/' -i /etc/default/graphite-carbon
sudo sed 's/ENABLE_LOGROTATION = False/ENABLE_LOGROTATION = True/' -i /etc/carbon/carbon.conf
cat >> /etc/carbon/storage-schemas.conf <<EOL 

[test]
pattern = ^test\.
retentions = 6s:4h,1m:1d
EOL

sudo cp /usr/share/doc/graphite-carbon/examples/storage-aggregation.conf.example /etc/carbon/storage-aggregation.conf
sudo apt-get install apache2 libapache2-mod-wsgi -y
sudo cp /usr/share/graphite-web/apache2-graphite.conf /etc/apache2/sites-available/
sudo echo "Listen 8080" >> /etc/apache2/ports.conf

sudo a2dissite 000-default
sudo a2ensite apache2-graphite
sed 's/:80/:8080/' -i /etc/apache2/sites-enabled/apache2-graphite.conf

service apache2 restart
