resource "aws_lb" "suhee_alb" {
  name = "suhee-alb"
  internal = false
  load_balancer_type = var.load_type 
  security_groups = [aws_security_group.suhee_sg.id]
  subnets = [aws_subnet.suhee_pub[0].id,aws_subnet.suhee_pub[1].id]
  tags = {
    "Name" = "suhee-alb"
  }
}

#타겟그룹의 환경설정
resource "aws_lb_target_group" "suhee_albtg" {
  name = "suhee-albtg"
  port = var.port_http
  protocol = var.protocol_http2
  vpc_id = aws_vpc.suhee_vpc.id

  health_check {
    protocol = var.protocol_http2
    path = "/index.html"
    port = "traffic-port"
    enabled = true
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 2
    interval = 15
    matcher = "200"
  }
}

resource "aws_lb_listener" "suhee_albli" {
  load_balancer_arn = aws_lb.suhee_alb.arn
  port = var.port_http
  protocol = var.protocol_http2
#arn??
default_action {
  type = "forward"
  target_group_arn = aws_lb_target_group.suhee_albtg.arn  
  }
}

#환경설정을 attach한다
resource "aws_lb_target_group_attachment" "suhee_tgatt" {
  target_group_arn = aws_lb_target_group.suhee_albtg.arn
  target_id = aws_instance.suhee_weba.id
  port = var.port_http
}