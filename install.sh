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
mv .env.example .env
php artisan key:generate
echo "Copia la clave generada e ingresala"
read app_key
sed -i -- "s/{app_key}/$app_key/g" .env
echo "Ingresa la base de datos"
read database_name
sed -i -- "s/{database_name}/$database_name/g" .env
echo "Ingresa el usuario de la base de datos"
read database_username
sed -i -- "s/{database_username}/$database_username/g" .env
echo "Ingresa la contraseña de la base de datos"
read database_password
sed -i -- "s/{database_password}/$database_password/g" .env
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
	echo "Ingresa la secret key del client 1"
	read personal_secret
	sed -i -- "s/{personal_secret}/$personal_secret/g" .env
	echo "Ingresa la secret key del client 2"
	read password_secret
	sed -i -- "s/{password_secret}/$password_secret/g" .env
	sudo chown www-data:www-data storage/oauth-*.key
	sudo chmod 600 storage/oauth-*.key
fi
echo "Instalado, recorda ejecutar virtual_hosts.sh"