## Swiftwater Development Environment

### Contains
- CentOS 7.1
  - Uses OpsCode Vagrant box: https://github.com/chef/bento
  - 40 GB dynamic size
  - 2 CPUs
  - 2 GB RAM
- Ruby 2.2.2 via RVM
- PostgreSQL
- Docker and Docker Compose
- Vim
- Go
- Git
- SQLite3
- Redis
- NodeJS
- NTP
  - Reconfigured to `us.pool.ntp.org`

### Getting Started
- Install Vagrant at https://www.vagrantup.com/
- Install VirtualBox
  - Vagrant will use VirtualBox as the hypervisor
- Install VirtualBox plugins for Vagrant (on your host OS)
  - `$ vagrant plugin install vagrant-vbguest`

### Setup Instructions

```bash
# Download this repo
$ git clone swiftwater_dev.git

# Go into the folder
$ cd swiftwater_dev

# Setup dev box
$ vagrant up

# Log into dev box
$ vagrant ssh

# After following "Post-install modifications" run the following
vagrant: $ su root
# Enter `vagrant` as password for `root`
root: $ docker-compose up
```

### Synced Folders
Synced folder resides at: `/vagrant`
- Vagrant will `rsync` all files/folders where the Vagrantfile is located to this folder

Recommended to create a folder called `apps` in this folder as it is already added to `.gitignore` that will sync to the VM. Store your repos or other items here.
- If you create an `apps` folder here, you can find it at `/vagrant/apps`


### Useful Docker Commands
All commands should be run from `root` user.

Quick Docker Reference:
  -


#### Standard Workflow:
Assumes you have a `Dockerfile` in your current folder
- Build an image (current directory)
  - `$ docker build -t <tag_name> .`
- Run a container (an instance of an image)

```bash
$ docker run -it --rm tag_name/imageID COMMAND
```

- Run multi-containers with `docker-compose`

Containers
```bash

# Run a container with

# Stop all containers and remove all containers
$ docker stop $(docker ps -aq) && docker rm $(docker ps -aq)
```

Images
```bash
# View all Docker images
$ docker images

# Remove all Docker images
$ docker stop $(docker ps -aq) && docker rm $(docker ps -aq)

# Remove Docker image by Image ID
$
```

### Post-install modifications
If you need root priveleges, the password for `root` is `vagrant`.

If you need to use a RDBMS you'll need to modify PostgreSQL for a new user and allow connections via passwords
```bash
$ sudo vi /var/lib/pgsql/data/pg_hba.conf
```

Find the lines that looks like this, near the bottom of the file:

**pg_hba.conf excerpt** (original)
```bash
# IPv4 local connections:
host    all             all             127.0.0.1/32            ident
# IPv6 local connections:
host    all             all             ::1/128                 ident
```
Then replace *ident* with *md5*, so they look like this:

**pg_hba.conf excerpt** (updated)
```bash
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
```

### Notes
- For production, run only `bootstrap.sh`

### License
MIT License

Author: Richard Ortega

