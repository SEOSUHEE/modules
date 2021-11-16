resource "aws_security_group" "suhee_sg" {
  name = "Allow Basic"
  description = "${var.protocol_http1},${var.protocol_ssh},${var.protocol_icmp}"
  vpc_id = aws_vpc.suhee_vpc.id

  ingress = [
    {
      description      = "Allow HTTP"
      from_port        = var.port_http
      to_port          = var.port_http
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow SSH"
      from_port        = var.port_ssh 
      to_port          = var.port_ssh 
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow SQL"
      from_port        = var.port_mysql
      to_port          = var.port_mysql
      protocol         = var.protocol_tcp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    },
    {
      description      = "Allow ICMP"
      from_port        = var.port_zero
      to_port          = var.port_zero
      protocol         = var.protocol_icmp
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      description      = "ALL"
      from_port        = var.port_zero
      to_port          = var.port_zero
      protocol         = var.port_minus
      cidr_blocks      = [var.cidr_route]
      ipv6_cidr_blocks = [var.ipv6_cidr]
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ] 

  tags = {
    "Name" = "suhee-sg"
  }

}