resource "aws_instance" "my_ec2" {
  ami           = "ami-0c76bd4bd302b30ec"
  instance_type = "t2.micro"
  key_name      = "project_1"
  for_each      = toset(["jenkins-master", "jenkins-slave", "ansible"])

  vpc_security_group_ids = [aws_security_group.my_sg.id]
  subnet_id              = aws_subnet.Nam-public-subnet-01.id

  tags = {
    Name = each.key
  }
}