Inception Project – Developer Documentation

1. Overview

This document provides instructions for developers to set up, configure, and work with the Inception project. It complements USER_DOCUMENTATION.md by explaining internal structures and development workflows. For details in how to setup and configure the Virtual Machine for this project, please read the READ_ME.md instructions.


2. Project Structure

Clone the Inception repository:

git clone https://github.com/Zalexe/Inception.git Inception
cd Inception


Typical structure:

Inception/
├─ Makefile            # Entrypoint for Docker and project commands
├─ docker-compose.yml  # Docker service definitions
├─ src/                # Source files and WordPress setup
|└─ conf/               # Nginx, MariaDB configuration files
├─ secrets/            # Secret files with password and other setup files (.env)
└─ README.md


All development and container orchestration is handled via the Makefile.

3. Makefile Usage

The Makefile is the main tool for developers:

Command	Description
make	Build and start all containers (MariaDB, Nginx, WordPress)
make stop	Stop all containers
make clean	Remove containers and volumes
make logs	Tail logs for all containers

Developers should always use the Makefile instead of running docker-compose manually to maintain consistency. But, if needed, here are some useful docker commands you can use inside srcs:
- `docker compose ps` : see all running containers and their status
- `docker compose exec {service} bash` : access a container's terminal
- `docker compose logs {service}` : see logs from a specific service (nginx, wordpress, mariadb)
- `docker compose down` : stop all containers
- `docker compose restart {service}` : restart a service
- `docker volume ls` : list all volumes

4. Inspecting Containers

Check running services:

docker ps


Inspect logs of a specific container:

docker logs <container_name>


Execute a shell inside a container:

docker exec -it <container_name> bash

5. Configuration Files

Nginx: Located in nginx/conf/. Contains virtual host configuration for the WordPress site. You need a config file for the server service. You can take the default config of nginx and update it. Create a server on it, listening to port 443, and use SSL protocols TLSv1.2 or TLSv1.3. Create two locations on this server:
```bash
- server / {
    server_name $YOUR_SITE_URL;
}
- location / {
    try_files $uri $uri/ /index.php?$args;
}
- location ~ \.php$ {
    fastcgi_pass wordpress:9000;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;
}
```

MariaDB: Configured through conf/mariadb/. Database credentials and initialization scripts.

WordPress: In src/wordpress/. Themes, plugins, and wp-config.php are set up to match school requirements.

For debug you can redirect the log to /dev/stdout or /dev/stderr to access them through the log of your container.

Next you have to create a .env file, you need to create it in a folder named secret, at the root of the project. On this you have to fill these variables : 
```
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
SITE_URL=
ADMIN_USER=
ADMIN_PASSWORD=
ADMIN_EMAIL=
WP_USER=
WP_USER_EMAIL=
WP_USER_PASSWORD=
```
6. Setting Up the Domain

To access the site at https://<USER>.42.fr:

On your host machine, edit /etc/hosts and add:

<VM_IP> <USER>.42.fr

Make sure the <USER>.42.fr is the same url as the one in the .env file for <SITE_URL>.

Save and close. You can know the <VM_IP> by looking at the first line of the same file. It should be something like:
<VM_IP> localhost

Your browser will now resolve <USER>.42.fr to the VM.

7. Data Storage and Persistence

The project uses two volumes with bind mounts to store data on your machine:
- wp_data : stores WordPress files and configuration. Located at `/home/<USER>/data/wordpress`
- db_data : stores MariaDB database files. Located at `/home/<USER>/data/mariadb`

When you run `make fclean` or `make downv`, these directories and their data are deleted. If you run `make clean` or `make down`, containers stop but the data directories stay and keep your data safe. If you just restart containers, the data persists because the directories aren't deleted.

You can access your data directly on your machine by accessing those directories.