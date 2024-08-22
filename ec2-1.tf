resource "aws_instance" "ec2-terraform1" { // nome controle terraform
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.small"
  tags = {
    Name = "ec2-terraform1-separado" // Não precisa ser igual - Nome que aparee no painel amazon
  }
}