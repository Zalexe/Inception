Inception Project – User Guide
Quick Start

Follow these steps to quickly get your VM ready for the Inception project:

Create a new Debian 11 VM (netinst ISO, 4+ GB RAM, 20+ GB disk)

Install Debian with SSH server and optional GUI (XFCE or GNOME)

Update the system:

sudo apt update && sudo apt upgrade -y


Add your user to sudo:

sudo usermod -aG sudo <username>


Test SSH from host or terminal:

ssh <username>@<VM_IP> -p <port>


Install VS Code inside the VM (optional for editing):

sudo apt install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y


Install Docker (mandatory services) – see Section 7.

This Quick Start sets up the VM environment and gets you ready to launch the mandatory Inception services (MariaDB, Nginx, WordPress).

1. Overview

This document provides instructions to set up and use the virtual machine (VM) for the Inception project at 42 School. It is intended for users who need to run, test, or interact with the project, without focusing on development or internal architecture details.

2. VM Requirements

Operating System: Debian 11 (Bullseye) recommended

RAM: ≥ 4 GB

Disk: ≥ 20 GB

Virtualization: VirtualBox or VMware

Optional GUI: Lightweight desktop (XFCE or GNOME) recommended for editing code

3. Installing the VM
Step 1: Create a new VM

Open VirtualBox and click New.

Name your VM and choose Linux → Debian (64-bit).

Use default settings for memory and disk.

Click Create.

Step 2: Attach Debian ISO

Download Debian 11 netinst ISO from Debian website
.

Start the VM and select the ISO as boot media.

Step 3: Install Debian

Choose Manual Installer.

Follow default options for language, location, and keyboard.

Create a user account (you can use your 42 intra login).

Select Guided – use entire disk, all files in one partition.

Install the SSH server and standard system utilities.

Install GRUB bootloader on /dev/sda.

Complete installation and reboot the VM.

4. Initial VM Configuration
4.1 Update and Upgrade
su -
apt-get update && apt-get upgrade -y
apt-get install sudo -y

4.2 Add your user to sudo
adduser <username> sudo
# or
usermod -aG sudo <username>


Edit sudoers if needed:

sudo visudo

4.3 Configure SSH

Edit the SSH config:

sudo nano /etc/ssh/sshd_config


Optional: Change the port (default is 22). Example:

Port 4242


Restart SSH:

sudo systemctl restart ssh


Test SSH from host machine:

ssh <username>@<VM_IP> -p <port>


On Linux hosts at school, you can connect directly without NAT; on Windows, you may need port forwarding in VirtualBox.

5. Installing Optional GUI and VS Code

If you want a graphical environment:

sudo apt install task-xfce-desktop -y


Install VS Code inside the VM:

sudo apt update
sudo apt install wget gpg -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y

6. Using the VM

Terminal: Use for Docker, git, and project commands.

VS Code: Optional for editing code in a GUI.

SSH: Optional if connecting from another machine. Use the configured port and VM IP.

7. Docker and Web Services

The Inception project uses Docker containers for the mandatory services: MariaDB, Nginx, and WordPress. These containers are managed through a Makefile, which runs docker-compose under the hood.

7.1 Install Docker and Docker Compose
sudo apt install docker.io docker-compose -y
sudo usermod -aG docker <username>


Log out and log back in for Docker group changes to take effect.

7.2 Start the project

Navigate to the project folder (where the Makefile is located):

cd ~/inception-42/Inception_42


Start the mandatory services using the Makefile:

make


This will build the Docker images and start the containers for MariaDB, Nginx, and WordPress.

7.3 Check running services
docker ps


You should see containers for:

MariaDB

Nginx

WordPress

7.4 Access the services

Nginx / WordPress: http://<VM_IP>

MariaDB is used internally by WordPress

Ports and endpoints are configured in the Docker Compose setup.

8. Notes for Users

Always keep your system updated (sudo apt update && sudo apt upgrade).

Shared folders or mounted directories can simplify file access between host and VM.

Only the mandatory services (MariaDB, Nginx, WordPress) are required to run the project.