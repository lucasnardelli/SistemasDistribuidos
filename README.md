# SistemasDistribuidos
Projeto desenvolvido para a matéria de sistemas distribuídos na UFV-CRP

Pré-requisitos: 
  - Conta na AWS
  - Terraform
  - Ansible

Comece clonando o presente repositório ```git clone https://github.com/lucasnardelli/SistemasDistribuidos```

Em seguida é necessário fazer algumas modificações nos códigos em relação à configuração da AWS

No código do arquivo main.tf altere a região para a definida no seu AWS:

```
provider "aws" {
  region = "us-east-2"
}
```

Insira a sua public key ssh

```
resource "aws_key_pair" "k8s-key" {
  key_name   = "k8s-key"
  public_key = ""
}
```

Em seguida altere o ami para a versão correta do ubuntu e região em que deseja utilizar

Agora na AWS é preciso criar um Bucket S3 e alterar o nome no arquivo backend.tf

Passo a passo para instânciar e criar um cluster Kubernetes (execute os comandos com o terminal na pasta do projeto):

```terraform init```
```terraform plan```
```terraform apply -auto-approve```
```./ec2.py --list```
```ansible-playbook -u ubuntu -i ec2.py site.yml```

