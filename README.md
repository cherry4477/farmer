# Farmer

Farmer is a simple PaaS wrapped around `docker-compose` to create, deploy and manage small projects.

## Installation
As simple as running docker compose and passing a root password for your MySql server.
```sh
export DATABASE_ROOT_PASSWORD=yourRandomRootPassword
toolbelt pod deploy farmer
```

If you want to run a Farmer instance on a remote docker engine you need to configure docker compose using environment variables.

## Usage
To talk to a farmer instance you need to run `docker-compose`. (If your docker engine is on a remote server you need to set appropriate environment variables)

## Security
To protect some internal services such as **Logger**, **etcd**, etc; you have to protect their open ports.
```sh
sudo iptables -A INPUT -p tcp --dport 8000 -s <YOUR_DEV_IP_OR_SUBNET> -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 5601 -s <YOUR_DEV_IP_OR_SUBNET> -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2379 -s <YOUR_DEV_IP_OR_SUBNET> -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8000 -s 172.17.0.0/16 -j ACCEPT # So that other containers can see these ports.
sudo iptables -A INPUT -p tcp --dport 5601 -s 172.17.0.0/16 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 2379 -s 172.17.0.0/16 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 8000 -j DROP # Deny for everyone else.
sudo iptables -A INPUT -p tcp --dport 5601 -j DROP
sudo iptables -A INPUT -p tcp --dport 2379 -j DROP
```

## Features
* **NGINX Load Balancer** to handle http and/or https traffic.
* **Elasicsearch + Kibana** to provide logging service to containers.
* **Domain Management** with etcd and registrator for your web containers.
* **MySql Service Broker** for offering lightweight MySql contaienrs to all your projects.
