echo "Preapring system for prometheus installation"

echo "Adding prometheus and node_exporter users"
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Prometheus Monitoring User" prometheus
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Node Exporter User" node_exporter

echo "Creating folders"
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus

echo "Creating dummy files"
sudo cp /vagrant/templates/prometheus/prometheus.yml /etc/prometheus/prometheus.yml

echo "Changing permissions"
sudo chown -R prometheus:prometheus /etc/prometheus
sudo chown prometheus:prometheus /var/lib/prometheus

mkdir /home/vagrant/Downloads
cd /home/vagrant/Downloads

echo "Downloading prometheus"
wget https://github.com/prometheus/prometheus/releases/download/v2.0.0/prometheus-2.0.0.linux-amd64.tar.gz
wget https://github.com/prometheus/node_exporter/releases/download/v0.15.2/node_exporter-0.15.2.linux-amd64.tar.gz

tar xvzf prometheus-2.0.0.linux-amd64.tar.gz
tar xvzf node_exporter-0.15.2.linux-amd64.tar.gz

echo "Copying files"
sudo cp prometheus-2.0.0.linux-amd64/prometheus /usr/local/bin/
sudo cp prometheus-2.0.0.linux-amd64/promtool /usr/local/bin/
sudo cp -r prometheus-2.0.0.linux-amd64/consoles /etc/prometheus
sudo cp -r prometheus-2.0.0.linux-amd64/console_libraries /etc/prometheus
sudo cp node_exporter-0.15.2.linux-amd64/node_exporter /usr/local/bin/

echo "Changing executable files owner"
sudo chown -R prometheus:prometheus /etc/prometheus/consoles
sudo chown -R prometheus:prometheus /etc/prometheus/console_libraries
sudo chown prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

echo "Copying systemd services"
sudo cp /vagrant/prometheus.service /etc/systemd/system/prometheus.service
sudo cp /vagrant/node_exporter.service /etc/systemd/system/node_exporter.service

echo "Starting prometheus service"
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

echo "Starting node_exporter service"
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter