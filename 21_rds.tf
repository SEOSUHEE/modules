resource "aws_db_instance" "suhee_rds" {
  allocated_storage = var.storage_size
  storage_type = var.storage_type
  engine = var.sql_engine
  engine_version = var.mysql_version
  instance_class = var.instance_db
  name = "test"
  identifier = "test"
  username = var.username
  password =var.password
  parameter_group_name = "default.${var.sql_engine}${var.mysql_version}"
  availability_zone = "${var.region}${var.avazone[0]}"
  db_subnet_group_name = aws_db_subnet_group.suhee_dbsb.id
  vpc_security_group_ids = [aws_security_group.suhee_sg.id]
  skip_final_snapshot = true
  tags = {
    "Name" = "suhee-rds"
  }
}

resource "aws_db_subnet_group" "suhee_dbsb" {
  name = "suhee-dbsb-group"
  subnet_ids = [aws_subnet.suhee_pridb[0].id,aws_subnet.suhee_pridb[1].id]
  tags = {
    "Name" = "suhee-dbsb-gp"
  }
}