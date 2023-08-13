# Create RDS subnet group
resource "aws_db_subnet_group" "RDS_subnet_grp" {
  name       = var.wordpressdb_subnet_grp
  subnet_ids = aws_subnet.private_db_subnets.*.id
}

# Create RDS instance
resource "aws_db_instance" "wordpress_db" {
  identifier              = var.primary_rds_identifier
  availability_zone       = var.az[0]
  allocated_storage       = 10
  engine                  = "mysql"
  engine_version          = "8.0.32"
  instance_class          = var.db_instance_type
  storage_type            = "gp2"
  db_subnet_group_name    = aws_db_subnet_group.RDS_subnet_grp.name
  vpc_security_group_ids  = [aws_security_group.db_server_sg.id]
  db_name                 = var.database_name
  username                = var.database_user
  password                = var.database_password
  skip_final_snapshot     = true
  backup_retention_period = 7

  # Make sure RDS ignores any manual password change
  lifecycle {
    ignore_changes = [password]
  }
}

# Create RDS instance replica
resource "aws_db_instance" "wordpress_db_replica" {
  replicate_source_db    = var.primary_rds_identifier
  identifier             = var.replica_rds_identifier
  availability_zone      = var.az[1]
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = var.db_instance_type
  storage_type           = "gp2"
  vpc_security_group_ids = [aws_security_group.db_server_sg.id]
  skip_final_snapshot    = true

  depends_on = [aws_db_instance.wordpress_db]
}


# Update values of userdata.tpl variables after grabbing RDS endpoint
data "template_file" "user_data" {
  template = file("${path.module}/userdata.tpl")
  vars = {
    db_username      = var.database_user
    db_user_password = var.database_password
    db_name          = var.database_name
    db_endpoint      = aws_db_instance.wordpress_db.endpoint
    efs_DNS          = aws_efs_file_system.wordpress_EFS.id
  }

  depends_on = [aws_db_instance.wordpress_db, aws_efs_file_system.wordpress_EFS, aws_efs_mount_target.efs_mount]
}