/*
data "aws_ami" "amzn" {
  most_recent = 

  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
*/

resource "aws_instance" "suhee_weba" {
  ami ="ami-04e8dfc09b22389ad"
  instance_type = var.ec2_type
  key_name = var.key
  availability_zone = "${var.region}${var.avazone[0]}"
  private_ip = var.private_ip
  subnet_id = aws_subnet.suhee_pub[0].id
  vpc_security_group_ids = [aws_security_group.suhee_sg.id]
  user_data = file("./install.sh")
}

resource "aws_eip" "suhee_weba_ip" {
  vpc = true
  instance = aws_instance.suhee_weba.id  
  associate_with_private_ip = var.private_ip
  depends_on = [aws_internet_gateway.suhee_ig]
}