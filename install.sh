cd /var/www/html/
echo "Ingresa la carpeta del proyecto"
read project_folder
mkdir $project_folder
echo "Ingresa la dirección del repositorio (con usuario y contraseña) username:password"
read repository
git clone $repository $project_folder
cd $project_folder
composer update
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache
echo "Instalado, recorda ejecutar virtual_hosts.sh"