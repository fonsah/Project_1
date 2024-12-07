provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "ec2" {
    ami = "ami-0c76bd4bd302b30ec6"
    instance_type = "t2.micro"
    key_name = "project_1"
    security_groups = "my_sg"
    }


resource "security_group" "my_sg" {
    name = "my_sg"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}