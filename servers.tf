#EC2_Key_Par
resource "aws_key_pair" "Key_Xadia" {
    key_name   = "Key_Xadia"
    public_key = file("~/.ssh/xadia.pub")
}

#EC2
resource "aws_instance" "TESTE" {
    ami = "ami-0b0dcb5067f052a63"   #Amazon Linux
    instance_type = "t2.micro"      #Free Tier
    key_name = aws_key_pair.Key_Xadia.key_name # Chave SSH
    tags = {
        Name = "Maquina de Teste"
    }
    depends_on = [
        aws_key_pair.Key_Xadia
    ]
}