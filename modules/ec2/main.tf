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
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_id
  key_name               = "test"
  vpc_security_group_ids = [var.security_group_id]

    root_block_device {
    volume_size = 50     # Change from 8 to 50
    volume_type = "gp3"  # or gp2
  }

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
