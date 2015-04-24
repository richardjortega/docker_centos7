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

echo installing development/networking tools and EPEL repos
yum install -y net-tools build-essential epel-release  >/dev/null 2>&1

# Some of these packages require EPEL repo (added earlier in build)
# Some packages are installed on base CentOS 7 but have been added to make sure
install Docker docker
install Go golang
install Vim vim
install Git git
install SQLite sqlite sqlite-devel

install Redis redis
systemctl enable redis
systemctl start redis

install 'Nokogiri/PostgreSQL dependencies' libxml2 libxml2-dev
install 'JS runtime' nodejs
yum clean all >/dev/null 2>&1

## Docker 1.6 has issue with networking and calling out to Rubygems
# echo updating docker to latest release
# wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/bin/docker
# chmod +x /usr/bin/docker

echo installing docker-compose
curl -L https://github.com/docker/compose/releases/download/1.2.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo install docker auto-completion
yum install bash-completion
wget https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker -O /etc/bash_completion.d/docker

echo adding docker service to systemctl
systemctl enable docker.service
systemctl start docker.service

echo installing Ruby 2.2.2 via RVM
su - vagrant -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3' >/dev/null 2>&1
su - vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.2' >/dev/null 2>&1
su - vagrant -c 'rvm rvmrc warning ignore allGemfiles' >/dev/null 2>&1
su - vagrant -c 'source /home/vagrant/.profile'
su - vagrant -c 'source /home/vagrant/.rvm/scripts/rvm'

echo installing bundler
su - vagrant -c 'gem install bundler'

echo installing Postgresql 9.2
yum -y install postgresql-server postgresql-contrib postgresql-devel >/dev/null 2>&1
postgresql-setup initdb
systemctl enable postgresql
systemctl start postgresql

echo -e "\n### Provisioned. Use 'vagrant ssh' to access the VM directly. ###\n\n"
