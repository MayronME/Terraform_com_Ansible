terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 0.14.9"
}
provider "aws" {
  profile = "default"
  region  = var.regiao_aws
}
resource "aws_launch_template" "maquina" { # Imagem da Maquina
  image_id      = "ami-08c40ec9ead489470"  
  instance_type = var.instancia            # Tipo de Maquina EX: t2.micro
  key_name      = var.chave                # SSH
  tags = {
    Name = "Terraform Ansible Python"      
  }
  security_group_names = [var.grupo_de_seguranca]
  
  user_data = var.producao ? filebase64("ansible.sh") : ""
}
resource "aws_key_pair" "chaveSSH" {
  key_name = var.chave
  public_key = file("${var.chave}.pub") 
}
resource "aws_autoscaling_group" "grupo" {
  availability_zones = ["${var.regiao_aws}a","${var.regiao_aws}b"]
  name     = var.nome_grupo
  max_size = var.maximo
  min_size = var.minimo
  launch_template {
    id = aws_launch_template.maquina.id
    version = "$Latest"
  }
  target_group_arns = [ aws_lb_target_group.alvoLoadBalancer.arn ]
}

resource "aws_default_subnet" "subnet_1" {
  availability_zone = "${var.regiao_aws}a"
}

resource "aws_default_subnet" "subnet_2" {
  availability_zone = "${var.regiao_aws}b"
}

resource "aws_lb" "loadBalancer" {
  internal = false
  subnets = [ aws_default_subnet.subnet_1.id,aws_default_subnet.subnet_2.id ]
}

resource "aws_lb_target_group" "alvoLoadBalancer" {
  name = "MaquinasAlvo"
  port = "8000"
  protocol = "HTTP"
  vpc_id = aws_default_vpc.default.id
}

resource "aws_lb_listener" "entradaLoadBalancer" {
  load_balancer_arn = aws_lb.loadBalancer.arn
  port = "8000"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alvoLoadBalancer.arn
  }
}

resource "aws_default_vpc" "default" {
  
}

resource "aws_autoscaling_policy" "escala_producao" {
  name = "terraform-escala"
  autoscaling_group_name = var.nome_grupo
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification{
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

