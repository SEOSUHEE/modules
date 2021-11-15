#인터넷게이트웨이

resource "aws_internet_gateway" "suhee_ig" {
  vpc_id = aws_vpc.suhee_vpc.id
  tags = {
    "Name" = "suhee-ig"
  }
}


resource "aws_route_table" "suhee_rt" {
  vpc_id = aws_vpc.suhee_vpc.id
  route {
    cidr_block = var.cidr_route
    gateway_id = aws_internet_gateway.suhee_ig.id
  }
  tags = {
    "Name" = "suhee-rt"
  }
}


resource "aws_route_table_association" "suhee_rtass" {
  count = length(var.cidr_public)
  subnet_id = aws_subnet.suhee_pub[count.index].id
  route_table_id = aws_route_table.suhee_rt.id  
}