# Cloud deployment of a simple HTTPS server with AWS, Docker, and Terraform

### Configure the AWS CLI
```aws configure
AWS Access Key ID [None]: accesskey
AWS Secret Access Key [None]: secretkey
Default region name [None]: region
Default output format [None] format
```

### Deploy VPC 
Go to ./infra_files/go_srv/network
```sh
terraform init -backend-config=network_backend_cfg.tfvars
terraform apply 
```
For destroy
```sh
terraform destroy
```

### Deploy ECR
Go to ./infra_files/go_srv/ecr
```sh
terraform init -backend-config=ecr_backend_cfg.tfvars
terraform apply 
```
For destroy
```sh
terraform destroy
```

### Deploy ECS
Go to ./infra_files/go_srv/ecs
```sh
terraform init -backend-config=ecs_backend_cfg.tfvars
terraform apply 
```
For get HTTP access to Go web server use alb_dns_name terraform output
For destroy
```sh
terraform destroy
```
Deploy automated via GitHub Actions and trigger on push to the main branch after that Docker image built and uploaded to AWS ECR and update ECS deployment

### Deploy EC2 for OpenVPN Server
Go to ./infra_files/go_srv/open_vpn_srv
```sh
terraform init -backend-config=vpnsrv_backend_cfg.tfvars
terraform apply
```
For destroy
```sh
terraform destroy
```

Use open_vpn_public_ip terraform output for connect to VPN server

### Install OpenVPN Server
Connect to EC2 via SSH
```sh
ssh -i PATH_TO_PRIVATE_KEY ubuntu@PUBLIC_EC2_IP
```
### OpenVPN Server installation
To install Access Server, use the official repository. Log in to your Linux system with root privileges, and enter these commands to add the repository and install the package 'openvpn-as'. The client bundle installs automatically.
```sh
sudo su

apt update && apt -y install ca-certificates wget net-tools gnupg

wget https://as-repository.openvpn.net/as-repo-public.asc -qO /etc/apt/trusted.gpg.d/as-repository.asc

echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/as-repository.asc] http://as-repository.openvpn.net/as/debian jammy main">/etc/apt/sources.list.d/openvpn-as-repo.list

apt update && apt -y install openvpn-as
```

After installation get and use next information for connect to OpenVPN Server UI
```sh
Access Server Web UIs are available here:
Admin  UI: https://PUBLIC_EC2_IP//:943/admin
Client UI: https://PUBLIC_EC2_IP:943/
To login please use the "openvpn" account with "some_password" password.
(password can be changed on Admin UI)
```

### OpenVPN Server configure via https://PUBLIC_EC2_IP//:943/admin
Via WEB UI go to
-> Configuration - Network Settings - and change Hostname or IP Address to PUBLIC_EC2_IP

-> Configuration - Vpn Settings - and change Dynamic IP Address Network config change to values from VPC CIDR, for example 192.168.2.0/24

-> Configuration - Routing - Specify the private subnets to which all clients should be given access (one per line) - and change value for VPC CIDR, allow access for all VPC subnets, for example 192.168.0.0/16


### Connect to OpenVPN Server
Download openVPN Connect
And use user "openvpn" account with "some_password" password