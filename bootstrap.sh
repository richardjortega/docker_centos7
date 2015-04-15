echo -e "\n### START: Provision CentOS 7 x64 with Docker ###\n"

# Inspired by rails-dev-box
# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    yum -y install "$@" >/dev/null 2>&1
}

echo updating package information
yum update -y >/dev/null 2>&1

echo installing development tools and docker
yum install -y docker net-tools golang build-essential vim epel-release  >/dev/null 2>&1
yum clean all >/dev/null 2>&1

# Some of these packages require EPEL repo (added earlier in build)
# Some packages are installed on base CentOS 7 but have been added to make sure
install Git git
install SQLite sqlite sqlite-devel
install Redis redis
install memcached memcached
install RabbitMQ rabbitmq-server
install PostgreSQL postgresql postgresql-devel
install MariaDB mariadb-server mariadb-devel
install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'JS runtime' nodejs

echo updating docker to latest release
wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/bin/docker >/dev/null 2>&1

echo installing docker-compose
curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose >/dev/null 2>&1
chmod +x /usr/local/bin/docker-compose

echo adding docker service to systemctl
systemctl enable docker.service >/dev/null 2>&1
systemctl start docker.service >/dev/null 2>&1

echo installing Ruby 2.2.1 via RVM
su - vagrant -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3' >/dev/null 2>&1
su - vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.1' >/dev/null 2>&1
su - vagrant -c 'rvm rvmrc warning ignore allGemfiles' >/dev/null 2>&1
su - vagrant -c 'source /home/vagrant/.profile'
su - vagrant -c 'source /home/vagrant/.rvm/scripts/rvm'

echo installing bundler
su - vagrant -c 'gem install bundler'

echo -e "\n### Provisioned. Use 'vagrant ssh' to access the VM directly. ###\n\n"
