provider "aws" {
  region = var.region
}


resource "aws_key_pair" "suhee_key" {
    key_name = var.key
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





