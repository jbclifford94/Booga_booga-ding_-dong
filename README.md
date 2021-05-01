# AWS_WebLB
Simple AWS apache2 web servers running on ubuntu 20.04 being load balanced by an AWS application load balancer using the round robin algorithm. Using Terraform for deploying the infrastructure and Ansible for configuring the web servers.


Todo next:
1. Deploy our own public VPC using terraform.
2. Use EKS to deploy an ops cluster (promtheues, alertmanager, grafana, blackbox, Jenkins, Elasticsearch, filebeats, Kibana)
3. Deploy prometheus and/or cloudwatch monitoring.
4. Use Hashicorp Vault or Jenkins to setup secret management.
5. Setup log rotation with ELK stack
