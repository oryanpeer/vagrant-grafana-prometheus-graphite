# Update repositories
echo "Downloading Grafana Package"
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_5.2.1_amd64.deb

echo "Installing adduser && libfontconfig"
sudo apt-get install -y adduser libfontconfig

echo "Installing Grafana"
sudo dpkg -i grafana_5.2.1_amd64.deb
sudo cp templates/grafana.ini /etc/grafana/grafana.ini
sudo cp templates/basic_dashboard.json /etc/grafana/provisioning/dashboards
sudo service grafana-server start
