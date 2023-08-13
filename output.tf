# EFS ID
output "EFS_ID" {
  value = aws_efs_file_system.wordpress_EFS.id
}

# RDS endpoint
output "RDS_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

# Loadbalancer DNS URL
output "ALB_DNS" {
  value = aws_lb.wordpress_alb.dns_name
}

# Route53 name-servers
output "name_servers" {
  value       = aws_route53_zone.wp_zone.name_servers
  description = "records of domain name servers"
}
