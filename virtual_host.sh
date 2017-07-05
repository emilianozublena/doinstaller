cd /etc/apache2/sites-available
echo "Ingresa el dominio del proyecto"
read project_domain
cp 000-default.conf $project_domain.conf
vi $project_domain.conf
#
#
# Acá hay que editar estas configuraciones en ese archivo creado
# ServerAdmin {tu_mail}
# ServerName {project_domain}
# DocumentRoot /var/www/html/{project_name}/public
#
#
sudo a2ensite $project_domain.conf
sudo service apache2 reload