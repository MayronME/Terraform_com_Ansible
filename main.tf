# Iniciador do Terraform
terraform{ 
  required_providers{
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configuração do AWS Provedor
provider "aws"{
  region = "us-east-1"
}