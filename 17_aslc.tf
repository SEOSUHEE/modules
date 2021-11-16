resource "aws_ami_from_instance" "suhee_ami" {
  name = "suhee-ami"
  source_instance_id = aws_instance.suhee_weba.id
  depends_on = [
    aws_instance.suhee_weba
  ]
}


#autoscaling launch configuration , 시작구성
resource "aws_launch_configuration" "suhee_aslc" {
  name_prefix = "suhee-web*"
  image_id = aws_ami_from_instance.suhee_ami.id
  instance_type = var.ec2_type
  iam_instance_profile = "admin_role"
  security_groups = [aws_security_group.suhee_sg.id]
  key_name = var.key
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "suhee_asg" {
  name = "suhee-asg"
  min_size = 2
  max_size = 10
  health_check_grace_period = 10
  health_check_type = "EC2"
  desired_capacity = 2
  force_delete = true
  launch_configuration = aws_launch_configuration.suhee_aslc.name
  vpc_zone_identifier = [aws_subnet.suhee_pub[0].id,aws_subnet.suhee_pub[1].id]
}


#오토스케일링그룹을 alb에 attach 한다
resource "aws_autoscaling_attachment" "suhee_asfatt" {
  autoscaling_group_name = aws_autoscaling_group.suhee_asg.id
  alb_target_group_arn = aws_lb_target_group.suhee_albtg.arn  
}


#replace group
resource "aws_placement_group" "suhee_place" {
  name = "suhee-place"
  strategy = var.strategy 
}