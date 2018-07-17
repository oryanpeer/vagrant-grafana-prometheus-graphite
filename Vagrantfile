Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network "forwarded_port", guest: 9090, host: 9090
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.provider "virtualbox" do |v|
    v.name = "grafana"
    v.memory = 2048
    v.cpus = 2	
  end
  config.vm.provision :shell, path: "install_prometheus.sh"
  config.vm.provision :shell, path: "install_grafana.sh"
  config.vm.provision :shell, path: "install_graphite.sh"
end
