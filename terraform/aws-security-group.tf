resource "aws_security_group" "cardapiogo_sg" {
  name        = "cardapiogo-security-group"
  description = "Security group for cardapiopgo"

  # Regra de entrada: Permitir tráfego HTTP (porta 80) de qualquer IP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Regra de entrada: Permitir tráfego SSH (porta 22) de um IP específico
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Substitua "seu_ip" pelo seu IP público
  }

  # Regra de saída: Permitir todo o tráfego de saída
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cardapiogo"
  }
}