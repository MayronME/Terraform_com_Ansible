module "aws-dev" {
  source = "../../infra"
  instancia = "t2.micro"
  regiao_aws = "us-east-2"
  chave = "IaC-DEV"
  grupo_de_seguranca = "DEV"
  minimo = 0
  maximo = 1
  nome_grupo = "Desenvolv"
}

