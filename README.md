*This project has been created as part of the 42 curriculum by cmarrued.*

## Description

**Inception** is a system administration and DevOps project whose goal is to design, build, and deploy a secure and modular web infrastructure using **Docker** and **Docker Compose**, entirely inside a **Virtual Machine**.

The project focuses on understanding containerization concepts, service isolation, networking, data persistence, and security best practices by deploying a complete WordPress stack from scratch.

All services are built manually using custom Dockerfiles based on lightweight Linux distributions, without relying on pre-built images.

## Project Goal

The objective is to deploy a functional WordPress website accessible through HTTPS only, while respecting strict technical and security constraints imposed by the subject.

The infrastructure must:
- Be fully containerized
- Use Docker Compose for orchestration
- Run inside a Virtual Machine
- Ensure data persistence and secure communication by NGINX service

## Instructions

1. VM Setup for Development

For development, the VM should be configured to match the production-like environment of the Inception project.

Recommended VM Configuration

OS: Debian 12 (Bookworm)

RAM: ≥ 4 GB

Disk: ≥ 20 GB

Virtualization: VirtualBox or VMware

Optional GUI: XFCE or GNOME for editing convenience

SSH: Enabled for remote access (optional for testing scripts)

1.1 System Setup
sudo apt update && sudo apt upgrade -y
sudo apt install sudo git wget curl vim build-essential -y


Add your developer user to sudoers:

sudo usermod -aG sudo <username>

2. Docker Development Environment

2.1 Required Services

The project uses the following mandatory services:

MariaDB

Nginx
cCCC
WordPress

2.2 Installing Docker

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb

URIs: https://download.docker.com/linux/debian

Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")

Components: stable

Signed-By: /etc/apt/keyrings/docker.asc

EOF

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker <username>


Log out and log back in for Docker group changes to take effect.
The VM is ready to be used for the project.


## Infrastructure Overview

The project is composed of the following services:

### NGINX
- Acts as the **only entry point** to the infrastructure
- Listens on **port 443 only**
- Uses **TLSv1.2 or TLSv1.3**
- Serves as a reverse proxy to WordPress

### WordPress + PHP-FPM
- Runs WordPress using **PHP-FPM**
- Does **not** include NGINX
- Communicates internally with MariaDB
- Stores website files in a Docker volume

### MariaDB
- Provides the database backend for WordPress
- Runs as an isolated service
- Stores data in a Docker volume
- No web server included

### Docker Network
- Ensures secure internal communication between containers
- Provides service name resolution
- Prevents direct external access to internal services

### Docker Volumes
- One volume for WordPress website files
- One volume for MariaDB database data
- Data persists even if containers are destroyed

## Design Choices and Comparisons

### Virtual Machines vs Docker

**Virtual Machines**
- Run a full operating system
- Heavy resource usage
- Slower startup times

**Docker Containers**
- Share the host kernel
- Lightweight and fast
- Not environment dependent

Docker is used inside a VM to combine strong isolation with container efficiency.
The Subject asks us to decide between 

### Secrets vs Environment Variables

**Environment Variables**
- Used for non-sensitive configuration
- Easy to manage and override
- Everybody on the machine has access to it

**Docker Secrets**
- Used for passwords and credentials
- Not stored in images or Git
- More secure by design

Sensitive data is never stored in Dockerfiles or the repository.

---

### Docker Network vs Host Network

**Host Network**
- No isolation
- Security risks

**Docker Network**
- Isolated communication
- Controlled access

A dedicated Docker network is mandatory and used for all services.

---

### Docker Volumes vs Bind Mounts

**Bind Mounts**
- Depend on host filesystem
- Risky permissions
- Less portable

**Docker Volumes**
- Managed by Docker
- Safer and cleaner
- Portable and persistent

Volumes are used for database and website persistence.

## Technologies Used

- Docker
- Docker Compose
- NGINX
- WordPress
- PHP-FPM
- MariaDB
- OpenSSL
- Debian Linux

## Resources

- Docker Documentation  
  https://docs.docker.com/
- Docker Compose Documentation  
  https://docs.docker.com/compose/
- Debian 12 installation 
  https://cdimage.debian.org/cdimage/archive/12.12.0/amd64/iso-cd/
- NGINX HTTPS Configuration  
  https://nginx.org/en/docs/http/configuring_https_servers.html
- WordPress Documentation  
  https://wordpress.org/support/

### AI Usage

AI tools were used to:
- Clarify technical concepts
- Validate architectural decisions
- Improve documentation structure and clarity

All configuration, implementation, and validation were performed manually.

