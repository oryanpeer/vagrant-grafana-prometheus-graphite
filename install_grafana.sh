# Update repositories
echo "Downloading Grafana Package"
wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_5.2.1_amd64.deb

echo "Installing adduser && libfontconfig"
sudo apt-get install -y adduser libfontconfig

echo "Installing Grafana"
sudo dpkg -i grafana_5.2.1_amd64.deb
sudo cp /vagrant/templates/grafana/prometheus_datasource.yaml /etc/grafana/provisioning/datasources/prometheus_datasource.yaml
sudo cp /vagrant/templates/grafana/dashboards.yml /etc/grafana/provisioning/dashboards/dasboards.yml
mkdir -p /var/lib/grafana/dashboards
sudo cp /vagrant/templates/grafana/basic_dashboard.json /var/lib/grafana/dashboards/basic_dashboard.json
sudo service grafana-server start
sudo systemctl enable grafana-server.service
sleep 2
### Reset admin password
curl -uadmin:admin -X PUT -H "Content-Type: application/json" -d '{
  "oldPassword": "admin",
  "newPassword": "password",
  "confirmNew": "password"
}' http://localhost:3000/api/user/password

### Create New User
curl -uadmin:password -X POST -H "Content-Type: application/json" -d '{
  "name":"appuser",
  "email":"appuser@example.com",
  "login":"appuser",
  "password":"appuser",
  "homeDashboardId":1
}' http://localhost:3000/api/admin/users
### Update Home Dashboard
curl -uappuser:appuser -X PUT -H "Content-Type: application/json" -d '{
  "theme": "",
  "homeDashboardId":1,
  "timezone":"utc"
}' http://localhost:3000/api/user/preferences

