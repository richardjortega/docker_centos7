## Swiftwater Development Environment

### Contains
- CentOS 7.1
  - Uses OpsCode Vagrant box: https://github.com/chef/bento
  - 40 GB dynamic size
  - 2 CPUs
  - 2 GB RAM
- Ruby 2.2.2 via RVM
- PostgreSQL
  - Databases created:
    - `swiftwater_production`
    - `swiftwater_dev`
    - `swiftwater_test`
- Docker and Docker Compose
- Vim
- Go
- Git
- SQLite3
- Redis
- NodeJS
- Tmux
- NTP
  - Reconfigured to `us.pool.ntp.org`

### Getting Started
- Install Vagrant at https://www.vagrantup.com/
- Install VirtualBox
  - Vagrant will use VirtualBox as the hypervisor
- Install VirtualBox plugins for Vagrant (on your host OS)
  - `$ vagrant plugin install vagrant-vbguest`

TODO: System will automatically spin up everything once the VM is started. xxx

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

#### Docker Cheat Sheet
https://github.com/wsargent/docker-cheat-sheet

### Post-install modifications
#### Root info
If you need root priveleges, the password for `root` is `vagrant`.

#### PostgreSQL information
If you need to use a RDBMS you'll need to modify PostgreSQL for a new user and allow connections via passwords

##### Setup user with password
First get switch to user `root`
```bash
$ su root
```

Then switch to user `postgres`
```bash
$ su postgres
```

Create user in PostgreSQL with `root` with a password
```bash
bash-4.2$ createuser --superuser --pwprompt root

# Type password, then exit to switch back to vagrant user
```

Setup database
```bash
$ rake db:setup
```

### Notes
- For production, run only `bootstrap.sh`

### License
MIT License

Author: Richard Ortega

