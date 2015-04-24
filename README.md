## Swiftwater Development Environment

### Contains
- CentOS 7
- Ruby 2.2.2 via RVM
- PostgreSQL
- Docker and Docker Compose
- Vim
- Go
- Git
- SQLite3
- Redis
- NodeJS

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
```

### Post-install modifications
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

