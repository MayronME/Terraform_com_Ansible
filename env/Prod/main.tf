module "aws-prod" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-east-1"
  chave = "IaC-Prod"
  grupo_de_seguranca = "Producao"
  minimo = 1
  maximo = 3
  nome_grupo = "Prod"
}

