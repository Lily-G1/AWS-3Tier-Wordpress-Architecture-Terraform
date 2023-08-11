# EFS ID
output "EFS_ID" {
  value = aws_efs_file_system.wordpress_EFS.id
}

# RDS endpoint
output "RDS_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}

# Loadbalancer DNS name
output "ALB_DNS" {
  value = aws_lb.wordpress_alb.dns_name
}

# NS records
output "name_servers" {
  value       = aws_route53_zone.wp_zone.name_servers
  description = "records of domain name servers"
}

# # REMOVE ALL BELOW WHEN DONE
# output "userdata_variables" {
#   value = {
#     db_username      = var.database_user
#     db_user_password = var.database_password
#     db_name          = var.database_name
#     db_endpoint      = aws_db_instance.wordpress_db.endpoint
#     efs_DNS          = aws_efs_file_system.wordpress_EFS.id
#   }
# }

# output "rendered_userdata" {
#   value = data.template_file.user_data.rendered
# }
