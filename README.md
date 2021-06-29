# AWS_WebLB
Simple AWS apache2 web servers running on ubuntu 20.04 being load balanced by an AWS application load balancer using the round robin algorithm. Using Terraform for deploying the infrastructure and Ansible for configuring the web servers.


Todo next:
1. Deploy our own public VPC using terraform.
2. Fix hard coded terraform
	-ec2.tf: key
	-alb.tf: sg and subnets
3. Setup terraform variables
4. Use EKS to deploy an ops cluster (promtheues, alertmanager, grafana, blackbox, Jenkins, Elasticsearch, filebeats, Kibana)
5. Deploy prometheus and/or cloudwatch monitoring.
6. Use Hashicorp Vault or Jenkins to setup secret management.
7. Setup log rotation with ELK stack
8. Setup ansible patching
