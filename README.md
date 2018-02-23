Git hub
=======
1. git clone https://github.com/litvinovandrew/php7-docker-skeleton.git .

Docker
======
1. Copy `.env.dist` to `.env` in root project directory
2. In `.env` change 1000 to own uid (`id` command in bash console)
3. Run `docker-compose up` to build images and run containers 
   To rebuild existing use : docker-compose build  docker-compose start
4. Now you can start and stop dockers with `docker-compose start` and `docker-compose stop`
5. Site should be available by "localhost" url.
6. Enter to main docker with `docker exec -it project-web bash` and `su www-data` after that to work with right permissions



Laravel
========
1)  composer create-project laravel/laravel=5.5 project
2)  open project/.env and set 
    DB_CONNECTION=mysql
    DB_HOST=mysql
    DB_PORT=3306
    DB_DATABASE=project
    DB_USERNAME=project
    DB_PASSWORD=project123
3) cd project
4) php artisan migrate 
5) Site is already available by address "http://localhost:11001/"


Laravel Admin
=============
1) composer require encore/laravel-admin 1.5.*
2) php artisan vendor:publish --provider="Encore\Admin\AdminServiceProvider"
3) php artisan admin:install
4) Admin part is already available by address "http://localhost:11001/admin"




   


MySql
=====
11) You can connect MySql docker by "mysql -u project -p project123 -P 10113" from outside the docker
