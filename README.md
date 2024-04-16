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
```terraform init -backend-config=network_backend_cfg.tfvars
terraform apply 
```

### Deploy EC2 for OpenVPN Server
Go to ./infra_files/go_srv/open_vpn_srv
```terraform init -backend-config=vpnsrv_backend_cfg.tfvars
terraform apply
```
### Install OpenVPN Server
Connect to EC2 via SSH
```ssh -i PATH_TO_PRIVATE_KEY ubuntu@PUBLIC_EC2_IP```
```terraform init -backend-config=vpnsrv_backend_cfg.tfvars
terraform apply
```