O projeto consiste na criação de uma infra através do Terraform e implementação de um servidor Django utilizando o Ansible

Para executar o código e necessário ter o Terraform, Ansible e AWS CLI

Executando:
    -Entre na pasta Env/Prod 
    -Crie uma chave SSH com o nome de "IaC-Prod"
 obs: Caso queira mudar o caminho da chave ssh especifique dentro do arquivo  Env/Prod/main.tf no campo CHAVE

Execute terraform init
Execute o terraform apply para a criação da VM, Security Group e Key Par na AWS
E Aguarde a criação das dependências na aws

Após o termino da execução
Um output com o IP da maquina e fornecido que deverá ser colocado dentro do arquivo em infra/hosts.yml

Execute dentro da pasta Prod o comando playbook do Ansible


