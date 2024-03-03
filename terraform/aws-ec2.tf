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

resource "aws_instance" "manager1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = "GoldenExperience"
  vpc_security_group_ids      = [aws_security_group.cardapiogo_sg.id]
  subnet_id                   = aws_subnet.cardapiogo_subnet.id
  associate_public_ip_address = true
  user_data                   = file("../docs/scripts/SetupK3sManagerEC2.sh")
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  depends_on = [ aws_vpc.cardapiogo_vpc ]

  tags = {
    Name = "Cardapiogo-Manager1"
  }
}

output "EC2_manager_instance_ip_address" {
  description = "IP da instância manager"
  value       = aws_instance.manager1.public_ip
}

resource "aws_instance" "worker1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  key_name                    = "GoldenExperience"
  vpc_security_group_ids      = [aws_security_group.cardapiogo_sg.id]
  subnet_id                   = aws_subnet.cardapiogo_subnet.id
  associate_public_ip_address = true
  user_data                   = file("../docs/scripts/SetupK3sWorkerEC2.sh")
  user_data_replace_on_change = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  depends_on = [ aws_instance.manager1 ]

  tags = {
    Name = "Cardapiogo-Worker1"
  }
}

output "EC2_worker1_instance_ip_address" {
  description = "IP da instância worker1"
  value       = aws_instance.worker1.public_ip
}