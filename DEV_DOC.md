Inception Project – Developer Documentation
1. Overview

This document provides instructions for developers to set up, configure, and work with the Inception project. It complements USER_DOCUMENTATION.md by explaining internal structures, Docker setup, and development workflows.

2. VM Setup for Development

For development, the VM should be configured to match the production-like environment of the Inception project.

Recommended VM Configuration

OS: Debian 11 (Bullseye)

RAM: ≥ 4 GB

Disk: ≥ 20 GB

Virtualization: VirtualBox or VMware

Optional GUI: XFCE or GNOME for editing convenience

SSH: Enabled for remote access (optional for testing scripts)

2.1 System Setup
sudo apt update && sudo apt upgrade -y
sudo apt install sudo git wget curl vim build-essential -y


Add your developer user to sudoers:

sudo usermod -aG sudo <username>

3. Project Structure

Clone the Inception repository:

git clone https://github.com/Forstman1/inception-42.git ~/inception-42
cd ~/inception-42/Inception_42


Typical structure:

Inception_42/
├─ Makefile            # Entrypoint for Docker and project commands
├─ docker-compose.yml  # Docker service definitions
├─ src/                # Source files and WordPress setup
├─ conf/               # Nginx, MariaDB configuration files
└─ README.md


All development and container orchestration is handled via the Makefile.

4. Docker Development Environment
4.1 Required Services

The project uses the following mandatory services:

MariaDB

Nginx

WordPress

4.2 Installing Docker
sudo apt install docker.io docker-compose -y
sudo usermod -aG docker <username>


Log out and log back in for Docker group changes to take effect.

4.3 Makefile Usage

The Makefile is the main tool for developers:

Command	Description
make	Build and start all containers (MariaDB, Nginx, WordPress)
make stop	Stop all containers
make clean	Remove containers and volumes
make logs	Tail logs for all containers

Developers should always use the Makefile instead of running docker-compose manually to maintain consistency.

4.4 Inspecting Containers

Check running services:

docker ps


Inspect logs of a specific container:

docker logs <container_name>


Execute a shell inside a container:

docker exec -it <container_name> bash

5. Configuration Files

Nginx: Located in conf/nginx/. Contains virtual host configuration for the WordPress site.

MariaDB: Configured through conf/mariadb/. Database credentials and initialization scripts.

WordPress: In src/wordpress/. Themes, plugins, and wp-config.php are set up to match school requirements.

Developers should update these files inside the VM or via mounted volumes.

6. Development Workflow

Start the VM (Debian 11)

Navigate to project folder:

cd ~/inception-42/Inception_42


Build and start containers:

make


Edit files inside VM or via VS Code (optional GUI)

Test changes:

Visit WordPress via http://<VM_IP>

Check database changes in MariaDB

Stop containers when done:

make stop

7. Notes for Developers

Use Makefile for all container management

Keep VM and Docker images updated (sudo apt update && sudo apt upgrade, docker pull)

Always test WordPress changes in the VM before submitting to school evaluation

Shared folders can be used to sync local files with the VM

This prototype sets up the developer-facing documentation:

Focus on VM internals and development workflow

Explains Makefile and Docker usage

Maintains references to mandatory services only