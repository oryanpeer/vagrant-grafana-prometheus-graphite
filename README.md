# Grafana, Prometheus, Graphite - Vagrant Stack
Provision virtualbox machine using Vagrant
## Description
This project is Vagrant provisioning stack of monitoring tools with basic configuration and some automation.
Explanation of eaach tool can be found on the links below:
* Grafana (http://grafana.org/)
* Graphite (http://graphiteapp.org/)
* Prometheus (https://prometheus.io/)
Note: The Vagrant file is configured to run machine with 2GB of RAM and 2 CPU, edit this parameters as needs.

## Requirements
* [Git](http://git-scm.com)
* [Virtual box](https://www.virtualbox.org)
* [Vagrant](http://www.vagrantup.com)
## Installation
After installing the requirements, just clone the repo.

```
git clone https://github.com/oryanfarjon/vagrant-grafana-prometheus-graphite.git
cd vagrant-grafana-prometheus-graphite
vagrant up
```
Vagrant up command will install Grafana, Prometheus, Graphite and other dependencies on ubuntu 16.04 OS.
Prometheus is pulling metrics from node_exporter.
After successfull installation, you can visit the tools using the links below
* Grafana: http://localhost:3000
* Promethues: http://localhost:9090
* Graphite: http://localhost:8080

The installation creates additional user to the system, username:"appuser", password:"appuser".
Admin credentials for Grafana, username:"admin", password:"password".
Default dashboard is configured during the provisioning proccess and configured for the appuser.

## Ports expose
The ports are exposed from the Vagrantfile and bound to the host.
