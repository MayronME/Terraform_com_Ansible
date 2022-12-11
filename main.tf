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

# Recurso_1 EC2
resource "aws_instance" "TESTE" {
    ami = "ami-0b0dcb5067f052a63"   #Amazon Linux
    instance_type = "t2.micro"      #Free Tier

    tags = {
      "name" = "Maquina de Teste"
    }
}