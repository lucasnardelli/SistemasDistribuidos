provider "aws" {
  region = "us-east-2"
}

resource "aws_key_pair" "k8s-key" {
  key_name   = "k8s-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXNUTV/EQ+jkrB6f+N697uKpMPvR3cJ0my7Oweh8zPVLV5CEHSfn/dWjIg0FJpvuOAxRdrUNPHNpP4xJu3pFdDWQtLZXjfga16tAB8YWFtlap9sNET3XwfzwhaqaaAWyYiBu+idbQLTu0Mo5GHzxENOaJPCOXTBj9yED1DGUqVyNAVSIRUob636rpy3Tu4XTd3ZDwnDWFSq82hZRYHyeQKsTJnJcmfw8yoGRv4we9q1xluKsBez0MUjK9v4OOaqh8wwDgM/qtej5YBIdkHcUnfiMJH3bGaymPtoUvN/Rb7nJXMVhXIiP230WoatgyAVcMemvJ8y4EIITc0xccR+Jys1N6JnCZxLk9h0BlV2QWPnsiJlIRm3hvujo86DFtCpEHGDC7OnL8UnXcWMr4EaSkJ4Fk89vuErIN/smdTIbCKjWidALqd6aCE1hv/N8uNzRmmJkP9ibak+XdPpDA7Up/Foszeu0D9bLEeLwckJlPLvEXDc0ocTYB9RIon4HMc0y8= nrd@nrd"
}

resource "aws_security_group" "k8s-sg" {
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = true
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

} 

resource "aws_instance" "kubernetes-worker" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t3.medium"
  key_name = "k8s-key"
  count = 2
  tags = {
    name = "k8s"
    type = "worker"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}

resource "aws_instance" "kubernetes-master" {
  ami           = "ami-024e6efaf93d85776"
  instance_type = "t3.medium"
  key_name = "k8s-key"
  count = 1
  tags = {
    name = "k8s"
    type = "master"
  }
  security_groups = ["${aws_security_group.k8s-sg.name}"]
}

