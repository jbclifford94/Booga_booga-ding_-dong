# AWS Terraform DevOps Stack

## Description
Simple AWS apache2 web servers running on ubuntu 20.04 being load balanced by an AWS application load balancer using the round robin algorithm. Using Terraform for deploying the infrastructure and Ansible for configuring the web servers.

## Todo next:
1. Deploy our own public VPC using terraform.
2. Fix hard coded terraform<br>
	-ec2.tf: key<br>
	-alb.tf: sg and subnets
3. Setup terraform variables
4. Use EKS to deploy an ops cluster (promtheues, alertmanager, grafana, blackbox, Jenkins, Elasticsearch, filebeats, Kibana)
5. Deploy prometheus (cAdvisor for k8s monitoring?)and/or cloudwatch monitoring.
6. Use Hashicorp Vault or Jenkins to setup secret management.
7. Setup log rotation with ELK stack
8. Setup ansible patching
9. Terraform/AWS resource discovery (possibly https://registry.terraform.io/providers/hashicorp/oci/latest/docs/guides/resource_discovery)

## Terraform
- Create a ```terraform.tfvars``` file in the same directory as all the other terraform files. Add to following to that file:

	```
	AWS_access_key_id     = "Your AWS access key"
	AWS_access_key_secret = "Your AWS key secret"
	```
- Run ```terraform init && terraform apply```
- Make sure terraform_key.pem has permission ```chmod 400 /path/to/key/terraform_key.pem```

## Ansible
- Run ```ansible-vault create cred.yml``` to create a file in the ./ansible folder. Add the following to that file:
	
	```
	access_key: [Your AWS access key. No brackets]
	secret_key: [Your AWS key secret. No brackets]
	```	
- To edit your cred.yml, run ```ansible-vault edit cred.yml```
- Check that your ```/etc/ansible/ansible.cfg``` file is using the correct key
- Check that your ```/etc/ansible/hosts``` file is using the correct IPs for your EC2 instances
- Check that your ```/path/to/playbook.yml``` file is using the correct host IPs
- To deploy your playbook run ```ansible-playbook playbook.yml --ask-vault-pass```

## Test
- Go to your load balancer's DNS name and see if it round robins
