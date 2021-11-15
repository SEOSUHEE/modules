provider "aws" {
  region = var.region
}


resource "aws_key_pair" "suhee_key" {
    # key_name = "suhee1-key"
    key_name = var.key
    # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDZH1koEdJVL7WmWRlIscYXPn39SrtKDdTdfoADplUKdl+mlhtUfoqwfclsrUDbjptGH0iqGQl2kVVZNGhpBN1x2UI8n+K6a2ZBhNNYWUQ21cf235VinnGtyzcYS8U/AwbQloXg3wn5uel68Og+SrTbheti0DU3EWH481yuxmUjx/DqrWrbC0v8Jkl7gfRTezPUkLymzcX5x6PJlkH9SfAhay187Gr+LKiAbACojMriorGlAPASqcl0z/1r9MptrrvZV+GXovQAVSk8rjfezzSaubU3xZMTHxxUK9Nspw1YYLUDqUXi4t+Q8ue8D966Wd7Mhm9MuKuESszr4L1LmuCMDYZ0PVwBXPUGbklwjsX8W+RuhGYcbkpmMlQQzbZbETEtZrv8UKPes7sqmamGcqC6wmc72uQop9Mb6ShWe8bhd7GL2vHdFqgLixJZisBoBoV7jwdVNkoESBC+tB/6vLSs+/SlOoIEASjtju7Hqp+4XVUhhcT1UC1KtWE4gGRGLqc="
    public_key = file("../../.ssh/suhee-key.pub")
}


resource "aws_vpc" "suhee_vpc" {
    cidr_block = var.cidr_main
    enable_dns_support =true
    enable_dns_hostnames = true
}
#${var.name} 부분적으로 변수를 적용하는 방법


# public subnet
resource "aws_subnet" "suhee_pub" {
  count = length(var.cidr_public) 
  vpc_id = aws_vpc.suhee_vpc.id
  cidr_block = var.cidr_public[count.index]
  availability_zone = "${var.region}${var.avazone[count.index]}"
}
# private subnet
resource "aws_subnet" "suhee_pri" {
  count = length(var.cidr_private)
  vpc_id = aws_vpc.suhee_vpc.id
  cidr_block = var.cidr_private[count.index]
  availability_zone = "${var.region}${var.avazone[count.index]}"
}
# DB 서브넷
resource "aws_subnet" "suhee_pridb" {
  count = length(var.cidr_privatedb)
  vpc_id = aws_vpc.suhee_vpc.id
  cidr_block = var.cidr_privatedb[count.index]
  availability_zone = "${var.region}${var.avazone[count.index]}"
}





