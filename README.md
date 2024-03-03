# Cardapiogo-IAC

## Sobre o Projeto

O `Cardapiogo-IAC` é um repositório destinado à configuração e gerenciamento da infraestrutura utilizada pelo Cardapiogo. Este repositório emprega Terraform para provisionamento de infraestrutura, configurado exclusivamente para AWS, e inclui scripts específicos para diferentes tipos de máquinas dentro do cluster (manager e workers).

## Pré-requisitos

Antes de iniciar, certifique-se de que você tem os seguintes requisitos instalados e configurados:

- Terraform (versão especificada, se aplicável)

## Configuração Inicial

Para configurar o seu ambiente para trabalhar com o `Cardapiogo-IAC`, siga os passos abaixo:

1. Clone o repositório para a sua máquina local:

2. Navegue até o diretório do projeto:

## Deploy da Infraestrutura

Para realizar o deploy da infraestrutura, utilizamos um processo automatizado com o GitHub Actions:

1. **Validação da Infraestrutura**: Ao fazer um pull request, a ação 'Validate Infrastructure' é acionada, validando o plano gerado pelo Terraform.
2. **Aplicação da Infraestrutura**: Para aplicar as mudanças de infraestrutura (apply) ou destruir a infraestrutura existente (destroy), é necessário executar manualmente a ação 'Apply or Destroy infrastructure' no GitHub, informando 'apply' ou 'destroy' como argumento.

## Segurança

- Todas as credenciais e variáveis de ambiente são armazenadas em secrets do GitHub para maximizar a segurança.

