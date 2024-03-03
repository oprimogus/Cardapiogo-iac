resource "aws_security_group" "cardapiogo_sg" {
  name        = "cardapiogo-security-group"
  description = "Security group for cardapiogo"
  vpc_id      = aws_vpc.cardapiogo_vpc.id

  # Regra de entrada: Permitir tráfego HTTP (porta 80) de qualquer IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra de entrada: Permitir tráfego SSH (porta 22) de um IP específico
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Substitua "seu_ip" pelo seu IP público
  }

  # Regra de entrada: Permitir tráfego na porta 6443 para comunicação do k3s
  ingress {
    description = "k3s server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"] # Substitua isso pelo CIDR do seu VPC ou um intervalo mais restrito
  }

  # Regra de saída: Permitir todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cardapiogo-sg"
  }
}

resource "aws_vpc" "cardapiogo_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "cardapiogo-vpc"
  }
}

resource "aws_subnet" "cardapiogo_subnet" {
  vpc_id     = aws_vpc.cardapiogo_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "sa-east-1c"

  tags = {
    Name = "Main"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.cardapiogo_vpc.id

  tags = {
    Name = "internet-gateway-cardapiogo"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.cardapiogo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "route-table-cardapiogo"
  }
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = aws_subnet.cardapiogo_subnet.id
  route_table_id = aws_route_table.route_table.id
}

output "subnet_id" {
  description = "ID da subnet"
  value       = aws_subnet.cardapiogo_subnet.id
}

output "security_group_id" {
  description = "ID da security group"
  value       = aws_security_group.cardapiogo_sg.id
}