Inception Project – User Guide

1. Overview

This document provides instructions to use the virtual machine (VM) for the Inception project at 42 School. It is intended for users who only need to use the services this project offers. For details in how to setup and configure the Virtual Machine for this project, please read the READ_ME.md instructions.


1. Docker and Web Services

The Inception project deploys 3 Docker containers for the mandatory services: 
- WordPress : the PHP application
- Nginx : reverse proxy and TLS termination
- MariaDB : the database

2. Usage

Navigate to the project folder (where the Makefile is located):

cd ~/Inception

Start the mandatory services using the Makefile in the terminal:

```bash
make
```

Stop the services:

```bash
make clean
```

Remove volumes (data will be deleted):

```bash
make fclean
```

Remove ALL docker resources:

```bash
make sprune
```

3.  Check running services

- Show container status:

```bash
make ps
```

- See logs for all services:

```bash
make logs
```

4.  Access the site

After the services start, open a browser to:

- https://cmarrued.42.fr — WordPress site
- https://cmarrued.42.fr/wp-admin — WordPress login

Credentials are configured via secrets/.env file.

5. Locate and manage the credentials

On the secrets folder on the root project folder, there needs to be a file called .env, following this structure: 
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

Modify its values for the desired setup. If secrets and/or .env doesnt exist, create them.