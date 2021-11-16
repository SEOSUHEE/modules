resource "aws_eip" "suhee_eip_ng" {
  vpc = true
}


#여기서 만든 eip를 나트게이트웨이에 사용할 계획,
#private서브넷이 모두 하나의 아이피로 (나트게이트) 모이도록


resource "aws_nat_gateway" "suhee_ng" {
  allocation_id = aws_eip.suhee_eip_ng.id
  subnet_id = aws_subnet.suhee_pub[0].id
  tags = {
    "Name" = "suhee-ng"
  }
  depends_on = [
    aws_internet_gateway.suhee_ig
  ] 
}


resource "aws_route_table" "suhee_ngrt" {
  vpc_id = aws_vpc.suhee_vpc.id
  route {
    cidr_block = var.cidr_route
    gateway_id = aws_nat_gateway.suhee_ng.id
  }
  tags = {
      "Name" = "suhee-ngrt"
  }
}


resource "aws_route_table_association" "suhee_ngass" {
  count = length(var.cidr_private)
  subnet_id = aws_subnet.suhee_pri[count.index].id
  route_table_id = aws_route_table.suhee_ngrt.id
}

