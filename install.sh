cd /var/www/html/
echo "Ingresa la carpeta del proyecto"
read project_folder
mkdir $project_folder
echo "Ingresa la dirección del repositorio (con usuario y contraseña) username:password"
read repository
echo "Clonando repositorio git..."
git clone $repository $project_folder
cd $project_folder
echo "Ejecutando composer update..."
composer update
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache
echo "Querés ejecutar las migraciones de laravel? (si/no)"
read laravel_migrations
if [ "$laravel_migrations" = "si" ]
then
	echo "Ejecutando migraciones de laravel..."
	php artisan migrate:refresh
fi
echo "Querés ejecutar las seeds de la db? (si/no)"
read database_seeds
if [ "$database_seeds" = "si" ]
then
	echo "Seedeando la base..."
	php artisan db:seed
fi
echo "Utilizas Passport? (si/no)"
read passport_bool
if [ "$passport_bool" = "si" ]
then
	echo "Creando clients de passport"
	php artisan passport:install
fi
echo "Instalado, recorda ejecutar virtual_hosts.sh"