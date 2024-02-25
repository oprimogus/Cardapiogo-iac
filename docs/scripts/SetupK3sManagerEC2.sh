#!/bin/bash

# Atualiza e instala dependências necessárias
echo "Atualizando e instalando dependências..."
apt-get update
apt-get install -y ca-certificates curl awscli

# Configuração do Docker
echo "1. Iniciando instalação do Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Docker instalado com sucesso."

# Instalação do k3s
echo "2. Iniciando instalação do k3s..."
curl -sfL https://get.k3s.io | sh -
echo "k3s instalado com sucesso."

# Configurações adicionais
echo "3. Configurando informações relevantes..."
mkdir -p /home/ubuntu/info

# Obtem o IP Interno e o Token do k3s
IP_INTERNO=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
K3S_TOKEN=$(cat /var/lib/rancher/k3s/server/token)

# Gera o comando de join e salva localmente
echo "Gerando comando de join do k3s..."
COMANDO_JOIN="curl -sfL https://get.k3s.io | K3S_URL=https://${IP_INTERNO}:6443 K3S_TOKEN=${K3S_TOKEN} sh -"
echo $COMANDO_JOIN > /home/ubuntu/info/k3s_config.txt

# Upload do comando de join para o S3
echo "Enviando comando de join para o S3..."
aws s3 cp /home/ubuntu/info/k3s_config.txt s3://oprimogus-k3s/k3s_config.txt

# Desativar UFW
ufw disable

echo "Configuração concluída."