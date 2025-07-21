data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id
  key_name               = "test"
  vpc_security_group_ids = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              sudo apt install -y python3 python3-pip
              sudo apt install -y docker.io
              systemctl start docker
              systemctl enable docker
              sudo usermod -aG docker $USER
              newgrp docker
              docker ps
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx


              echo "Hello from Terraform EC2" > /var/www/html/index.html
              EOF

  tags = {
    Name      = "AppServer"
    Terraform = "true"
  }
}

resource "aws_eip" "app_eip" {
  instance = aws_instance.app.id
}

output "public_ip" {
  value = aws_eip.app_eip.public_ip
}

output "instance_id" {
  value = aws_instance.app.id
}
