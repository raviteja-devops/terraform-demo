# used to connect to instance and do some job
# if we want to execute some commands locally from terraform machine

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "centos8" {
  most_recent = true
  name_regex = "Centos-8-DevOps-Practice"
  owners = ["973714476881"]
}
# we require ami, so we are using this datasource

resource "aws_instance" "web" {
  ami           = data.aws_ami.centos8.id
  instance_type = "t3.micro"

  tags = {
    Name = "test-centos8"
  }
}

resource "null_resource" "provisioner" {
  triggers = {
    instance_id = aws_instance.web.id
  }

  provisioner "remote-exec" {
    connection {
      host = aws_instance.web.public_ip
      user = "centos"
      password = "DevOps321"
    }

    inline = [
      "echo Hello"
    ]
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# If we place Provisioner part inside the instance block, it destroy and create the instance whenever the inline commands fail
# so for good practice we don't keep provisioner inside the resource
# that is why we create the 'Null Resource' which provision nothing and place provisioner inside it
# trigger is used, if any time instance is changed ID changes, if ID changes then provisioner need to rerun in new instance

# ON THE PROVISIONER THE BEST PRACTICE WHEN WE ARE CONNECTING TO THE REMOTE SYSTEM IS ALWAYS DECOUPLE THE
# PROVISIONER FROM MAIN RESOURCE, KEEP IN THE NULL RESOURCE AND CONTROL NULL RESOURCE WITH TRIGGERS
# IF ANY CHANGE ON MAIN RESOURCE SIDE, WE ASK IT TO RE-TRIGGER