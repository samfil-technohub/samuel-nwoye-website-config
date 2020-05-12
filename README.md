## Documentation
---
Running the Playbook
---
- ansible-playbook -i hosts.aws_ec2.yml server.yml -u ubuntu
- packer build -var-file=server-vars.json server-ami.json

Server Specification Testing
---
cd serverspec && rake -v -t
