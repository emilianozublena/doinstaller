cd /etc/apache2/sites-available
echo "Ingresa el dominio del proyecto"
read project_domain
echo "Ingresa el email del contacto técnico"
read email
echo "Creando virtual hosts..."
sudo cat "<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        ServerAdmin $email
		ServerName $project_domain
		DocumentRoot /var/www/html/$project_domain/public
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>"
sudo a2ensite $project_domain.conf
sudo service apache2 reload