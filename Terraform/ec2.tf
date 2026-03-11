resource "aws_instance" "node_server" {

  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet.id

  vpc_security_group_ids = [
    aws_security_group.app_sg.id
  ]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install docker -y
              service docker start
              docker run -d -p 3000:3000 johnpiklis/devops-node-app:latest
              EOF

  tags = {
    Name = "devops-node-server"
  }
}