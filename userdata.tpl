#!/bin/bash
# WORDPRESS INSTALLER

# Variables will be populated by terraform template
db_username=${db_username}
db_user_password=${db_user_password}
db_name=${db_name}
db_endpoint=${db_endpoint}
efs_DNS=${efs_DNS}


# Install LAMP 
apt update
apt install -y apache2 php libapache2-mod-php php-mysql mysql-server

# Change owner & permission of /var/www directory
usermod -a -G apache ubuntu
chown -R ubuntu:apache /var/www
chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;
systemctl restart apache2

# Install git and binutils (binutils is required for building DEB packages)
apt install -y git binutils
sleep 40

# Clone amazon-efs-utils from GitHub
git clone https://github.com/aws/efs-utils

# Build and install the amazon-efs-utils DEB package
cd efs-utils/
./build-deb.sh
apt-get -y install ./build/amazon-efs-utils*deb
sleep 40

# Mount EFS in wordpress directory
cd /var/www/html
mkdir wordpress/
mount -t efs -o tls ${efs_DNS}:/ /var/www/html/wordpress/

# Download & extract wordpress zip file
wget https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
rm latest.tar.gz

# Create wordpress configuration file and update database values
cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
sed -i "s/database_name_here/${db_name}/g" /var/www/html/wordpress/wp-config.php
sed -i "s/username_here/${db_username}/g" /var/www/html/wordpress/wp-config.php
sed -i "s/password_here/${db_user_password}/g" /var/www/html/wordpress/wp-config.php
sed -i "s/localhost/${db_endpoint}/g" /var/www/html/wordpress/wp-config.php