
Docker
======
1. Copy `.env.dist` to `.env` in root project directory
2. In `.env` change 1000 to own uid (`id` command in bash console)
3. Run `docker-compose up` to build images and run containers
4. Now you can start and stop dockers with `docker-compose start` and `docker-compose stop`
5. Site should be available by "localhost" url.
6. Enter to main docker with `docker exec -it lara-web bash` and `su www-data` after that to work with right permissions

Composer
========
10) run "composer install" command

MySql
=====
11) You can connect MySql docker by "mysql -u lara -p lara123 -P 10113" from outside the docker
