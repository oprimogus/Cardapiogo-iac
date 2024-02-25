data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "manager" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = "GoldenExperience"
  vpc_security_group_ids      = [aws_security_group.cardapiogo_sg.id]
  subnet_id                   = aws_subnet.cardapiogo_subnet.id
  associate_public_ip_address = true
  user_data                   = file("../docs/scripts/initialSetupEC2.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "Cardapiogo-Manager"
  }
}

output "manager_instance_ip_address" {
  description = "IP da instância manager"
  value       = aws_instance.manager.public_ip
}