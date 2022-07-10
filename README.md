# devops-05

### Pre-requisites
- Install terraform https://www.terraform.io/downloads
- Install ansible https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html
- AWS account https://aws.amazon.com/

### Terraform

```
cd terraform/

# Init
terraform init

# Check before applying
terraform plan

# Apply
terraform apply
```

### Ansible
```
cd ansible/

# Check before applying
ansible-playbook playbooks/web.yml --check

# Apply
ansible-playbook playbooks/web.yml --diff
```
