#!/bin/bash

# Atualiza e instala dependências necessárias
echo "Atualizando e instalando dependências..."
apt-get update
apt-get install -y ca-certificates curl awscli

# Configuração do Docker
echo "1. Iniciando instalação do Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Docker instalado com sucesso."

# Preparação para o join no cluster k3s
echo "2. Preparando para se juntar ao cluster k3s..."
mkdir -p /home/ubuntu/k3s

# Baixar o comando de join do S3
echo "Baixando comando de join do S3..."
aws s3 cp s3://oprimogus-k3s/k3s_config.txt /home/ubuntu/k3s/k3s_config.txt

# Desativar UFW
ufw disable

# Executar o comando de join
echo "Executando o comando de join..."
bash -c "$(cat /home/ubuntu/k3s/k3s_config.txt)"

echo "Node worker configurado e unido ao cluster com sucesso."