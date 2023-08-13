# Security group for bastion/jump host
resource "aws_security_group" "jumphost_sg" {
  name        = "jumphost-SG"
  description = "Allow inbound SSH traffic for jumphost"
  vpc_id      = aws_vpc.project_vpc.id
}

# Allow SSH to bastion/jump host (ideally, access should be restricted to trusted IPs only)
resource "aws_security_group_rule" "jumphost_ssh_rule" {
  security_group_id = aws_security_group.jumphost_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow outbound traffic
resource "aws_security_group_rule" "jumphost_outbound_rule" {
  security_group_id = aws_security_group.jumphost_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# --------------------------------------------------

# Security group for elastic file system
resource "aws_security_group" "efs_sg" {
  name        = "efs-access"
  description = "Allow NFS traffic"
  vpc_id      = aws_vpc.project_vpc.id
}

resource "aws_security_group_rule" "nfs_rule" {
  security_group_id        = aws_security_group.efs_sg.id
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.efs_sg.id
}

# Allow outbound traffic
resource "aws_security_group_rule" "efs_outbound_rule" {
  security_group_id = aws_security_group.efs_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# -------------------------------------------------

# Security group for load balancer
resource "aws_security_group" "alb_sg" {
  name        = "alb-SG"
  description = "Allow HTTP(S) traffic for load balancer"
  vpc_id      = aws_vpc.project_vpc.id
}

# Allow HTTP & HTTPS traffic to load balancer
resource "aws_security_group_rule" "alb_HTTP_rule" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "alb_HTTPS_rule" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Allow outbound traffic
resource "aws_security_group_rule" "alb_outbound_rule" {
  security_group_id = aws_security_group.alb_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# ---------------------------------------------

# Security group for application servers
resource "aws_security_group" "app_server_sg" {
  name        = "app-server-SG"
  description = "Allow SSH & Internet traffic for instances in application tier"
  vpc_id      = aws_vpc.project_vpc.id
}

# Give jumphost SSH access to application servers
resource "aws_security_group_rule" "app_server_ssh_rule" {
  security_group_id        = aws_security_group.app_server_sg.id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.jumphost_sg.id
}

# Give load balancer HTTP & HTTPS access to application servers
resource "aws_security_group_rule" "app_server_alb_HTTP_rule" {
  security_group_id        = aws_security_group.app_server_sg.id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "app_server_alb_HTTPS_rule" {
  security_group_id        = aws_security_group.app_server_sg.id
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
}

# Allow outbound traffic
resource "aws_security_group_rule" "app_server_outbound_rule" {
  security_group_id = aws_security_group.app_server_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# -------------------------------

# Security group for database servers
resource "aws_security_group" "db_server_sg" {
  name        = "db-server-SG"
  description = "Allow inbound SSH traffic for instances in database tier"
  vpc_id      = aws_vpc.project_vpc.id
}

# Give application servers access to database servers
resource "aws_security_group_rule" "db_server_mysql_rule" {
  security_group_id        = aws_security_group.db_server_sg.id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_server_sg.id
}

# Allow outbound traffic
resource "aws_security_group_rule" "db_server_outbound_rule" {
  security_group_id = aws_security_group.db_server_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}