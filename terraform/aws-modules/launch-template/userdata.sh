#!/usr/bin/env bash
HASH=$(openssl rand -base64 64 | tr -cd '[:alnum:]._-' | cut -c1-16)
sudo hostnamectl set-hostname ckc-dev-web-asg${HASH}
sudo yum install -y amazon-linux-extras
sudo amazon-linux-extras install epel -y
sudo yum update -y
sudo amazon-linux-extras enable php8.0
sudo yum install -y jq httpd mariadb php php-fpm php-gd php-mysqlnd
sed -i 's/nobody/apache/g' /etc/php-fpm.d/www.conf
sudo systemctl enable --now php-fpm
sudo systemctl enable --now httpd
INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone | sed 's/.$//')
CATEGORY=$(aws ec2 describe-tags --region ${REGION} --filters "Name=resource-id,Values=${INSTANCE_ID}" "Name=key,Values=category" | jq -r ".[]|.[]|.Value")
ENDPOINT=$(aws rds describe-db-clusters --region ${REGION} | jq -r '.[]|.[]|select(.DBClusterIdentifier=="cko-dc-dev-rds")|.Endpoint')
sudo aws ec2 create-tags --region ${REGION} --resources ${INSTANCE_ID} --tags Key=Name,Value="ckc-dev-app-${CATEGORY}-asg-${HASH}"
cd /tmp/
wget -q https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz -C /var/www/html/
rm -f /tmp/latest.tar.gz
sudo chown -R apache: /var/www/html/
DB_NAME="wordpress"
DB_USER="wordpress-admin"
DB_PASSWORD=$(aws secretsmanager get-secret-value --region ${REGION} --secret-id ckc-dc-secret | jq -r '.SecretString' | jq -r '.[]|select(.Key=="db_password")|.Value')
WP_PASSWORD=$(aws secretsmanager get-secret-value --region ${REGION} --secret-id ckc-dc-secret | jq -r '.SecretString' | jq -r '.[]|select(.Key=="wp_password")|.Value')
if mysql -h ${ENDPOINT} -u ckc_dc_admin -p'65Fm#&P3#qv37ObDJf' -e 'show databases;'; then
    mysql -h ${ENDPOINT} -u ckc_dc_admin -p'65Fm#&P3#qv37ObDJf' -e "SET PASSWORD FOR 'ckc_dc_admin'@'%' = PASSWORD(\"${DB_PASSWORD}\");FLUSH PRIVILEGES;"
    mysql -h ${ENDPOINT} -u ckc_dc_admin -p"$DB_PASSWORD" <<MYSQL_SCRIPT
    CREATE DATABASE wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;
    DELETE FROM mysql.user WHERE user='wordpress-admin' AND host = '%';
    FLUSH PRIVILEGES;
    CREATE USER 'wordpress-admin'@'%';
    GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress-admin'@'%' IDENTIFIED BY "${WP_PASSWORD}";
    FLUSH PRIVILEGES;
    cd /var/www/html/wordpress
    sed -e "s/localhost/${ENDPOINT}/" -e "s/database_name_here/"${DB_NAME}"/" -e "s/username_here/"${DB_USER}"/" -e "s/password_here/"${WP_PASSWORD}"/" wp-config-sample.php > wp-config.php
    echo "
    <VirtualHost *:80>
    DocumentRoot "/var/www/html/wordpress"
    DirectoryIndex index.php
    Options FollowSymLinks
    ErrorLog logs/wordpress-error_log
    CustomLog logs/wordpress-access_log common
    <FilesMatch \.php$>
        #SetHandler \"proxy:fcgi://127.0.0.1:9000\"
        SetHandler \"proxy:unix:/run/php-fpm/www.sock|fcgi://localhost/\"
    </FilesMatch>
    </VirtualHost>
    " >>/etc/httpd/conf/httpd.conf
    echo "
    # BEGIN WordPress
    <IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^index\.php$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
    </IfModule>
    # END WordPress

    " >> /var/www/html/wordpress/.htaccess
    sudo chown -R apache: /var/www/html/
    sudo systemctl enable --now httpd
    sudo systemctl stop httpd
    sudo systemctl stop php-fpm
MYSQL_SCRIPT
else
    cd /var/www/html/wordpress
    sed -e "s/localhost/${ENDPOINT}/" -e "s/database_name_here/"${DB_NAME}"/" -e "s/username_here/"${DB_USER}"/" -e "s/password_here/"${WP_PASSWORD}"/" wp-config-sample.php > wp-config.php
    echo "
    <VirtualHost *:80>
    DocumentRoot \"/var/www/html/wordpress\"
    DirectoryIndex index.php
    Options FollowSymLinks
    ErrorLog logs/wordpress-error_log
    CustomLog logs/wordpress-access_log common
    <FilesMatch \.php$>
        #SetHandler \"proxy:fcgi://127.0.0.1:9000\"
        SetHandler \"proxy:unix:/run/php-fpm/www.sock|fcgi://localhost/\"
    </FilesMatch>
    </VirtualHost>
    " >>/etc/httpd/conf/httpd.conf
    echo "
    # BEGIN WordPress
    <IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^index\.php$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
    </IfModule>
    # END WordPress

    " >>/var/www/html/wordpress/.htaccess
    sudo chown -R apache: /var/www/html/
    sudo systemctl enable --now httpd
    sudo systemctl stop httpd
    sudo systemctl stop php-fpm
fi

# sed -i "s/test/test_asg_${HASH}/g" /etc/promtail/config-promtail.yml
# yum update -y --nogpgcheck &>>/var/log/autoscaling.log
# systemctl enable --now nginx &>>/var/log/autoscaling.log
# systemctl enable --now promtail &>>/var/log/autoscaling.log
# systemctl enable --now node_exporter &>>/var/log/autoscaling.log
reboot
